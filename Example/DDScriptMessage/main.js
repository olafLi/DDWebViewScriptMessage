function js_to_origin() {
    console.log(123);
    document.body.style.backgroundColor = document.body.style.backgroundColor == "red" ? "yellow" : "red";

    window.cci.alert({
        'title': '123'
    }, function (res) {
        console.log(res);
    })
}