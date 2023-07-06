$.ajax({
    type: 'POST',
    url: 'http://localhost:8888/login.php',
    data: {
        username: 'your_username',
        password: 'your_password'
    },
    success: function(response) {
        console.log(response);
    },
    error: function(jqXHR, textStatus, errorThrown) {
        console.log(textStatus)
    }
})