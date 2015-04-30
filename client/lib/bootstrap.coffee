#declare namespaces
window.App ?= {}
window.Famous ?= {}

Meteor.startup ->
    Logger.setLevel 'famous-views','info'
    App.events = new Famous.EventHandler