document.querySelectorAll(".manufacturer").forEach(item => {
  item.addEventListener("click", event => {
    document.querySelectorAll(".manufacturer").forEach(item => {
      item.classList.remove("border-custom-triggered")
    })
    item.classList.add("border-custom-triggered")
  })
})

document.querySelectorAll(".os").forEach(item => {
  item.addEventListener("click", event => {
    document.querySelectorAll(".os").forEach(item => {
      item.classList.remove("border-custom-triggered")
    })
    item.classList.add("border-custom-triggered")
  })
})

document.querySelectorAll(".memory").forEach(item => {
  item.addEventListener("click", event => {
    document.querySelectorAll(".memory").forEach(item => {
      item.classList.remove("border-custom-triggered")
    })
    item.classList.add("border-custom-triggered")
  })
})