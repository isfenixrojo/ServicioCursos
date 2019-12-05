var webserUrl = 'http://localhost:9297/WSServicioCursos.asmx';
                 


$(function () {
    Todos();
    GraficaChart();
});

function Todos() {
    $("#divTablaChart").empty();

    var soapRequest = '<?xml version="1.0" encoding="utf-8"?>' +
        '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
        '<soap:Body>' +
        '<GetAllAlumnos xmlns="http://tempuri.org/" />' +
        '</soap:Body>' +
        '</soap:Envelope>';



    var html = '<table id="tabCursos" class="table table-bordered">' +
        '<thead>' +
        '<tr>' +
        '<th>Id</th>' +
        '<th>Nombre</th>' +
        '<th>Apellido</th>' +
        '<th>Calificacion</th>' +
        '<th>Materia</th>' +
        '</tr>' +
        '</thead>' +
        '<tbody>';

    $.ajax({
        type: "POST",
        url: webserUrl,
        contentType: "text/xml",
        dataType: "xml",
        data: soapRequest,
        crossDomain: true,
        success:
        function (xml, textStatus, errorThrown) {
            $(xml).find("Alumno").each(function () {

                var id = $(this).find("NumeroControl").text();
                var nombre = $(this).find("NombreAlumno").text();
                var apellido = $(this).find("ApellidoPaterno").text();
                var calificacion = $(this).find("Calificacion").text();
                var materia = $(this).find("Nombre_Materia").text();

                console.log("Id_Alummno: " + id +
                    "\nNombre: " + nombre +
                    "\nApellido: " + apellido +
                    "\nCalificacion: " + calificacion +
                    "\nMateria: " + materia);


                html += '<tr>' +
                    '<td>' + id + '</td>' +
                    '<td>' + nombre + '</td>' +
                    '<td>' + apellido + '</td>' +
                    '<td>' + calificacion + '</td>' +
                    '<td>' + materia + '</td>' +
                    '</tr >';

            });
            html += '</tbody></table>';
            $(".divTablaChart").html(html);
            $('#tabCursos').dataTable();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("Status: " + textStatus); alert("Error: " + errorThrown);
        }
    });
}

function GraficaChart() {

    $("#divTablaChart").empty();
    var ctx = $("#myChart");
    var arrMateria = [];
    var arrCantidadAlumnos = [];

    var soapRequest = '<?xml version="1.0" encoding="utf-8"?>' +
        '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
        '<soap:Body>' +
        '<GetMateriaAlumnos xmlns="http://tempuri.org/" />' +
        '</soap:Body>' +
        '</soap:Envelope>';

    $.ajax({
        type: "POST",
        url: webserUrl,
        contentType: "text/xml",
        dataType: "xml",
        data: soapRequest,
        crossDomain: true,
        success:
        function (xml, textStatus, errorThrown) {
            $(xml).find("MateriaAlumnos").each(function () {
                var nombre_Materia = $(this).find("Nombre_Materia").text();
                var cantida_Alumnos = $(this).find("Cantida_Alumnos").text();

                arrMateria.push(nombre_Materia);
                arrCantidadAlumnos.push(cantida_Alumnos);
            });
            var myChart = new Chart(ctx, {
                type: 'doughnut', //doughnut line bar
                data: {
                    labels: arrMateria,
                    datasets: [{
                        label: 'Cursos Alumnos',
                        data: arrCantidadAlumnos,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(9, 45, 186, 0.2)',
                            'rgba(22, 169, 89, 0.2)',
                            'rgba(255, 159, 64, 0.2)'

                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(75, 192, 182, 1)',
                            'rgba(89, 45, 186, 1)',
                            'rgba(153, 102, 285, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("Status: " + textStatus); alert("Error: " + errorThrown);
        }
    });





}
