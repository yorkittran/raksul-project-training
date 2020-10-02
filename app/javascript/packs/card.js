let modelSelected = document.getElementById("model-select");
let buttonSection = document.getElementById("button-section");
var bodyColorOptions = '';
var memoryOptions = '';
body_colors.forEach(element => bodyColorOptions += '<option value="'+ element.id +'">'+ element.name + '</option>');
memories.forEach(element => memoryOptions += '<option value="'+ element.id +'">'+ element.display_name + '</option>');
var index = 0;

document.getElementById("add-button").addEventListener("click", function() {
  // Draw section
  document.getElementById("create-button").classList.remove("hidden");
  var modelId = modelSelected.options[modelSelected.selectedIndex].value;
  var modelName = modelSelected.options[modelSelected.selectedIndex].text;
  var card =
  '<main class="container w-full mb-10 shadow-xl rounded-md overflow-auto p-8">'
    +'<div class="modal-close cursor-pointer mb-6 w-auto flex flex-row-reverse">'
      +'<svg class="close fill-current text-gray-900 ml-auto my-auto" height="18" viewBox="0 0 18 18" width="18" xmlns="http://www.w3.org/2000/svg" data-ol-has-click-handler="">'
        +'<path d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"></path>'
      +'</svg>'
      +'<h1 class="text-2xl font-bold">'+ modelName + '</h1>'
      +'<input type="hidden" name="model['+ index +']" value="'+ modelId + '">'
    +'</div>'
    +'<div class="flex gap-4 my-2">'
      +'<div class="w-1-of-2">'
        +'<label class="text-gray-700 font-bold" for="body-color-select_'+ index +'">Body Color</label>'
        +'<div class="w-full mt-1"><select name="body_color['+ index +']" class="form-select w-full">'+ bodyColorOptions + '</select></div>'
      +'</div>'
      +'<div class="w-1-of-2">'
        +'<label class="text-gray-700 font-bold" for="memory-select_'+ index +'">Memory</label>'
        +'<div class="w-full mt-1"><select name="memory['+ index +']" class="form-select w-full">'+ memoryOptions + '</select></div>'
      +'</div>'
    +'</div>'
    +'<div class="flex gap-4">'
      +'<div class="w-1-of-3"><label class="text-gray-700 font-bold" for="os_version_'+ index +'">OS Version (ex: 14.0.1)</label><input type="text" name="os_version['+ index +']" id="os_version_'+ index +'" class="form-input w-full mt-1"></div>'
      +'<div class="w-1-of-3"><label class="text-gray-700 font-bold" for="quantity_'+ index +'">Quantity</label><input type="number" name="quantity['+ index +']" id="quantity_'+ index +'" value="0" class="form-input w-full mt-1" min="0" max="1000"></div>'
      +'<div class="w-1-of-3"><label class="text-gray-700 font-bold" for="price_'+ index +'">Price</label><input type="number" name="price['+ index +']" id="price_'+ index +'" value="0" class="form-input w-full mt-1" min="0" max="1000000"></div>'
    +'</div>'
  +'</main>';
  buttonSection.insertAdjacentHTML('beforebegin', card);
  index++;

  // Add close event listener
  document.querySelectorAll(".close").forEach(item => {
    item.addEventListener("click", event => {
      item.parentElement.parentElement.remove();
      if (document.querySelector(".close") === null) document.getElementById("create-button").classList.add("hidden");
    })
  })
})