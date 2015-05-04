Template.appMainView.rendered = ->
    flag = off
    slideDuration = 500
    hdrS = FView.byId('hamburger').surface
    ftrS = FView.byId('footerS').surface
    labelS = FView.byId('label').surface
    noticeS = FView.byId('notice').surface
    
    hfl = new Famous.Transitionable 0
    
    fview = FView.byId 'hfl'
    
    fview.modifier.transformFrom =>
        currentPosition = hfl.get()
        Famous.Transform.translate(currentPosition,0,0)
        
    sync = new Famous.GenericSync ['mouse','touch'],{direction:Famous.GenericSync.DIRECTION_X}
    
    #Famous.Engine.pipe sync
    hdrS.pipe sync
    ftrS.pipe sync
    
    sync.on 'end', =>
        if flag is off
            flag = on
            
            if hfl.get() is 0
                hfl.set window.innerWidth - (window.innerWidth*.30), {duration:slideDuration,curve:Famous.Easing.inOutBack}
                FView.byId('backing').modifier.setTransform Famous.Transform.translate(0,0,-10)
                App.events.emit 'animate'
            
            else
                hfl.set 0,{duration:slideDuration},=>
                    FView.byId('backing').modifier.setTransform Famous.Transform.translate(0,0,-2)
            
            Meteor.setTimeout ->
                flag=off
            ,200
            
    App.events.on 'swipeleft', (page)=>
        console.log {page}
        labelS.setContent page.charAt(0).toUpperCase() + page.slice(1)
        if page is 'home'
          noticeS.setContent 'Welcome!'
        else
          noticeS.setContent 'Enjoy'
        
        #hfl.set 0,{duration: 500},=>
            #Session.set 'currentHeadFootContentTemplate',page+'ScrollView'
        #
        
        if page isnt 'design'
            hfl.set 0,{duration: 500},=>
                Session.set 'currentHeadFootContentTemplate',page+'ScrollView'
        else
            sp=
                params:
                    "token":"iamgood"
            
            url = Session.get('serverURL')+'/rest/design/'
            
            HTTP.call 'GET',url,sp,(error,result) =>
                if error
                    t = "please check your internet connection"
                else
                    t= JSON.parse(result.content).text
                Session.set 'design',t
                console.log Session.get 'design'
                hfl.set 0,{duration:500},=>
                    Session.set 'currentHeadFootContentTemplate','designScrollView'
                