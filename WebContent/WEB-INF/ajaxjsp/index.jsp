<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>we test ajax</title>
 <style type="text/css">
 	#mydiv{
 		position:absolute;
 		left:50%;
 		top:50%;
 		margin-left:-200px;
 		margin-top:-50px;
 	}
 	.mouOver{
 		background:#708090;
 		color:#FFAFA;
 	}
 	.mouseOut
 	{
 		background:#FFFAFA;
 		color:#000000;
 	}
 </style>
 <script type="text/javascript">

 	var xmlHttp;
	function getMoreContents(){
		//首先获得用户的输入
		var content = document.getElementById("keyword");
		if(content.value == ""){
			clearContent();
			return ;
			}
		//alert(content.value);
		//然后给服务器发送用户输入的内容：ajax异步发送数据。
		//所以我们要使用xmlhttp对象
		xmlHttp = createXmlHttp();//获得XmlHttp对象;
		//alert(xmlHttp)
		//发送数据
		var url = "search?keyword="+escape(content.value);
		//true 表示js会在send（）方法之后继续执行，不会等待来自服务器的响应。
		//url=encodeURI(url);
		xmlHttp.open("GET",url,true);
		//xmlHttp绑定回调方法，这个回调方法会在xmlHttp状态改变的时候被调用 。
		//xmlHttp的状态是0-4,4表示complete;只是关心4就好
		//完成之后，在调用回调方法才有意义。
		xmlHttp.onreadystatechange = callback;
		xmlHttp.send(null);
		
		}
	//获得xmlhttp对象
	function createXmlHttp(){
		//对于大多数的浏览器都适用
			if(window.XMLHttpRequest){
					xmlHttp = new XMLHttpRequest();
				}
			//考虑浏览器的兼容问题
			if(window.ActiveXObject)
				{
					xmlHttp = new ActiveObject("Microsoft.XMLHTTP");
					if(!xmlHttp){
							xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
						}				
				}
			return xmlHttp;
		}
	//回调函数
	function callback(){
		if(xmlHttp.readyState == 4)
			{
			//200代表服务器响应成功
			//404代表资源未找到
				if(xmlHttp.status == 200)
					{
						//交互成功，获得相应的数据，是文本格式
						var result = xmlHttp.responseText;
						//解析获得数据
						var json = eval("("+result+")");
						//获得数据之后，就可以动态的显示这些数据了，把这些数据展示到输入框下面了
						//alert(json);
						setContent(json);
					}
			}
		}
	//设置传递过来的参数的显示
	function setContent(contents)
	{
		clearContent();
		//首先获得关联数据的长度，以此来确定生成多少<tr><td>
		var size = contents.length;
		for( var i = 0;i < size;i++)
			{
				var nextNode = contents[i];
				var tr = document.createElement("tr");
				var td = document.createElement("td");
				td.setAttribute("border","0");
				td.setAttribute("bgcolor","#FFFAFA");
				td.onmouseover = function(){
						this.className = 'mouseOver';
					};
				td.onmouseout = function()
				{
					this.className = 'mouseOut';
				};
				td.onclick = function(){
					//实现点击关联数据输入到数据框
					
					};
				var text = document.createTextNode(nextNode);
				td.appendChild(text);
				tr.appendChild(td);
				document.getElementById("content_table_body").appendChild(tr);
			}
	}
	//清空之前下拉框的数据
	function clearContent(){
		var contentTableBody = document.getElementById("content_table_body");
		var size = contentTableBody.childNodes.length;
		for(var i = size-1;i>0;i--)
			{
				contentTableBody.removeChild(contentTableBody.childNodes[i]);
			}
		}
	function keywordBlur()
	{
		//输入框失去焦点，清空
		clearContent();
	}
 </script>
</head>
<body>
	<div id="mydiv">
		<input type="text" size="50" id = "keyword" onkeyup="getMoreContents()" onblur="keywordBlur()" onfocus="getMoreContents()"/>
		<input type="button" value="百度一下" width="50px"/>
		<!-- 下面是内容显示的区域 -->
		<div id="popDiv">
			<table id="content_table" bgcolor="#FFFAFA" border="0" cellspacing="0">
				<tbody id="content_table_body">
				<!-- 动态查询出来的数据显示在这里 -->
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>