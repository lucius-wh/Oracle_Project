<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
(function () {
  var loader = document.getElementById('page-loader');
  function hideLoader() {
    if (loader) loader.classList.add('hidden-loader');
  }
  if (document.readyState === 'complete') hideLoader();
  else window.addEventListener('load', hideLoader);

  var animateFn = (typeof Motion !== 'undefined' && Motion.animate)
    ? Motion.animate.bind(Motion)
    : null;
  if (animateFn) {
    var items = document.querySelectorAll('[data-animate]');
    items.forEach(function (el, i) {
      animateFn(
        el,
        { opacity: [0, 1], y: [16, 0] },
        { duration: 0.45, delay: i * 0.06, easing: [0.22, 1, 0.36, 1] }
      );
    });
  } else {
    document.querySelectorAll('[data-animate]').forEach(function (el) {
      el.style.opacity = '1';
    });
  }

  document.querySelectorAll('form[data-loading]').forEach(function (form) {
    form.addEventListener('submit', function () {
      var btn = form.querySelector('[type="submit"]');
      if (btn && !btn.disabled) {
        btn.dataset.originalText = btn.innerHTML;
        btn.disabled = true;
        btn.innerHTML = '<span class="inline-block h-4 w-4 animate-spin rounded-full border-2 border-white/30 border-t-white"></span> 处理中…';
      }
    });
  });

  document.querySelectorAll('[data-btn-loading]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      if (btn.disabled) return;
      var original = btn.innerHTML;
      btn.disabled = true;
      btn.innerHTML = '<span class="inline-block h-4 w-4 animate-spin rounded-full border-2 border-current border-t-transparent opacity-60"></span>';
      setTimeout(function () {
        btn.disabled = false;
        btn.innerHTML = original;
      }, 8000);
    });
  });
})();
</script>
