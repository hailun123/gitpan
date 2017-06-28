<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/common/include.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员登录</title>
</head>
<body>
<div id="loginDialog" title="管理员登录" style="display: none;">
	<form id="loginForm" method="post">
		<div>
			<label>账户:</label>
			<input class="easyui-validatebox" type="text" name="phone"  onblur="checkLoginName(this.value)"  data-options="required:true,validType:'phoneRex'" />
		</div>
		<div>
			<label >账户密码:</label>
			<input class="easyui-validatebox" type="password" id="pwd" name="password"
				   data-options="required:true,validType:'length[6,18]'"    />
		</div>
		<div>
			<label>验证码:</label>
			<input  class="easyui-validatebox"  data-options="required:true" name="imgcode"   type="text" id="imgcode" style="width:60px"/>
			<img src="<%=request.getContextPath()%>/imageCode" id="imgcoode">
			<input class="l-btn" value="看不清换一个" type="button" onclick="getImageCode(this)"/>
		</div>
	    </form> 
	 </div>
	 
	 <script type="text/javascript">
	 	
	 	$(function(){
	 		$('#loginDialog').dialog({    
	 		    title: '登录',    
		    width: 400,    
	 		    height: 200,     
	 		    //不能关闭窗口
	 		//    closed: true,    
	 		    cache: false,    
	 		    //模态窗口
	 		    modal: true,
	 		    top:250, 
	 		    content : $("#loginForm"),
	 		    buttons:[
	 		             {
	 		            	 text:'登录',
	 		            	 iconCls:'',
	 		            	 handler:function(){
	 		            	$.ajax({
	 		               		url:sys.contextPath+'/admin/checkAdminLogin.lun',
	 		               		type:'post',
	 		               		//同步
	 		               		async:false,
	 		               		data:$("#loginForm").serialize(),
	 		               		success:function(data){
	 		               			//用户不存在返回true
	 		               			if (data.success) {
	 		               				window.location.href=sys.contextPath+"/main/main.lun";
	 		           				}else{
	 		           					$.messager.alert('警告',data.msg,"error");    
	 		           				}
	 		               		}
	 		               	})
	 		              }
	 		             },
	 		             {
	 		            	 text:'请注册',
	 		            	 iconCls:'',
	 		            	 handler:function(){
	 		            		window.location.href="<%=request.getContextPath()%>/register.jsp"
	 		            	 }
	 		             }
	 		           ]
	 		});    
	 	})
        //手机自定义验证
        $.extend($.fn.validatebox.defaults.rules, {
            phoneRex: {
                validator: function(value){
                    var rex=/^1[3-8]+\d{9}$/;
                    //var rex=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                    //区号：前面一个0，后面跟2-3位数字 ： 0\d{2,3}
                    //电话号码：7-8位数字： \d{7,8
                    //分机号：一般都是3位数字： \d{3,}
                    //这样连接起来就是验证电话的正则表达式了：/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/
                    var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                    if(rex.test(value)||rex2.test(value))
                    {
                        // alert('t'+value);
                        return true;
                    }else
                    {
                        //alert('false '+value);
                        return false;
                    }
                },
                message: '请输入正确电话或手机格式'
            }
        });

        var countdown=4;
        //随机生成验证码图片
        function getImageCode(val){

            if (countdown == 0) {
                var thisDate =  new Date();
                //区分当前请求和上一次请求
                document.getElementById("imgcoode").src="<%=request.getContextPath()%>/imageCode?sjNum="+thisDate.getTime();

                $(val).attr("disabled",false);
                $(val).val("免费获取验证码");
                countdown = 4;
            } else {
                $(val).attr("disabled", true);
                $(val).val('重新发送('+countdown+')');
                countdown--;
                setTimeout(function() {
                    getImageCode(val)
                },1000)
            }
        }

	 </script>
	 
</body>
</html>