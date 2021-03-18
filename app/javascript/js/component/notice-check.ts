document.addEventListener("turbolinks:load", function () {

    let noticeText:string = $(".notice").text().trim();

    // trim : remove blank
    if ( noticeText.length <= 0 ) {
        $(".notice").css("display", "none");
    }

});
