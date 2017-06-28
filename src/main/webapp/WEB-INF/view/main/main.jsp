<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/common/include.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>主页面</title>
<script type="text/javascript">
</script>
</head>
<body id="mainLayout" class="easyui-layout">
<div data-options="region:'north',href:'<%=request.getContextPath()%>/main/north.lun'" style="height: 70px; overflow: hidden;" class="logo"></div>
	<div data-options="region:'west',href:'',split:true" title="导航" style="width: 200px; padding: 10px;">
		<ul id="showMenu"></ul>
	</div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div id="showTabs" class="easyui-tabs" data-options="fit:true">
			<div title="首页" data-options="iconCls:'icon-filter'">
				<iframe src="<%=contextPath%>/admin/toAdminList.lun" allowTransparency="true" style=" width: 100%; height: 99%;" frameBorder="0"></iframe>
			</div>
		</div>
	</div>
	<div data-options="region:'south',href:'<%=contextPath%>/main/south.lun',border:false" style="height: 30px; overflow: hidden;"></div>

	<div id="loginDialog" title="解锁登录" style="display: none;">
		<form method="post" class="easyui-form" >
			<table class="table">
				<tr>
					<th width="50">登录名</th>
					<td><input name="loginname" readonly="readonly" type="" value="${sessionInfo.admin.phone }" /></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input name="pwd" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="passwordDialog" title="修改密码" style="display: none;">
		<form  method="post" class="easyui-form">
			<table class="table">
				<tr>
					<th>旧密码</th>
					<td><input id="oldpwd" name="oldPwd" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>新密码</th>
					<td><input id="newpwd" name="newPwd" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>重复密码</th>
					<td><input type="password" class="easyui-validatebox" data-options="required:true,validType:'equals[\'#newpwd\']'" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	<script type="text/javascript" charset="utf-8">
	
	//tree菜单
	var mainMenus;
	var mainTabs;

    $(function(){
        $("#showMenu").tree({
            data:[{
                "id": 1,
                "text": "商品",
                "state": "closed",
                "children": [{
                    "id": 11,
                    "text": "商品详细",
                },{
                    "id": 12,
                    "text": "商品类目"
                }]
            },{
                "id": 2,
                "text": "订单",
                "state": "closed",
                "children": [{
                    "id": 21,
                    "text": "订单列表"
                },{
                    "id": 22,
                    "text": "收货人"
                }]
            }],
            onClick:function(node){
                //node点击的当前节点
                //alert(node.text+node.attributes.url);
                addTabs(node);
            }
        });

        mainTabs = $('#showTabs').tabs({
            fit : true,
            border : false,
            tools : [ {
                text : '刷新',
                iconCls : 'ext-icon-arrow_refresh',
                handler : function() {
                    var panel = mainTabs.tabs('getSelected').panel('panel');
                    var frame = panel.find('iframe');
                    if (frame.length > 0) {
                        for ( var i = 0; i < frame.length; i++) {
                            frame[i].contentWindow.document.write('');
                            frame[i].contentWindow.close();
                            frame[i].src = frame[i].src;
                        }
                    }
                }
            }, {
                text : '关闭',
                iconCls : 'ext-icon-cross',
                handler : function() {
                    var index = mainTabs.tabs('getTabIndex', mainTabs.tabs('getSelected'));
                    var tab = mainTabs.tabs('getTab', index);
                    //	mainTabs.tabs('getSelected').panel('options');
                    if (tab.panel('options').closable) {
                        mainTabs.tabs('close', index);//title
                    } else {
                        $.messager.alert('提示', '[' + tab.panel('options').title + ']不可以被关闭！', 'error');
                    }
                }
            } ]
        });
    })

    function addTabs(node){
        var tabs = $("#showTabs")
        var text=node.text;
        var src ="";

        if(text=="商品详细"){
            src = "<%=request.getContextPath()%>";
        }
        if(text=="商品类目"){
            src = "<%=request.getContextPath()%>/itemCat/toItemList.lun";
        }
        if(text=="订单列表"){
            src = "<%=request.getContextPath()%>/orders/toOrderList.lun";
        }

        if (tabs.tabs('exists', node.text)) {
            tabs.tabs('select', node.text);
        } else {
            tabs.tabs('add',{
                title:node.text,
                content:formatString('<iframe src="{0}" allowTransparency="true" style="border:0;width:100%;height:99%;" frameBorder="0"></iframe>', src),
                closable:true,
                border : false,
                fit : true
            });
        }
    }


    function formatString(str) {
        for ( var i = 0; i < arguments.length - 1; i++) {
            str = str.replace("{" + i + "}", arguments[i + 1]);
        }
        return str;
    };

</script>
</body>
</html>