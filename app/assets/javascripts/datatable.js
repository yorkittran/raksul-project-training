$(document).ready(function() {
    var table = $('#example').DataTable({
      responsive: true,
      bDestroy: true
    }).columns.adjust().responsive.recalc();
});