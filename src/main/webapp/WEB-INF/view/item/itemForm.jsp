<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/include.jsp" %>

<html>
<head>
    <title>新增商品</title>
</head>
<body>
<form id="itemAddForm" method="post">
    <table>
        <tr>
            <td>品牌名:</td>
            <td><input type="text" name="title" class="easyui-validatebox"  data-options="required:true" /></td>
        <tr>
            <td>价格:</td>
            <td><input type="text" name="price" class="easyui-validatebox"  data-options="required:true"  /></td>
        </tr>
        <tr>
            <td>库存:</td>
            <td><input type="text"  name="num" class="easyui-validatebox"  data-options="required:true" ></td>
        </tr>
        <tr>
            <td>品牌类别:</td>
            <td><input id="pid" name="parentId" class="easyui-combotree" data-options="required:true" /></td>
            </td>
        </tr>
        <tr>
            <td>商品状态:</td>
            <td>
                <select name="status">
                    <option value="1">正常</option>
                    <option value="2">下架</option>
                    <option value="3">删除</option>
                </select>
        </tr>
    </table>
</form>

<script type="text/javascript">

    /*品牌类别下拉列表框*/
    $(function(){
        $('#itemCat').combobox({
            url:sys.contextPath+'/itemCat/selectItemCatList.lun',
            valueField:'id',
            textField:'name'
        });
    })
    $('#pid').combotree({
        url:'<%=request.getContextPath()%>/itemCat/selectItemCatTree.lun',
        required: true,
        method:'post',
    });
</script>
</body>
</html>
