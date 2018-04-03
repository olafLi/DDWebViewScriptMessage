var cci = {
    nav_backToRoot: function () {
        var message = {};
        window.webkit.messageHandlers.nav_backToRoot.postMessage(
            message);
    },
    nav: {
        backToRoot: function () {
            var message = {}
            window.webkit.messageHandlers.nav_backToRoot.postMessage(
                message);
        }
    },
    media_openPhotoLibary: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.media_openPhotoLibary,
            "media_openPhotoLibary")
        window.webkit.messageHandlers.media_openPhotoLibary.postMessage(
            message);
    },
    media_openPhotoBrowser: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.media_openPhotoBrowser,
            "media_openPhotoBrowser")
        window.webkit.messageHandlers.media_openPhotoBrowser.postMessage(
            message);
    },
    media_openCamera: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.media_openCamera,
            "media_openCamera")
        window.webkit.messageHandlers.media_openCamera.postMessage(
            message);
    },
    media_upload: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.media_upload,
            "media_upload");
        window.webkit.messageHandlers.media_upload.postMessage(message);
    },
    media_openQRScanner: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.media_openQRScanner,
            "media_openQRScanner");
        window.webkit.messageHandlers.media_openQRScanner.postMessage(
            message);
    },
    auth_access_token: function (callback) {
        var message = JKEventHandler.bindCallBack(this.auth_access_token,
            "auth_access_token");
        window.webkit.messageHandlers.auth_access_token.postMessage(
            message);
    },
    auth_user: function (callback) {
        this.user_info(callback);
    },
    user_info: function (callback) {
        var message = JKEventHandler.bindCallBack(this.user_info,
            "user_info");
        window.webkit.messageHandlers.user_info.postMessage(message);
    },
    phone_call: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.phone_call,
            "phone_call")
        window.webkit.messageHandlers.phone_call.postMessage(message);
    },
    location_current: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.location_current,
            "location_current");
        window.webkit.messageHandlers.location_current.postMessage(
            message);
    },
    input: function (options, callback) {
        var message = JKEventHandler.bindCallBack(this.input,
            "input");
        window.webkit.messageHandlers.input.postMessage(
            message);
    },
    device_type: function () {
        return "ios";
    }
}

window.cci = cci;

var JKEventHandler = {
    bindCallBack: function (fn, func_name) {
        var message = {};
        // var func_name = ""; //getFnName(fn);

        message["func_name"] = func_name

        for (var index = 0; index < fn.arguments.length; index++) {
            var obj = fn.arguments[index]
            if (typeof obj == "function") { //函数 回调函数
                var callback_func_name = obj.name.length > 0 ? obj.name :
                    func_name + "_callback_" + index + "_" + Date.parse(
                        Date())
                if (!Event._listeners[callback_func_name]) {
                    Event.addEvent(callback_func_name, function (data) {
                        obj(data);
                    });
                }
                if (typeof callback_func_name === "string") {
                    message["callback"] = callback_func_name
                }
            } else {
                if (typeof message["params"] == "undefined") {
                    message["params"] = {};
                }

                if (typeof obj === "object") {
                    for (var v in obj) {
                        message["params"][v] = obj[v];
                    }
                }
            }
        }
        return message
    },
    callBack: function (callBackName, data) {
        Event.fireEvent(callBackName, data);
    },
    removeAllCallBacks: function (data) {
        Event._listeners = {};
    }
};

var Event = {
    _listeners: {},

    addEvent: function (type, fn) {
        if (typeof this._listeners[type] === "undefined") {
            this._listeners[type] = [];
        }
        if (typeof fn === "function") {
            this._listeners[type].push(fn);
        }

        return this;
    },

    fireEvent: function (type, param) {
        var arrayEvent = this._listeners[type];
        if (arrayEvent instanceof Array) {
            for (var i = 0, length = arrayEvent.length; i < length; i +=
                1) {
                if (typeof arrayEvent[i] === "function") {
                    arrayEvent[i](param);
                }
            }
        }
        return this;
    },

    removeEvent: function (type, fn) {
        var arrayEvent = this._listeners[type];
        if (typeof type === "string" && arrayEvent instanceof Array) {
            if (typeof fn === "function") {
                for (var i = 0, length = arrayEvent.length; i < length; i +=
                    1) {
                    if (arrayEvent[i] === fn) {
                        this._listeners[type].splice(i, 1);
                        break;
                    }
                }
            } else {
                delete this._listeners[type];
            }
        }
        return this;
    }
};
(function () {
    window.cci.auth_access_token(function (data) {
        localStorage.setItem("access_token", data.access_token)
    })
    window.cci.user_info(function (data) {
        localStorage.setItem("user", JSON.stringify(data.user))
    })
    document.documentElement.style.webkitUserSelect = 'none';
    document.documentElement.style.webkitTouchCallout = 'none';
})()
