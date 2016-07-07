// $(document).ready(function(){
//   // function generateBarChart(dataArrays, chartLabel) {
//   function generateBarChart() {
//     var options = {
//         scales: {
//             yAxes: [{
//                 display: true,
//                 ticks: {
//                     beginAtZero: true
//                 },
//             }]
//         }
//     };
//     var data = {
//         labels:["one", "two", "three", "four"], // was data array 0
//         datasets: [
//             {
//                 label: "first", //was chart label
//                 backgroundColor: "rgba(255,99,132,0.2)",
//                 borderColor: "rgba(255,99,132,1)",
//                 borderWidth: 1,
//                 hoverBackgroundColor: "rgba(255,99,132,0.4)",
//                 hoverBorderColor: "rgba(255,99,132,1)",
//                 data: [1, 2, 3, 4], //was data array 1
//             }
//         ]
//     };
//
//     var element = document.getElementById('chart').getContext('2d');
//
//     new Chart(element, {
//     type: 'bar',
//     data: data,
//     options: options,
//     });
//   }
//
//   // function generatePieChart(dataArrays, chartLabel) {
//   function generatePieChart() {
//     var data = {
//         labels: ["one", "two", "three", "four"], //dataArrays[0],
//         datasets: [
//             {
//                 data: [1, 2, 3, 4],//dataArrays[1],
//                 backgroundColor: [
//                     "#FF6384",
//                     "#36A2EB",
//                     "#FFCE56"
//                 ],
//                 hoverBackgroundColor: [
//                     "#FF6384",
//                     "#36A2EB",
//                     "#FFCE56"
//                 ]
//             }]
//     };
//     var element = document.getElementById('chart').getContext('2d');
//
//     new Chart(element,{
//         type: 'doughnut',
//         data: data,
//
//     });
//   }
//
//   function findNeighborhoods() {
//   $('#menu').on('click', '#submit-button', function() {
//     address1 = $("#Address_1").val();
//     address2 = $("#Address_2").val();
//     address3 = $("#Address_3").val();
//     clearNeighborhooods();
//     clearMarkers();
//     getNeighborhoods(address1, address2, address3);
//     renderAddresses(address1, address2, address3);
//   });
// }
//
//   function getAnaytics () {
//     $.ajax({
//      type: "GET",
//      url: "/api/v1/neighborhoods/",
//      data: {
//          Address_1: address1,
//          Address_2: address2,
//          Address_3: address3,
//      },
//      dataType: "json",
//      success: function(data) {
//        spinner.stop();
//        appendNeighborhoods(data);
//      }
//    });
//  }
//
//   function clearChart() {
//     $('#chart').remove();
//     $('#chartDiv').append('<canvas id="chart" width="300" height="200"></canvas>');
//   }
//
//   $('#birth').on('click', function (e) {
//     clearChart()
//     // generateBarChart(gon.birth_arrays, 'Robot Year of Birth');
//     generateBarChart();
//   });
//   $('#hire').on('click', function (e) {
//     clearChart()
//     // generateBarChart(gon.hire_arrays, 'Robot Year of Hire');
//     generateBarChart();
//
//   });
//   $('#city').on('click', function (e) {
//     clearChart()
//     // generateBarChart(gon.city_arrays, 'Robot City');
//     generateBarChart();
//
//   });
//   $('#state').on('click', function (e) {
//     clearChart()
//     // generateBarChart(gon.state_arrays, 'Robot State');
//     generateBarChart();
//
//   });
//   $('#dept').on('click', function (e) {
//     clearChart()
//     // generatePieChart(gon.dept_arrays, 'Robot Department');
//     generatePieChart();
//
//   });
//
// });
