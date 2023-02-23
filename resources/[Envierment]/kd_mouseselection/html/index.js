var Lang = {}
var currentLevel = 0

$(function () {

    var contextElement = $("#level-0 .context-menu")[0];
    var TimerCoolDown = 50
    var Open = false

    function display(bool) {
        Open = bool
        if (bool) {
            clearContextmenu();
            $("#container").show();
            $("#container .overlay").fadeTo("fast",0.75, () => {
            })
            $("#close").show();
        } else {
            $("#container .overlay").fadeTo("fast",0.0, () => {
                $("#container").hide();
            })
            $("#close").hide();
        }
    }

    function IsContextOpen() {
        return $("#level-0 .context-menu")[0].classList.contains("active")
    }

    function clearAll()
    {
        $("#level-0 .context-menu")[0].classList.remove("active");
        clearContextmenu();
        $.post('https://kd_mouseselection/exit', JSON.stringify({}));
    }

    display(false);
    
    clearContextmenu();
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "lang") {
            Lang = item.lang
        }
        if (item.type === "ui") 
        {
            if (item.status == true) 
            {
                display(true)
            } 
            else 
            {
                display(false)
            }
        }
        if (item.type === "MenuClear") 
        {
            if (IsContextOpen())
                clearContextmenu();
                $("#level-0 .context-menu")[0].classList.remove("active");
        }

        if (item.type === "AddItem")
        {
            var div = createMenuItem(item.data)
            if (!IsContextOpen())
                contextElement.classList.add("active");
        }
    })

    document.onkeydown = function (data) {
        if (data.which == 27 || data.which == 90) 
        {
            clearAll()
            return
        }
    };
    document.addEventListener("click", (e) => {
        var item = $(e.target).closest('.menu-item')[0];
        if (item == undefined) return;
        var level = parseInt(item.getAttribute('level'));
        var callback = item.getAttribute('callback');
        var id = item.id
        if (id == "close") {
            clearAll();
            return;
        }
        var argument = item.getAttribute('argument');
        while (callback == undefined && level > 0) {
            level--
            item = $('#level-'+level+ " .menu-item.active")
            if (item.length > 0)
                callback = item[0].getAttribute('callback');
        }
        if (callback == null) return;
        $.post('https://kd_mouseselection/use', JSON.stringify({event:callback,id:id,argument:argument})); //General options
        clearAll()
    })

    window.addEventListener("contextmenu",function(event){
        event.preventDefault();
        $.post('https://kd_mouseselection/rightclick', JSON.stringify({}));
        contextElement.style.top = event.offsetY + "px";
        contextElement.style.left = event.offsetX + "px";
    });
    window.addEventListener("click",function(){
        $("#level-0 .context-menu")[0].classList.remove("active");
        clearAll()
    });

    var CoolDownMove = false
    window.addEventListener('mousemove', e => {
        if (!Open) return;

        if (IsContextOpen()) return;
        if (!CoolDownMove) {
            var xCord = e.clientX;
            var yCord = e.clientY;

            var xPercent = xCord/window.innerWidth;
            var yPercent = yCord/window.innerHeight;
            $.post('https://kd_mouseselection/move', JSON.stringify({position:{x:xPercent,y:yPercent}}));
            CoolDownMove = true
            setTimeout(()=> {
                CoolDownMove = false
            }, TimerCoolDown)
        }
    });
    
    function clearContextmenu()
    {
        var item = $("#level-0 .context-menu")[0];
        item.innerHTML = ''; //<--- Look into a CLEANER option.

        bg = document.createElement("div");
        bg.setAttribute("id", "context-bg");

        var elem = document.createElement("img");
        elem.setAttribute("src", "imgs/context_bg.webp");
        bg.appendChild(elem);

        $("#level-0 .context-menu")[0].appendChild(bg);

        for (let level = 1; level <= currentLevel; level++) {
            $("#level-"+level).remove();
        }

        $.post('https://kd_mouseselection/closeContext', JSON.stringify({}));
    }
    
    function createMenuItem(data)
    {
        var node;
        var textnode;

        ClearCloseItem()
        
        node = CreateItem(data)

        $("#level-0 .context-menu")[0].appendChild(node);

        AddCloseItem()

        return node
    }

    function CreateItem(data)
    {
        node = document.createElement("div");
        node.setAttribute("class", "menu-item");
        if (data.id != undefined)
            node.setAttribute("id", data.id);
        if (data.callback != undefined)
            node.setAttribute("callback", data.callback);
        node.setAttribute("level", 0);

        hover = document.createElement("div");
        hover.setAttribute("class", "menu-item-hover");

        var elem = document.createElement("img");
        elem.setAttribute("src", "imgs/item_hover.webp");
        hover.appendChild(elem);

        node.appendChild(hover);

        text = document.createElement("div");
        text.setAttribute('class',"menu-title")

        textnode = document.createTextNode(data.title);
        text.appendChild(textnode);

        node.appendChild(text);

        if (data.children != undefined) {
            const children = data.children;

            arrow = document.createElement("div");
            arrow.setAttribute("class", "menu-item-arrow");

            elem = document.createElement("img");
            elem.setAttribute("src", "imgs/arrow_right.webp");
            arrow.appendChild(elem);

            node.appendChild(arrow);

            node.addEventListener("click", function(e) {
                e.preventDefault();
                e.stopPropagation();

                //check if new menu
                var parent = $(e.target).closest('.menu-item')[0];
                var level = parseInt(parent.getAttribute('level')) + 1

                if (currentLevel > 0) {
                    while (currentLevel >= level) {
                        $('#level-'+currentLevel).remove();
                        currentLevel --;
                    }
                }

                $('#level-'+currentLevel+ ' .menu-item').each((index, element) => {
                    element.classList.remove('active')
                })
                

                //remove active class

                currentLevel = level

                var secondary = document.createElement('div');
                secondary.setAttribute('id','level-'+level);

                var menu = document.createElement('div');
                menu.setAttribute('class',"context-menu");

                bg = document.createElement("div");
                bg.setAttribute("id", "context-bg");

                var elem = document.createElement("img");
                elem.setAttribute("src", "imgs/context_bg.webp");
                bg.appendChild(elem);
                menu.appendChild(bg);

                children.forEach(child => {
                    itemnode = CreateItem(child)
                    itemnode.setAttribute('level', parseInt(parent.getAttribute('level'))+1)
                    itemnode.setAttribute('argument', child.argument)
                    menu.appendChild(itemnode);
                });
                secondary.appendChild(menu)

                document.getElementById('container').appendChild(secondary)

                var parentStyle = parent.getBoundingClientRect();

                secondary.style.position = "absolute";
                secondary.style.top = parentStyle.top + "px";
                secondary.style.left = (parentStyle.left + parentStyle.width) + "px";

                menu.classList.add("active");

                parent.classList.add('active');

            })
        }

        return node
    }


    function ClearCloseItem() {
        if (document.getElementById("close")) {
            document.getElementById("menu-separator").remove();
            document.getElementById("close").remove();
        }
    }

    function AddCloseItem() {
        var node;
        var textnode;

        node = document.createElement("div");
        node.setAttribute("class", "menu-separator");
        node.setAttribute("id", "menu-separator");

        var elem = document.createElement("img");
        elem.setAttribute("src", "imgs/separator.webp");
        node.appendChild(elem);

        $("#level-0 .context-menu")[0].appendChild(node);

        node = document.createElement("div");
        textnode = document.createTextNode(Lang['cancel']);
        node.setAttribute("id", "close");
        node.setAttribute("class", "menu-item");

        hover = document.createElement("div");
        hover.setAttribute("class", "menu-item-hover");

        var elem = document.createElement("img");
        elem.setAttribute("src", "imgs/item_hover.webp");
        hover.appendChild(elem);

        node.appendChild(hover);

        text = document.createElement("div");
        text.setAttribute('class',"menu-title")
        text.appendChild(textnode);

        node.appendChild(text);

        $("#level-0 .context-menu")[0].appendChild(node);
    }
})