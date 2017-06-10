$('#form1 ~ *').remove();


function BackToTop() {
    $button = $('#back-to-top');
    var offset = 320;
    var duration = 500;
    $button.fadeOut(duration);

    $(window).scroll(function () {
        if ($(this).scrollTop() > offset)
            $button.fadeIn(duration);
        else
            $button.fadeOut(duration);
    });
    $button.click(function (event) {
        event.preventDefault();
        $('html, body').animate({ scrollTop: 0 }, duration);
        return false;
    });
}

function Slider() {
    var slideIndex = 1;
    showSlides(slideIndex);

    function ChangeSlides(n) {
        showSlides(slideIndex += n);
    }

    function showSlides(n) {
        var slides = $("#banner .mySlides");
        var dots = $("span.dot");
        var i;
        if (n > slides.length) { slideIndex = 1; }
        if (n < 1) { slideIndex = slides.length; }
        for (i = 0; i < slides.length; i++) {
            $(slides[i]).hide();
        }
        for (i = 0; i < dots.length; i++) {
            $(dots[i]).removeClass('active_dots');
        }
        $(slides[slideIndex - 1]).show();
        $(dots[slideIndex - 1]).addClass('active_dots');
    }

    $('.next').on('click', function () {
        ChangeSlides(1);
    });
    $('.prev').on('click', function () {
        ChangeSlides(-1);
    });
    setInterval(function () { ChangeSlides(1); }, 5000);
}

$(document).ready(function () {

    Slider();

    BackToTop();
});










