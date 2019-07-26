var lock = false
function output(msg) {
    $('#output').text(msg)
    lock = false
}

function wait_msg() {
    $('#output').text("响应有点慢，别着急...")
    lock = true
}

function run_app() {
    $("#testget").click(function() {
        wait_msg()
        $.get("/test", function(data,status){
            output(data)
        })
    })

    $("#testpost").click(function() {
        wait_msg()
        var req_data = JSON.stringify({
            "t1": "hello",
        })
        $.post("/test", req_data, function(data) {
            output(data)
        })
    })
}

