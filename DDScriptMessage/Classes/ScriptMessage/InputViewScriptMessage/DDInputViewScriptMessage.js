if (window.cci == undefined) {
    window.cci = {}
}
var Input = {
    input_text : function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.input_text, "input_text");
        window.webkit.messageHandlers.input_text.postMessage(message);
    }
}

Object.assign(window.cci, Input)