using System;
using System.Collections.Generic;

namespace Shared.Models
{
    public class Password
    {
        public string Plain { get; set; }
        public string Hash { get; set; }
        public string Decrypt { get; set; }
        public int Id { get; set; }
    }
}
