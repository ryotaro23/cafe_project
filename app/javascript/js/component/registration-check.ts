document.addEventListener("turbolinks:load", function () {

    $(".js-registration-check").focusin(function () {
        $("#js-registration-title").css("color", "#FF5252");
    });

    $(".js-registration-check").focusout(function () {
        $("#js-registration-title").css("color", "black");
    });

});
