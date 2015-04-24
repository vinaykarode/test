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