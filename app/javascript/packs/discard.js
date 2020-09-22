document.querySelectorAll(".toggle").forEach(item => {
  item.addEventListener("click", event => {
    if (item.getAttribute("checked")) {
      $.ajax({
        url: resource + item.getAttribute("id"),
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "DELETE"
      })
    } else {
      $.ajax({
        url: resource + item.getAttribute("id") + '/restore',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "PUT"
      })
    }
  })
})