document.addEventListener("turbolinks:load", function () {

    let $selectBefore  = $("#js-select-before");
    let $selectAfter = $("#js-select-after");
    let $eventBefore = $("#js-event-before");
    let $eventAfter = $("#js-event-after");

    $selectBefore.css("color", "#FF5252");

    $selectBefore.click(function () {
        $selectBefore.css("color", "#FF5252");
        $selectAfter.css("color", "");
        $eventAfter.fadeOut(100);
        $eventBefore.fadeIn(100);
    });

    $selectAfter.click(function () {
        $selectAfter.css("color", "#FF5252");
        $selectBefore.css("color", "");
        $eventBefore.fadeOut(100);
        $eventAfter.fadeIn(100);
    });

});