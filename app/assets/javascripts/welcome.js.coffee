$ ->
  window.timeout = setTimeout (->
    Turbolinks.visit window.location.href
    clearTimeout(timeout)
  ), 5000
