//$(function () {
//    var st = 100;
//    $('#chick-int').click(function () {
//		$('#chick-btn').show(1);
//		$('#wrapper-hide').hide(1);
//    })
//    $('#chick-btn').click(function () {
//		$('#results').show(1);
//    })
// });
//关闭历史纪录
//$(function(){
//$(".history-list .right i").click(function () {
//	$(this).parents('.history-list li').hide();
//	});
//	});
////关闭历史纪录
//$(function(){
//$(".history-list .right .btn").click(function () {
//	$(this).parents('.history-list li').hide();
//	});
//	});
//二级菜单下拉
// $(function () {
//     var st = 100;
//     $('.wap-second-nav #nav-list').click(function () {
// 		$('.pop-nav').toggle();
//     })
// 		$(".pop-nav").click(function () {
//                 $(this).hide(1);
//             });
//
//   });
  
//登录 table
$(function(){
$(".login-tab ul li a").click(function () {
                $(".login-tab ul li a").each(function () {
                    $(this).removeClass("current");
                });
                $(this).addClass("current");
            });
$('.login-tab ul li a').click(function(){
  var index=$('.login-tab ul li a').index(this);
     if(index==0){
     $('#tab1').show();
  	 $('#tab2').hide();
   }
   if(index==1){
   $('#tab2').show();
   $('#tab1').hide();
   }
  });
});


/**去掉最后的线条**/
$(function () {
$(".my-order-list ul:last").css("border-bottom","none");
});


// //订单详细
// $(function () {
//     var st = 100;
//     $('.click-more a').click(function () {
// 		$('#cont-hid').toggle();
//     })
//   });