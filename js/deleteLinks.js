var deleteLinks = document.querySelectorAll('.delete');
console.log(deleteLinks);
for (var i = 0; i < deleteLinks.length; i++) {
    link = deleteLinks[i];
    link.addEventListener('click', function(ev){
        if (!confirm('Todo wirklich löschen?')) {
            ev.preventDefault();
        }
    });
}