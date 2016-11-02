$(function(){
$(".sp_zhank").click(function () {
   $(this).find("i").toggleClass("tca tcb");
	$(this).children('.sp_nr').slideToggle(0);
	$(this).find('.msMnu_Item ul li p').toggleClass("title_desc title_desc_none")
 });
});




$(function(){
$(".kaih").click(function () {
   $(".yih").animate({right:'0'},500);
});
$(".yih ul li").click(function () {
   $(".yih").animate({right:'-100%'},0);
});
});


$(function(){
$(".kais").click(function () {
   $(".diq_sh").animate({right:'0'},500);
});
$(".diq_sh ul li").click(function () {
   $(".diq_s").animate({right:'0'},0);
});
$(".diq_s ul li").click(function () {
   $(".diq_sh").animate({right:'-100%'},0);
   $(".diq_s").animate({right:'-100%'},0);
});
});

$(function(){
$(".xuanse").click(function () {
   $(".yans").show();
});
});

$(function(){
$(".yans_nr").click(function () {
   $(".yans").hide();
});
});

$(function(){
$(".xy_xs").click(function () {
   $(this).hide();
   $(".xy_yc").show();
});
});

$(function(){
$(".dj_in input").click(function () {
   $('.xy_xs').show();
   $(".xy_yc").hide();
});
});


	function justifyRem(){
			document.documentElement.style.fontSize = document.documentElement.clientWidth/16 + 'px';
		}
		justifyRem();
		window.addEventListener('resize',justifyRem,false);

//提示操作弹出框 
jQuery(document).ready(function($) {
	$('#xinx').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#eject-small').slideDown(200);
	})
	$('#xinx-btn').click(function(){
	$('#eject-mask').fadeOut(100);
	$('#eject-small').slideUp(150);
	})
})