document.getElementById("add-button").addEventListener("click", function() {
  // Draw section
  document.getElementById("create-button").classList.remove("hidden");
  var buttonSection = document.getElementById('button-section');
  var card =
  '<main class="container mx-auto max-w-screen-lg h-full mb-10 shadow-xl rounded-md overflow-auto p-8">'
    +'<div class="modal-close cursor-pointer mb-6 w-auto flex flex-row-reverse">'
      +'<svg class="close fill-current text-gray-900 ml-auto my-auto" height="18" viewBox="0 0 18 18" width="18" xmlns="http://www.w3.org/2000/svg" data-ol-has-click-handler="">'
        +'<path d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"></path>'
      +'</svg>'
      +'<h1 class="text-2xl font-bold">'+ current_phone + '</h1>'
      +'<input type="hidden" name="model[name]" value="'+ current_phone + '">'
    +'</div>'
    +'<div class="grid grid-cols-4 gap-4 mb-6">'
      +'<div>'
        +'<label class="text-gray-700 font-bold" for="body_color_id">Body color</label>'
        +'<div class="autocomplete mt-1"><input type="text" name="body_color[name]['+ index +']" id="body_color_name_'+ index +'" class="form-input w-full" autocomplete="off"></div>'
      +'</div>'
      +'<div>'
        +'<label class="text-gray-700 font-bold" for="memory_id">Memory</label>'
        +'<div class="autocomplete mt-1"><input type="text" name="memory[display_name]['+ index +']" id="memory_display_name_'+ index +'" class="form-input w-full" autocomplete="off"></div>'
      +'</div>'
      +'<div><label class="text-gray-700 font-bold" for="body_color_id">Quantity</label><input type="number" name="inventory[quantity][quantity['+ index +']" id="quantity_'+ index +'" value="0" class="form-input w-full mt-1" min="0"></div>'
      +'<div><label class="text-gray-700 font-bold" for="body_color_id">Price</label><input type="number" name="inventory[price]['+ index +']" id="price_'+ index +'" value="0" class="form-input w-full mt-1" min="0"></div>'
    +'</div>'
    +'<input type="file" name="image['+ index +']" id="image">'
  +'</main>';
  buttonSection.insertAdjacentHTML('beforebegin', card);

  // Add autocomplete
  autocomplete(document.getElementById("body_color_name_" + index), body_colors);
  autocomplete(document.getElementById("memory_display_name_" + index), memories);
  index++;

  // Add close event listener
  document.querySelectorAll(".close").forEach(item => {
    item.addEventListener("click", event => {
      item.parentElement.parentElement.remove();
      if (document.querySelector(".close") === null) document.getElementById("create-button").classList.add("hidden");
    })
  })
})