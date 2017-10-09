var deleteLinks = document.querySelectorAll('.delete');

for (var i = 0; i < deleteLinks.length; i++) {
    var link = deleteLinks[i];
    link.addEventListener('click', function(ev){
        if (!confirm('Todo wirklich löschen?')) {
            ev.preventDefault();
        }
    });
}