define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'merchant.merchant/index',
        add_url: 'merchant.merchant/add',
        edit_url: 'merchant.merchant/edit',
        viewUser_url: 'merchant.members/index',
        delete_url: 'merchant.merchant/delete',
        export_url: 'merchant.merchant/export',
        modify_url: 'merchant.merchant/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'profile.mobile', minWidth: 200, title: '手机号'},
                    {field: 'uuid', minWidth: 80, title: '邀请码'},
                    {
                        field: 'type',
                        title: '类型',
                        width: 85,
                        search: 'select',
                        selectList: {0: '未认证', 1: '普通'},
                    },
                    {
                        field: 'agent',
                        title: '代理类型',
                        width: 120,
                        search: 'select',
                        selectList: {0: '总代理', 1: '二级代理', 3: '业务员'},
                        // templet: ea.table.switch
                    },
                    {
                        field: 'status',
                        title: '状态',
                        width: 85,
                        search: 'select',
                        selectList: {0: '冻结', 1: '正常'},
                        templet: ea.table.switch
                    },
                    {
                        field: 'authen',
                        minWidth: 80,
                        title: '实名状态',
                        search: 'select',
                        selectList: {0: "未认证", 1: "通过", 2: "审核中", 3: "被拒绝"}
                    },
                    {field: 'create_time', minWidth: 150, title: '创建时间', search: 'range'},
                    {
                        width: 250,
                        title: '操作',
                        templet: ea.table.tool,
                        operat: [
                            // [{
                            //     text: '查看用户',
                            //     url: init.viewUser_url,
                            //     field: 'id',
                            //     method: 'open',
                            //     class: 'layui-btn layui-btn-xs layui-btn-success',
                            //     extend: 'data-full="true"',
                            // }],
                            'edit','delete']
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
    };
    return Controller;
});