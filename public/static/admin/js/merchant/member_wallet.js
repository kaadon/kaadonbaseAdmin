define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'merchant.member_wallet/index',
        add_url: 'merchant.member_wallet/add',
        edit_url: 'merchant.member_wallet/edit',
        updateMobile_url: 'merchant.member_wallet/updateMobile',
        delete_url: 'merchant.member_wallet/delete',
        export_url: 'merchant.member_wallet/export',
        modify_url: 'merchant.member_wallet/modify',
        stock_url: 'merchant.member_wallet/stock',
        charge_url: 'merchant.member_wallet/charge',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                toolbar: ['refresh',[{
                    auth: 'charge',
                    field:'username',
                    class: 'layui-btn layui-btn-sm layuimini-btn-primary',
                    text: '会员充值',
                    title: '会员充值',
                    url: init.charge_url,
                    icon: 'fa fa-hourglass',
                    extend: 'data-table="' + init.table_render_id + '"',
                }], 'export'],
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'profile.nickname', width: 150, title: '昵称'},
                    {field: 'profile.mobile', width: 150, title: '手机'},
                    {field: 'cny', minWidth: 150,symbol:'金币', title: '总余额',templet:ea.table.money},
                    {field: 'create_time', minWidth: 80, title: '创建时间', search: 'range'},
                ]],
            });

            ea.listen();
        },
        charge: function () {
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