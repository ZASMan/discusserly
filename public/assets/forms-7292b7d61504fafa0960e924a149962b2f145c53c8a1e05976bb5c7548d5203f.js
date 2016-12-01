//Validation Forms Throughout Site

//Signup Page Form
$("#signup-submit").on('click', function() {
	if ($(".signup-field").length) {
		console.log("Clicked!");
		var name_field = $("#name-field").val();
		var email_field = $("#email-field").val();
		var password_field = $("#password-field").val();
		var password_confirmation_field = $("#password-confirmation-field").val();
		if (name_field == "" || email_field == "" || password_field == "" ||password_confirmation_field == "") {
			$(".errors").text("Please fill out all fields before submitting.");
			return false;
		} else {
			return true;
		}	
	}
});

//Login Page Form
$("#login-submit").on('click', function() {
	if ($(".login-field").length) {
		console.log("Clicked!");
		var email_field = $("#email-field").val();
		var password_field = $("#password-field").val();
		if (email_field == "" || password_field == "") {
			$(".errors").text("Please fill out both your username and password.");
			return false;
		} else {
			return true;
		}	
	}
});

//Account Settings Edit Page Form
$("#account-settings-submit").on('click', function() {
	if ($(".signup-field").length) {
		console.log("Clicked!");
		var name_field = $("#name-field").val();
		var email_field = $("#email-field").val();
		var password_field = $("#password-field").val();
		var password_confirmation_field = $("#password-confirmation-field").val();
		if (name_field == "" || email_field == "" || password_field == "" ||password_confirmation_field == "") {
			$(".errors").text("Please fill out all fields before submitting.");
			return false;
		} else {
			return true;
		}	
	}
});

//Profile Edit Page Form
$("#profile-edit-submit").on('click', function() {
	if ($(".profile-field").length) {
		console.log("Clicked!");
		var location_field = $("#location-field").val();
		var occupation_field = $("#occupation-field").val();
		var image_url_field = $("#image-url-field").val();
		var about_me_field = $("#about-me-field").val();
		if (location_field == "" || occupation_field == "" || image_url_field == "" || about_me_field == "") {
			$(".errors").text("Please fill out all fields before submitting.");
			return false;
		} else {
			return true;
		}	
	}
});

//Comment Form
$("#comment-submit").on('click', function() {
	if ($("#comment-field").length) {
		console.log("Clicked!");
		var comment_field = $("#comment-field").val();
		if (comment_field == "") {
			$(".errors").text("Please write a comment before submitting.");
			return false;
		} else {
			return true;
		}	
	}
});
