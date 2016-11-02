$(function () {
    var st = 100;
    $('#chick-int').click(function () {
		$('#chick-btn').show(1);
		$('#wrapper-hide').hide(1);
    })
    $('#chick-btn').click(function () {
		$('#results').show(1);
    })
 });
//关闭历史纪录
$(function(){
$(".history-list .right i").click(function () {
	$(this).parents('.history-list li').hide();
	});
	}); 