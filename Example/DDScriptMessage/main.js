function js_to_origin() {
    console.log(123);
    document.body.style.backgroundColor = document.body.style.backgroundColor == "red" ? "yellow" : "red";

    window.cci.alert({
        'title': '123'
    }, function (res) {
        console.log(res);
        document.body.innerHTML = "<div style='background-color:green,width:200px,height:200px'>123123</div>"
    })
}