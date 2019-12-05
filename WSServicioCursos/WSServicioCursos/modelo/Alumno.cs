using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SWServicioCursos.modelo
{
    public class Alumno
    {
        public int AlumnoId { get; set; }
        public string NumeroControl { get; set; }
        public string NombreAlumno { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string CorreoAlumno { get; set; }
        public string Providencia { get; set; }
        public string Calificacion { get; set; }
        public string Nombre_Materia { get; set; }
        public bool Activo { get; set; }

    }
}