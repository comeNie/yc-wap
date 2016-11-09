//分享弹出框 
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
//提示弹出框 
jQuery(document).ready(function($) {
	$('#upload').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#prompt').slideDown(100);
	})
	$('#prompt-btn').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#prompt').slideUp(200);
	})
})
//提示弹出框 
jQuery(document).ready(function($) {
	$('#payment-btn').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#payment-eject').slideDown(100);
	})
	$('#payment-close').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#payment-eject').slideUp(200);
	})
})	