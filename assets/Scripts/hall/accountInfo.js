

var AccountInfo = cc.Class({
    playerName:"",//mnick
    iconUrl : "",//micon
    money : "",//mmoney
    vkey : "",//vkey
    mid:0,//mid
    mtkey:"",//mtkey
    vip:0,//mvip
    sitemid:"",//sitemid
    mlevel:0,//mlevel
    bytkn:"",//bytkn

    statics:{
        _instance:null,
    },
    
    updateLoginInfo:function(data)
    {
        this.playerName = data.mnick;
        this.iconUrl = data.micon;
        this.money = data.mmoney;
        this.vkey = data.vkey;
        this.mtkey = data.mtkey;
        this.vip = data.mvip;
        this.sitemid = data.sitemid;
        this.mlevel = data.mlevel;
        this.bytkn = data.bytkn;
        cc.log("accountinfo updateLoginInfo:playerName:", this.iconUrl);
    }
});

AccountInfo._instance = new AccountInfo();

module.exports = AccountInfo;
