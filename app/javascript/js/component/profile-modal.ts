document.addEventListener("turbolinks:load", function () {

    $("#js-profile-close").click(function () {
        $("#js-profile-modal").css("display", "none");
        $("#js-profile-bg-black").css("display", "none");
    });

    $("#js-profile-modal-open").click(function () {
        console.log("Modal opened");
        $("#js-profile-modal").fadeIn(1000);
        $("#js-profile-bg-black").css("display", "block");
    });

    $("#js-profile-modal-open").hover(
        function() {
            $("#js-camera").css("color", "white");
        },
        function() {
            $("#js-camera").css("color", "transparent");
        }
    );

});