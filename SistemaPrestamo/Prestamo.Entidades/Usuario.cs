﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prestamo.Entidades
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreCompleto { get; set; } = null!;
        public string Correo { get; set; } = null!;
        public string Clave { get; set; } = null!;
        public string Rol { get; set; } = null;
        public int FailedAttempts { get; set; }
        public DateTime? LastFailedAttempt { get; set; }
        public DateTime? LockoutEnd { get; set; }
        public bool IsLocked { get; set; }
    }
}
