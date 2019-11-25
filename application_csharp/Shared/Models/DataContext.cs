using System;
using Microsoft.EntityFrameworkCore;

namespace Shared.Models
{
    public class DataContext : DbContext
    {
        public virtual DbSet<Password> Passwords { get; set; }

        private const string RDS_HOST = "placeholder";

        private string _username = null;
        private string _password = null;

        public DataContext(string username, string password)
        {
            _username = username;
            _password = password;
        }

        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
                optionsBuilder.UseNpgsql("Host=" + RDS_HOST + ";Database=decryptor;Username=" + _username + ";Password=" + _password);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.6-servicing-10079");

            modelBuilder.Entity<Password>(entity =>
            {
                entity.ToTable("passwords");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Decrypt)
                    .HasColumnName("decrypt")
                    .HasColumnType("character varying");

                entity.Property(e => e.Hash)
                    .IsRequired()
                    .HasColumnName("hash")
                    .HasColumnType("character varying");

                entity.Property(e => e.Plain)
                    .IsRequired()
                    .HasColumnName("plain")
                    .HasColumnType("character varying");
            });
        }
    }
}
