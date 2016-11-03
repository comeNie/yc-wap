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
//关闭历史纪录
$(function(){
$(".history-list .right .btn").click(function () {
	$(this).parents('.history-list li').hide();
	});
	}); 	
//二级菜单下拉
$(function () {
    var st = 100;
    $('.wap-second-nav #nav-list').click(function () {
		$('.pop-nav').toggle();
    })
		$(".pop-nav").click(function () {
                $(this).hide(1);
            });

  });