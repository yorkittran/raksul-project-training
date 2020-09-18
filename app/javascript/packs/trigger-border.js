document.querySelectorAll(".manufacturer").forEach(item => {
  item.addEventListener("click", event => {
    document.querySelectorAll(".manufacturer").forEach(item => {
      item.classList.remove("border-custom-triggered")
    })
    item.classList.add("border-custom-triggered")
    document.getElementById("model_manufacturer_id").setAttribute("value", item.getAttribute("alt"))
  })
})

document.querySelectorAll(".os").forEach(item => {
  item.addEventListener("click", event => {
    document.querySelectorAll(".os").forEach(item => {
      item.classList.remove("border-custom-triggered")
    })
    item.classList.add("border-custom-triggered")
    document.getElementById("model_os_name_id").setAttribute("value", item.getAttribute("alt"))
  })
})
