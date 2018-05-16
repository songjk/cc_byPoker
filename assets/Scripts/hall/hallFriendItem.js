// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html

cc.Class({
    extends: cc.Component,

    properties: {
        // foo: {
        //     // ATTRIBUTES:
        //     default: null,        // The default value will be used only when the component attaching
        //                           // to a node for the first time
        //     type: cc.SpriteFrame, // optional, default is typeof default
        //     serializable: true,   // optional, default is true
        // },
        // bar: {
        //     get () {
        //         return this._bar;
        //     },
        //     set (value) {
        //         this._bar = value;
        //     }
        // },
        icon:cc.Sprite,
        itemName:cc.Label,
        win:cc.Label
    },

    // LIFE-CYCLE CALLBACKS:

    // onLoad () {},
    setData:function(data){
        var Url = data.iconSF;
        if(typeof Url !== "string")
        {
            Url = "http://www.qqzhi.com/uploadpic/2014-09-28/135330636.jpg";
        }
        var length = Url.length;
        var imageType = Url.substring(length-3, length);
        cc.log("initPlayerInfo:", Url);
        if(imageType == "jpg" || imageType == "png" || imageType == "peg" || imageType == "gif")
        {
            cc.loader.load(Url, function(err, texture){
                this.icon.spriteFrame.setTexture(texture);
            }.bind(this));
        }
        else
        {
            cc.loader.load({url:Url, type:"jpg"}, function(err, texture){
                this.icon.spriteFrame.setTexture(texture);
            }.bind(this));
        }
        
        this.itemName.string = data.itemName;
        this.win.string = "赢局：" + data.itemWin;
    },
    start () {

    },

    // update (dt) {},
});
