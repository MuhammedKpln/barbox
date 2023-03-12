window.addEventListener("load", () => {
  const scrollTopElement = document.querySelector(".scroll-top");
  feather.replace();


  window.addEventListener("scroll", () => {
    const scrollY = window.scrollY;

    if (scrollY > 600) {
      scrollTopElement.classList.add("active")
    } else {
      scrollTopElement.classList.remove("active")
    }
  })

  scrollTopElement.addEventListener("click", () => {
    window.scrollTo({
      top: 0,
      behavior: "smooth"
    })
  })
})