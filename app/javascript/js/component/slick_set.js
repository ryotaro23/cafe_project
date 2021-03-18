document.addEventListener("turbolinks:load", function (){
    $('.js-events').slick({
        slidesToShow: 2,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 2000,
    });
});
