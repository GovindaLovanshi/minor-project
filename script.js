// toggel icon navbar
let menuIcon = document.querySelector('#menu-icon');
let navbar = document.querySelector('.navbar');

menuIcon.onclick = () => {
    menuIcon.classList.toggle('box-x');
    navbar.classList.toggle('active');
}


// scroll section

let section = document.querySelectorAll('section');
let navLinks = document.querySelectorAll('header nav a');

window.onscroll = () => {
    sections.forEach(sec => {
        let top = window.scrollY;
        let offset = sec.offset - 100;
        let height = sec.offsetHeight;
        let id = sec.getAttribute('id');

        if (top => offset && tio < offset + height) {
            navLinks.forEach(links => {
                links.classList.remove('active');
                document.querySelector('header nav a [href*=' + id + ']').classList.add('active');
            });


        }

    });
    // stickey haeder
    let header = document.querySelector('header');

    header.classList.toggle('sticky', window.scrollY > 100);
    // remove toggle icon  and navbar when click navbar links scroll
    menuIcon.classList.remove('box-x');
    navbar.classList.remove('active');


}