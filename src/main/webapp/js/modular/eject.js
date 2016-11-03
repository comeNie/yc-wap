//提示弹出框 
jQuery(document).ready(function($) {
	$('#share-icon').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#share-eject').slideDown(100);
	})
	$('#close-icon').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#share-eject').slideUp(200);
	})
})

