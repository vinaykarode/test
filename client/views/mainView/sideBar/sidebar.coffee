Template.sidebar.rendered = ->
    flag = off
    for i in [1..3]
        target = FView.byId("m"+i).surface
        console.log {target}
        #target = fview.surface
        target.on "click",(evt)=>
            if flag is off
                flag = on
                
                s=FView.byId(evt.currentTarget.classList[2])
                
                s.modifier.setTransform Famous.Transform.translate(-50,0),{duration:300},=>
                    s.modifier.setTransform Famous.Transform.translate(0,0),{duration:200}
                
                Meteor.setTimeout ->
                    flag=off
                ,500
    
    timerFired = (nm) ->
        s= FView.byId("m"+nm)
        console.log {nm}
        s.modifier.setTransform Famous.Transform.translate(0,0,-1),{duration:200}
    
    App.events.on 'animate',=>
        for i in [1..3]
            console.log 'moved down'
            s= FView.byId("m"+i)
            s.modifier.setTransform Famous.Transform.translate(0,(6-i)*180,-1)
        for nm in [1..3]
            console.log 'moved up'
            delay = nm*200
            Famous.Timer.setTimeout(timerFired.bind(this,nm),delay)