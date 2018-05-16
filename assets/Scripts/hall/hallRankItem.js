// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html

var HallRankItem = cc.Class({
    
    ctor:function()
    {
        iconSF:"";
        itemName:"";
        itemWin:"0";
        mid:0;
    },
    setData:function(data)
    {
        this.iconSF = data.headImg;
        this.itemName = data.nickname;
        this.itemWin = data.winCnt;
        this.mid = data.mid;
    }
});


module.exports = HallRankItem;