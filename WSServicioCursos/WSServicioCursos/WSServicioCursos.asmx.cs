using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using SWServicioCursos.modelo;
namespace WSServicioCursos
{
    /// <summary>
    /// Descripción breve de WSServicioCursos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WSServicioCursos : System.Web.Services.WebService
    {

        [WebMethod(Description = "Selecciona todo los alumnos.")]
        public List<Alumno> GetAllAlumnos()
        {
            List<Alumno> datosMateria = new List<Alumno>();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CS-AV"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("sp_GetAllAlumnos", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var _datosMateria = new Alumno
                            {
                                AlumnoId = Convert.ToInt32(dr["AlumnoId"]),
                                NumeroControl = dr["NumeroControl"].ToString(),
                                NombreAlumno = dr["NombreAlumno"].ToString(),
                                ApellidoPaterno = dr["ApellidoPaterno"].ToString(),
                                ApellidoMaterno = dr["ApellidoMaterno"].ToString(),
                                CorreoAlumno = dr["CorreoAlumno"].ToString(),
                                Providencia = dr["Providencia"].ToString(),
                                Calificacion = dr["Calificacion"].ToString(),
                                Nombre_Materia = dr["Nombre_Materia"].ToString(),
                                Activo = Convert.ToBoolean(dr["Activo"].ToString()) 

                            };
                            datosMateria.Add(_datosMateria);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return datosMateria;
        }

        [WebMethod(Description = "Selecciona las materias y el numero de alumnos que cursa.")]
        public List<MateriaAlumnos> GetMateriaAlumnos()
        {
            List<MateriaAlumnos> datosMateria = new List<MateriaAlumnos>();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CS-AV"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("sp_GetCantidadAlumnosMateria", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var _datosMateria = new MateriaAlumnos
                            {
                                Id_Materia = Convert.ToInt32(dr["Id_Materia"]),
                                Nombre_Materia = dr["Nombre_Materia"].ToString(),
                                Cantida_Alumnos = dr["Cantida_Alumnos"].ToString()
                            };
                            datosMateria.Add(_datosMateria);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return datosMateria;
        }
    }
}
