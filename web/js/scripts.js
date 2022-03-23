$(function () {
  // init feather icons
  feather.replace();

  // init tooltip & popovers
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();

  //page scroll
  $("a.page-scroll").bind("click", function (event) {
    var $anchor = $(this);
    $("html, body")
      .stop()
      .animate(
        {
          scrollTop: $($anchor.attr("href")).offset().top - 50,
        },
        1000,
      );
    event.preventDefault();
  });

  //toggle scroll menu
  $(window).scroll(function () {
    var scroll = $(window).scrollTop();
    // adjust scroll to top
    if (scroll >= 600) {
      $(".scroll-top").addClass("active");
    } else {
      $(".scroll-top").removeClass("active");
    }
    return false;
  });

  //open / close video section
  $(".show-video").click(function () {
    $(".video-wrapper").addClass("show");
  });

  $(".video-close").click(function () {
    $(".video-wrapper").removeClass("show");
  });

  // scroll top top
  $(".scroll-top").click(function () {
    $("html, body").stop().animate(
      {
        scrollTop: 0,
      },
      1000,
    );
  });

  /**Theme switcher - DEMO PURPOSE ONLY */
  $(".switcher-trigger").click(function () {
    $(".switcher-wrap").toggleClass("active");
  });
  $(".color-switcher ul li").click(function () {
    var color = $(this).attr("data-color");
    $("#theme-color").attr("href", "css/" + color + ".css");
    $(".color-switcher ul li").removeClass("active");
    $(this).addClass("active");
  });
});
