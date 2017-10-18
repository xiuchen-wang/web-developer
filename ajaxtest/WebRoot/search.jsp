<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
	#mydiv{
		position:absolute;
		left:50%;
		top:50%;
		margin-left:-200px;
		margin-top:-50px;
	}

	.mouseOver{
		background:#708090;
		color:#FFFAFA;
	}
	.mouseOut{
		background:#FFFAFA;
		color:#000000;
	}
</style>

<script>
    // 获得用户输入信息
    var xmlHttp ;
	function getMoreContents(){
    	var content = document.getElementById("keyword");
    	if(content.value == ""){
    		clearContent();
    		return;
    	}
    // alert(content.value);
    	// 获得XMLhttp对象
    	xmlHttp = createXMLHttp();
    	
    	// 给服务器发送数据
    // var url = "search?keyword=" + escape(contents.value);
    	var url = "search?keyword="+escape(content.value);
    	// true 表示js会在send()方法之后继续执行，而不会等待来自服务器的响应。
    	xmlHttp.open("GET",url,true);
    	// http状态（0-4）4为（complete）
    	xmlHttp.onreadystatechange = callback;
    	xmlHttp.send(null);    	
    }
    
	// 设置关联数据的展示
	function setContent(contents){
		// 清空子节点
		clearContent();
		setLocation();
		var size = contents.length;
		// 设置内容
		for(var i=0;i<size;i++){
			var nextNode = contents[i];
			var tr = document.createElement("tr");
			var td = document.createElement("td");
			td.setAttribute("border","0");
			td.setAttribute("bgcolor","#FFFAFA");
			td.onmouseover = function(){
				this.className = "mouseOver";
			}
			td.onmouseout = function(){
				this.className = "mouseOut";
			}
			td.onmousedown = function(){
				// 点击 内容为输入框
				document.getElementById("keyword").value = this.innerHTML;
			}
			var text = document.createTextNode(nextNode);
			td.appendChild(text);
			tr.appendChild(td);
			document.getElementById("content_table_body").appendChild(tr);
		}
	}
	// 回调函数
	function callback(){
		
		if(xmlHttp.readyState== 4 ){
			if(xmlHttp.status == 200){
				var result = xmlHttp.responseText;
				var json = eval("("+result+")");
				//alert(json);
				//内容显示到输入框的下面
				setContent(json);
			}
		}
		
	}
	
	// 清空数据
	function clearContent(){
		var contentTableBody = document.getElementById("content_table_body");
		var size = contentTableBody.childNodes.length;
		for(var i=size-1;i>=0;i--){
			contentTableBody.removeChild(contentTableBody.childNodes[i]);
		}
		document.getElementById("popDiv").style.border = null;	
	}
	
	// 失去焦点
	function keywordBlur(){
		clearContent();
	}
	// 设置位置
	function setLocation(){
		var content = document.getElementById("keyword");
		var width = content.offsetWidth;//输入框的宽度
		var left = content["offsetLeft"];//距离左边的距离
		var top = content["offsetTop"]+content.offsetTop;//到顶部的距离
		var popDiv = document.getElementById("popDiv");
		popDiv.style.border = "black 1px solid";
		popDiv.style.width = width + "px";
		popDiv.style.left = left + "px";
		popDiv.style.top = top + "px";
		document.getElementById("content_table").style.width = width + "px";
	
	}
    function createXMLHttp(){
    		var xmlHttp;
    		if(window.XMLHttpRequest){
    			xmlHttp = new XMLHttpRequest();
    		}
    	
    		//兼容性
    		if(window.ActiveXObject){
    			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    		}
    	
    		if(!xmlHttp){
    			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    		}
    		
    		return xmlHttp;
    }

</script>
<body>

	<div id="mydiv">
		<input type="text" size="50" id="keyword" onkeyup = "getMoreContents()" onblur="keywordBlur()"
		onfocus="getMoreContents()">
		<input type="button" value="搜索" width="50px">
		
		<div id="popDiv">
		<table id="content_table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0" >
		
			<tbody id="content_table_body">
			</tbody>
		
		</table>
		</div>
	</div>
	
	

</body>
</html>