<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/cssfile.css">

<!DOCTYPE HTML>
<html>
<head>
<title>局域网即时通信系统</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="聊天">
	<meta http-equiv="description" content="通信系统">
    <link type="image/x-icon" rel="shortcut icon" href="images/yclogo.png">
    <script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
    <script type="text/javascript">
    
    
    	$(function() {
    		$( "#uname" ).on({
    			blur:function() {
    				var val = $.trim( ( $(this).val() ) );
    				if( val === "" ){
    					$("#myh").css( "color", "red" );
    				}else{
    					startRequest( val );
    					$("#myh").css( "color", "#000" );
    				}
    			},
    			focus:function() {
    				$(this).select();//当 textarea 或文本类型的 input 元素中的文本被选择时，一下子选中所有
    				$("#myh").css( "color", "#000" );
    			}
    		});
    	});
    
    	function checkInfo() {
    		var val = $.trim( $( "#uname" ).val() );
    		if( val === ""){
    			$("#myh").css( "color", "red");
    			return;
    		}else{
    			$("#myform").submit();	
    		}
    	}
    	
    	var xmlHttp;
    	function createXMLHttpRequest() {//创建请求对象
    		if(window.XMLHttpRequest) {    
    			xmlHttp = new XMLHttpRequest();
    		}else if(window.ActiveXObject) {
    			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    		}
    	}
    	//发送请求
    	function startRequest(val) {
    		createXMLHttpRequest();
    		xmlHttp.onreadystatechange = function() {
    			if(xmlHttp.readyState == 4) {	//如果已经完成解析
    				
    				if(xmlHttp.status == 200) {	//如果请求是成功，并得到响应
    					var flag = $.trim( xmlHttp.responseText );
    					console.log(flag);
    					 if(flag == "true"){
    						 $("#myh").text("该用户已经登录").css("color", "red");
    						 $("#submit").attr("disabled", "true");
    					 }else{
    						 $("#myh").text("该用户可以登录").css("color", "green");
    						$("#submit").attr("disabled", null);
    					 }
    				
    				}
    			}
    		};
    		xmlHttp.open("POST", "doinfo.jsp");
    		xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    		xmlHttp.send("name="+val);
    	}
    </script>
</head>
  
<body>
  	<center>
  		<h1>局域网即时通信系统</h1>
    	<form action="dologin.jsp" method="post" id="myform">
    		用户名：<input type="text" name="uname" id="uname"/>
    		<input type="submit" value="进入" onsubmit="return checkInfo()" id="submit"/>
    	</form>
    	<h1 id="myh">请输入您的用户名...</h1>
    </center>
</body>
</html>
