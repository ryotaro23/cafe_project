console.log('hello tinko');

document.addEventListener("turbolinks:load", function () {
    $("#js-ham").click(function () {
        $("#js-ham").toggleClass('is-active');
        $("#js-modal").toggleClass("open");
    });
});
