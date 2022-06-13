define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'merchant.member_record/index',
        add_url: 'merchant.member_record/add',
        edit_url: 'merchant.member_record/edit',
        updateMobile_url: 'merchant.member_record/updateMobile',
        delete_url: 'merchant.member_record/delete',
        export_url: 'merchant.member_record/export',
        modify_url: 'merchant.member_record/modify',
        stock_url: 'merchant.member_record/stock',
        charge_url: 'merchant.member_record/charge',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                toolbar: ['refresh',],
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'profile.nickname', width: 150, title: '昵称'},
                    {field: 'profile.mobile', width: 150, title: '手机'},
                    {field: 'business', width: 150, title: '业务', search: 'select', selectList: {1:"充值",2:"提现",3:"赛事中奖",4:"赛事投注",5:"提现退回",6:"后台充值",7:"时时乐中奖",8:"时时乐投注",9:"赛事投注未开奖退回"}},
                    {field: 'now', width: 150, title: '操作金额',templet:ea.table.money},
                    {field: 'after', width: 150, title: '当时余额',templet:ea.table.money},
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