define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'merchant.member_dashboard/index',
        add_url: 'merchant.member_dashboard/add',
        edit_url: 'merchant.member_dashboard/edit',
        updateMobile_url: 'merchant.member_dashboard/updateMobile',
        delete_url: 'merchant.member_dashboard/delete',
        export_url: 'merchant.member_dashboard/export',
        modify_url: 'merchant.member_dashboard/modify',
        stock_url: 'merchant.member_dashboard/stock',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                toolbar: ['refresh', 'export'],
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'profile.nickname', width: 150, title: '昵称'},
                    {field: 'profile.mobile', width: 150, title: '手机'},
                    {field: 'user_profit', minWidth: 150, title: '总盈亏金额'},
                    {field: 'user_recharge', minWidth: 150, title: '总充值金额'},
                    {field: 'user_withdraw', minWidth: 150, title: '总提现金额'},
                    {field: 'user_withdraw_examine', minWidth: 150, title: '用户提现金额（待审核提现）'},
                    {field: 'user_event', minWidth: 150, title: '投注总盈亏'},
                    {field: 'user_sizzler', minWidth: 150, title: '时时乐盈亏'},
                    {field: 'day_recharge', minWidth: 150, title: '今日充值'},
                    {field: 'day_withdraw', minWidth: 150, title: '总充值金额'},
                    {field: 'day_event_money', minWidth: 150, title: '今日比赛总投注金额'},
                    {field: 'day_event_number', minWidth: 150, title: '今日比赛总投注笔数'},
                    {field: 'day_event_award', minWidth: 150, title: '今日比赛总返奖金额'},
                    {field: 'day_event_profit', minWidth: 150, title: '今日比赛盈利金额'},
                    {field: 'day_sizzler_money', minWidth: 150, title: '今日休闲投注金额'},
                    {field: 'day_sizzler_number', minWidth: 150, title: '今日休闲投注笔数'},
                    {field: 'day_sizzler_award', minWidth: 150, title: '今日休闲返奖金额'},
                    {field: 'day_sizzler_profit', minWidth: 150, title: '今日休闲盈利金额'},
                    {field: 'day_event', minWidth: 150, title: '今日投注总盈亏'},
                    {field: 'day_sizzler', minWidth: 150, title: '今日时时乐盈亏'},
                    {field: 'create_time', minWidth: 80, title: '创建时间', search: 'range'},
                    // {
                    //     width: 250,
                    //     title: '操作',
                    //     templet: ea.table.tool,
                    //     operat: ['edit','delete']
                    // }
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