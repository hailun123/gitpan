<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/include.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>
<!-- 条件查询表单 -->
<div class="easyui-panel">
    <form id="f" method="post">
        <table>
            <tr>
                <td>名称：</td>
                <td><input type="text" id="title" name="title" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td>价格</td>
                <td>
                    <input type="text" id="minprice" name="minprice" class="easyui-numberspinner"/>
                    <input type="text" id="maxprice" name="maxprice" class="easyui-numberspinner"/>
                </td>

            </tr>
            <tr>
                <td>所属类目</td>
                <td><input type="text" id="itemCatWhere" name="cid" class="easyui-textbox"/></td>

            </tr>
            <tr>
                <td>
                    <a id="btn" href="javascript:search()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
                </td>
                <td>
                    <a id="btn2" href="javascript:reset()" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">重置</a>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- easyui渲染方式二  datagrid() -->
<table id="itemDataGrid"></table>

<!-- datagrid 工具条 -->
<div id="tb">
    <a href="javascript:addItem()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
    <a href="javascript:deleteItem()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
    <a href="javascript:editItemInline()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" >开始编辑</a>
    <a href="javascript:updateItemInline()" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_green',plain:true" >修改</a>
    <a href="javascript:cancleEditItemInline()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" >取消修改</a>
    <a href="javascript:execlItemWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" >导出execl</a>
    <a href="javascript:sendEmailToLoginItem()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >发送email到当前登录账户</a>
</div>
<script type="text/javascript">
    var itemDataGrid = null;
    var itemFromDialog = null;
    var editor=null;
    //定义全局变量：当前编辑的行
    var editRow = undefined;
    /*开始编辑用户基本信息--行内编辑器*/

    function sendEmailToLoginItem(){

        $.post(
            '<%=request.getContextPath()%>/item/sendEmail.lun',
            function(data){
                alert(data.msg);
            },
            'json'
        )


    }

    //根据条件导出Excel
    function execlItemWhere() {
        $.post(
            '<%=request.getContextPath()%>/item/execlItemWhere.lun',
            $("#f").serialize(),
            function(data){
                $.messager.alert('信息',data.msg,'info');
            },
            'json'
        )
    }
    function editItemInline() {
        //获取当前被选中的行
        var rowSelected =  itemDataGrid.datagrid('getSelected');
        //当选中行不为空时，当前行开启 行编辑
        if (rowSelected) {
            //修改之前先关闭已经开启的编辑行，当调用endEdit该方法时会触发onAfterEdit事件
            if (editRow != undefined) {
                //endEdit结束编辑方法
                itemDataGrid.datagrid("endEdit", editRow);
            }
            //当无编辑行时
            if (editRow == undefined) {
                //获取到当前选择行的下标
                var index = itemDataGrid.datagrid("getRowIndex", rowSelected);
                //开启编辑
                itemDataGrid.datagrid("beginEdit", index);
                //把当前开启编辑的行赋值给全局变量editRow
                editRow = index;
            }
        }
    }
    //将修改用户信息更新到数据库
    function updateItemInline() {
//            关闭已经开启的编辑行，当调用endEdit该方法时会触发onAfterEdit事件，在事件中调用ajax更新后台

        itemDataGrid.datagrid("endEdit", editRow);
    }

    /*取消编辑用户基本信息*/
    function cancleEditItemInline(){
        editRow = undefined;
        //回滚所有从创建或者上一次调用acceptChanges函数后更改的数据。
        itemDataGrid.datagrid("rejectChanges");
    }
    //删除用户
    function deleteItem(){
        var strId='';
        var arr=$("#itemDataGrid").datagrid('getChecked')
        for(i=0;i<arr.length;i++){
            strId+=arr[i].id+",";
        }
        $.messager.confirm('确认','您确认想要删除这个吗？',function(r){
            if (r){
                $.post(
                    '<%=request.getContextPath()%>/item/deleteItem.lun',
                    {'strId':strId},
                    function(data){
                        alert(data.msg);
                        $("#itemDataGrid").datagrid('reload');
                    },
                    'json'
                )
            }
        });
    }
    /*新增用户dialog*/
    function addItem() {
        itemFromDialog =  $("<div/>").dialog({
            title: '新增用户',
            width: 600,
            height: 400,
            closed: false,
            cache: false,
            href: '<%=request.getContextPath()%>/item/toAdd.lun',
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'ext-icon-anchor',
                handler:function(){
                    //form表单验证通过，在ajax提交后台
                    if ($("#itemAddForm").form('validate')){
                        $.ajax({
                            url:'<%=request.getContextPath()%>/item/saveItem.lun',
                            type:'post',
                            async:true,
                            data:$("#itemAddForm").serialize(),
                            dataType:'json',
                            success:function(data){
                                $.messager.alert('信息',data.msg,'info')
                                itemFromDialog.dialog('destroy');
                                itemDataGrid.datagrid('reload');
                            },
                            error:function(){
                                $.messager.alert('信息','ajax失败','error');
                            }
                        });
                    }
                }
            },{
                text:'关闭',
                iconCls:'icon-remove',
                handler:function(){
                    //销毁当前dialog
                    itemFromDialog.dialog('destroy');
                }
            }],
        });
    }
    <!--页面加载时 查询itemlist集合 -->
    $(function(){
        itemDataGrid = $("#itemDataGrid").datagrid({
            url:'<%=request.getContextPath()%>/item/selectItem.lun',
            method:'post',
            pagination:true,
            rownumbers:true,
            pageNumber:1,
            pageSize:2,
            pageList:[2,4,6,8],
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            loadMsg:'候着。。。',
            toolbar: '#tb',
            //排序
            sortName:'id',
            sortOrder:'desc',
            columns:[
                [
                    // 对应item实体类的私有属性名sellPoint
                    {field:'',checkbox:true,width:120},
                    {field:'id',title:'ID',width:120,sortable:true,order:'desc'},
                    {field:'title',title:'品牌',width:120,
                        editor:{
                            type:'validatebox',
                            options: {
                                required: 'minLength',
                            }
                        }
                    },
                    {field:'price',title:'价格',width:120,
                        editor:{
                            type:'validatebox',
                            options: {
                                required: 'minLength[4]',
                            }
                        }
                    },
                    {field:'num',title:'库存',width:120,
                        editor:{
                            type:'validatebox',
                            options: {
                                required: 'minLength[4]',
                            }
                        }
                    },
                    {
                        field: 'cid', title: '品牌类别', width: 120,
                        editor: {
                            type: 'combobox',
                            options: {
                                url: sys.contextPath + '/itemCat/selectItemCatList.lun',
                                valueField: 'id',
                                textField: 'name',
                                required: true,
                            }
                        },
                        formatter: function (value, row, index) {
                            if (row.itemCat) {
                                return row.itemCat.name;
                            } else {
                                return '';
                            }
                        }
                    },
                    {field:'status',title:'商品状态',width:100,
                        formatter:function(value,row,index){
                            if (value == 1) {
                                return '正常'
                            } else if(value == 2){
                                return '下架'
                            }else{
                                return '删除'
                            }
                        }

                    },
                    {field:'created',title:'上架日期',width:120,
                        formatter: function (value, row, index) {

                            var date = new Date(value);

                            var year = date.getFullYear().toString();

                            var month = (date.getMonth() + 1);

                            var day = date.getDate().toString();

                            var hour = date.getHours().toString();

                            var minutes = date.getMinutes().toString();

                            var seconds = date.getSeconds().toString();

                            if (month < 10) {

                                month = "0" + month;

                            }

                            if (day < 10) {

                                day = "0" + day;

                            }

                            if (hour < 10) {

                                hour = "0" + hour;

                            }

                            if (minutes < 10) {

                                minutes = "0" + minutes;

                            }

                            if (seconds < 10) {

                                seconds = "0" + seconds;

                            }

                            return year + "/" + month + "/" + day + " " + hour + ":" + minutes + ":" + seconds;

                        }
                    },
                ]
            ],
            onAfterEdit: function (index, row, changes) {
                //endEdit该方法触发此事件
                console.info(row);
                console.info(typeof(row));
                var rowStr = JSON.stringify(row); //可以将json对象转换成json对符串
                console.info(rowStr);
                console.info(typeof (rowStr));
                $.ajax({
                    url:sys.contextPath+'/item/updateItemInfo.lun',
                    type:'post',
                    data:{'item':rowStr},
                    dataType:'json',
                    success:function (data) {
                        $.messager.alert('信息',data.msg,'info');
                    },
                    error:function () {
                        $.messager.alert('信息','ajax失败','error');
                    }
                })
                editRow=undefined;
            },
            onDblClickRow: function (index, row) {
                //双击开启编辑行
                if (editRow != undefined) {
                    itemDataGrid.datagrid("endEdit", editRow);
                }
                if (editRow == undefined) {
                    itemDataGrid.datagrid("beginEdit", index);
                    editRow = index;
                }
            }
        });
    });
    /*级别下拉列表框*/
    $(function(){
        $('#itemCatWhere').combobox({
            url: sys.contextPath + '/itemCat/selectItemCatList.lun',
            valueField:'id',
            textField:'name'
        });
    })
    /* 条件查询*/
    function search(){
        itemDataGrid.datagrid('load',{
            "whereMap['utitle']":$("#title").val().trim(),
            "whereMap['uminprice']":$("#minprice").val().trim(),
            "whereMap['umaxprice']":$("#maxprice").val().trim(),
            "whereMap['ucat']":$("#itemCatWhere").combobox('getValue'),
        })
    }

    //重置查询
    function reset(){
        $("#f").form('reset');
        search();
    }

</script>
</body>
</html>