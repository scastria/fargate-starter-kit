using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Amazon.SecretsManager;
using Amazon.SecretsManager.Model;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using Shared.Models;

namespace Service.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PasswordsController : ControllerBase
    {
        private const string SECRET_ID = "DecryptorRDSPassword";
        private const string USERNAME_SECRET = "username";
        private const string PASSWORD_SECRET = "password";

        private string _username = null;
        private string _password = null;

        // GET api/values
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Password>>> Get()
        {
            Console.WriteLine("Processing: '" + Request.GetDisplayUrl() + "'");
            await GetDBCredentials();
            List<Password> retVal = null;
            using (DataContext dc = new DataContext(_username, _password)) {
                retVal = await dc.Passwords.OrderBy(p => p.Id).ToListAsync();
            }
            return (retVal);
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Password>> Get(int id)
        {
            Console.WriteLine("Processing: '" + Request.GetDisplayUrl() + "'");
            await GetDBCredentials();
            Password retVal = null;
            using (DataContext dc = new DataContext(_username, _password)) {
                retVal = await dc.Passwords.Where(p => p.Id == id).FirstOrDefaultAsync();
            }
            if (retVal == null)
                return (NotFound());
            return (retVal);
        }

        private async Task GetDBCredentials()
        {
            if (!string.IsNullOrWhiteSpace(_username))
                return;
            JObject secretInfo = null;
            using (AmazonSecretsManagerClient sm = new AmazonSecretsManagerClient()) {
                GetSecretValueResponse secret = await sm.GetSecretValueAsync(new GetSecretValueRequest {
                    SecretId = SECRET_ID
                });
                secretInfo = JObject.Parse(secret.SecretString);
            }
            _username = secretInfo.Value<string>(USERNAME_SECRET);
            _password = secretInfo.Value<string>(PASSWORD_SECRET);
        }
    }
}
