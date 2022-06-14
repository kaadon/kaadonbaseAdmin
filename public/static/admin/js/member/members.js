define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'merchant.members/index',
        add_url: 'merchant.members/add',
        edit_url: 'merchant.members/edit',
        updateMobile_url: 'merchant.members/updateMobile',
        delete_url: 'merchant.members/delete',
        export_url: 'merchant.members/export',
        modify_url: 'merchant.members/modify',
        stock_url: 'merchant.members/stock',
        charge_url: 'merchant.member_wallet/charge',
    };
    var agentLv = [
        ['总代理','red'],
        ['一级代理','#650404'],
        ['二级代理','blue'],
        ['三级代理','green'],
        ['四级代理','skyblue'],
        ['五级代理','#ff4400'],
        ['六级代理','orange'],
        ['七级代理','#2a38e5'],
        ['八级代理','#cc8809'],
        ['九级代理','#8409cc']
    ]
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                toolbar: ['refresh',
                    'delete', [{
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
                    // {field: 'profile.nickname', width: 150, title: '邀请码'},
                    {field: 'profile.realname', width: 150, title: '姓名'},
                    {field: 'profile.wechat', width: 150, title: '微信号'},
                    {field: 'profile.mobile', width: 150, title: '手机'},
                    {field: 'agent_line',minWidth: 175, title: '代理',templet: function  (data, option)  {
                        let html = ''
                            data.agent_profile.forEach((itemProfile,index)=>{
                                html += '<p style="color:' + agentLv[itemProfile.account.agent][1]+'"> <span>'+ agentLv[index][0]  +':</span>' + itemProfile.mobile+ ' | [<em style="color: #01397f">'+ itemProfile.id +'</em>]</p>';
                            })
                            return '<div style="text-align: left">' + html +'</div>'
                        }},
                    {field: 'wallet.cny', width: 150, title: '账户余额',symbol:"￥", templet: ea.table.money},
                    {field: 'status', title: '状态', width: 85, search: 'select', selectList: {0: '禁用', 1: '启用'}, templet: ea.table.switch,tips:'启用|禁用'},
                    {field: 'analog', title: '是否模拟号', width: 85, search: 'select', selectList: {0: '真实用户', 1: '模拟号'}, templet: ea.table.switch,tips:'模拟号|真实用户'},
                    // {field: 'authen', title: '状态', width: 85, selectList: {0: '未实名', 1: '正常'}},
                    {field: 'create_time', minWidth: 80, title: '创建时间', search: 'range'},
                    {
                        width: 250,
                        title: '操作',
                        templet: ea.table.tool,
                        operat: ['edit','delete']
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