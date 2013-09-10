$ ->
  setTimeout (->
    console.log Date.now()
    Turbolinks.visit window.location.href
  ), 5000
