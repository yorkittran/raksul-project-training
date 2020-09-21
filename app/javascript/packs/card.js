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
      +'<input type="hidden" name="model[name]['+ index +']" value="'+ current_phone + '">'
    +'</div>'
    +'<div class="flex gap-4 my-2">'
      +'<div class="w-1-of-2 mx">'
        +'<label class="text-gray-700 font-bold" for="body_color_id">Body color</label>'
        +'<div class="autocomplete w-full mt-1"><input type="text" name="body_color[name]['+ index +']" id="body_color_name_'+ index +'" class="form-input w-full" autocomplete="off"></div>'
      +'</div>'
      +'<div class="w-1-of-4">'
        +'<label class="text-gray-700 font-bold" for="memory_display_name_'+ index +'">Memory (Display name)</label>'
        +'<div class="autocomplete w-full mt-1"><input type="text" name="memory[display_name]['+ index +']" id="memory_display_name_'+ index +'" class="form-input w-full" autocomplete="off"></div>'
      +'</div>'
      +'<div class="w-1-of-4">'
        +'<label class="text-gray-700 font-bold" for="memory_amount_'+ index +'">Memory (Amount by GB)</label>'
        +'<div class="autocomplete w-full mt-1"><input type="text" name="memory[amount]['+ index +']" id="memory_amount_'+ index +'" class="form-input w-full" autocomplete="off"></div>'
      +'</div>'
    +'</div>'
    +'<div class="flex gap-4">'
      +'<div class="flex gap-4 my-2 w-1-of-2">'
        +'<div class="w-4-of-12"><label class="text-gray-700 font-bold" for="major_'+ index +'">Major</label><input type="number" name="os_version[major]['+ index +']" id="major_'+ index +'" value="0" class="form-input w-full mt-1" min="0"></div>'
        +'<div class="w-4-of-12"><label class="text-gray-700 font-bold" for="minor_'+ index +'">Minor</label><input type="number" name="os_version[minor]['+ index +']" id="minor_'+ index +'" value="0" class="form-input w-full mt-1" min="0"></div>'
        +'<div class="w-4-of-12"><label class="text-gray-700 font-bold" for="patch_'+ index +'">Patch</label><input type="number" name="os_version[patch]['+ index +']" id="patch_'+ index +'" value="0" class="form-input w-full mt-1" min="0"></div>'
      +'</div>'
      +'<div class="flex gap-4 my-2 w-1-of-2">'
        +'<div class="w-1-of-2"><label class="text-gray-700 font-bold" for="quantity_'+ index +'">Quantity</label><input type="number" name="inventory[quantity['+ index +']" id="quantity_'+ index +'" value="0" class="form-input w-full mt-1" min="0"></div>'
        +'<div class="w-1-of-2"><label class="text-gray-700 font-bold" for="price_'+ index +'">Price</label><input type="number" name="inventory[price]['+ index +']" id="price_'+ index +'" value="0" class="form-input w-full mt-1" min="0"></div>'
      +'</div>'
    +'</div>'
    +'<input class="mt-4" type="file" name="image['+ index +']" id="image">'
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