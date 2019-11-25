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
    public class HealthController : ControllerBase
    {
        // GET api/values
        [HttpGet]
        public IActionResult Get()
        {
            Console.WriteLine("Processing: '" + Request.GetDisplayUrl() + "'");
            return (Ok());
        }
    }
}
