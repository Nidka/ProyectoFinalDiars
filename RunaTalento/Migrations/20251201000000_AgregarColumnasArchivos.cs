using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RunaTalento.Migrations
{
    /// <inheritdoc />
    public partial class AgregarColumnasArchivos : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
   // Agregar columna ArchivoUrl a la tabla Actividad
          migrationBuilder.AddColumn<string>(
    name: "ArchivoUrl",
            table: "Actividad",
   type: "nvarchar(255)",
       maxLength: 255,
 nullable: true);

            // Agregar columna UrlDocumento a la tabla ActividadEstudiante
            migrationBuilder.AddColumn<string>(
      name: "UrlDocumento",
  table: "ActividadEstudiante",
   type: "nvarchar(max)",
nullable: true);
      }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            // Eliminar columna ArchivoUrl de la tabla Actividad
   migrationBuilder.DropColumn(
          name: "ArchivoUrl",
                table: "Actividad");

            // Eliminar columna UrlDocumento de la tabla ActividadEstudiante
          migrationBuilder.DropColumn(
  name: "UrlDocumento",
   table: "ActividadEstudiante");
        }
    }
}

