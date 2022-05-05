define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'product.project/index',
        add_url: 'product.project/add',
        edit_url: 'product.project/edit',
        delete_url: 'product.project/delete',
        export_url: 'product.project/export',
        modify_url: 'product.project/modify',
        stock_url: 'product.project/stock',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                toolbar: ['refresh',
                    [{
                        text: '添加',
                        url: init.add_url,
                        method: 'open',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                        extend: 'data-full="true"',
                    }],
                    'delete', 'export'],
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'title', minWidth: 80, title: '项目名称'},
                    {field: 'create_at', minWidth: 80, title: '创建时间', search: 'range'},
                    {field: 'begin_time', minWidth: 80, title: '项目开始时间', search: 'range'},
                    {field: 'end_time', minWidth: 80, title: '项目结束时间', search: 'range'},
                    {field: 'money', minWidth: 80, title: '项目费用', search: 'range'},
                    {field: 'pay', minWidth: 80, title: '项目已付款', search: 'range'},
                    {field: 'remainder', minWidth: 80, title: '项目剩余款项', search: 'range'},
                    {
                        width: 250,
                        title: '操作',
                        templet: ea.table.tool,
                        operat: [
                            [{
                                text: '编辑',
                                url: init.edit_url,
                                method: 'open',
                                auth: 'edit',
                                class: 'layui-btn layui-btn-xs layui-btn-success',
                                extend: 'data-full="true"',
                            }, {
                                text: '入库',
                                url: init.stock_url,
                                method: 'open',
                                auth: 'stock',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }],
                            'delete']
                    }
                ]],
            });

            ea.listen();
        },
        add: function () {
            ea.listen();
        },
        edit: function () {
            ea.listen();
        },
        stock: function () {
            ea.listen();
        },
    };
    return Controller;
});