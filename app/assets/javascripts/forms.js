//Signup Page Form

//Account Settings Edit Page Form

//Profile Edit Page Form

//Profile and Posts Comments Form
if($("#comment-field").length) {
	var comment_field = $("#comment-field").val();
	$("#comment-submit").on('click', function() {
		console.log("Clicked!");
		$(".errors").append().empty();
		if(comment_field === "" ) {
			$(".errors").append("Please write a comment before submitting.");
			return false;
		} else {
			return true;
		}
	});
}
