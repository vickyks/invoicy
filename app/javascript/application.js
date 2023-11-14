// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
  const popoverBox = document.getElementById("popoverBox");

  // Close popoverBox on click outside
  document.addEventListener("click", function(event) {
    if (!popoverBox.contains(event.target)) {
      popoverBox.style.display = "none";
    }
  });
});
