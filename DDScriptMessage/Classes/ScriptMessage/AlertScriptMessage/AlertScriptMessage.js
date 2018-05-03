if (window.cci == undefined) {
    window.cci = {}
}
var Alert = {
    alert : function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.alert, "alert");
        window.webkit.messageHandlers.alert.postMessage(message);
    }
}

Object.assign(window.cci, Alert)

function register(func_name){
    alert.call(window.webkit.messageHandlers).postMessage(message)
}
