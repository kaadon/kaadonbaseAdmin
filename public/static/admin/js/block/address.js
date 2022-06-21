define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'block.address/index',
        add_url: 'block.address/add',
        edit_url: 'block.address/edit',
        delete_url: 'block.address/delete',
        export_url: 'block.address/export',
        modify_url: 'block.address/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                toolbar: ['refresh', 'export'],
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'uid', minWidth: 80, title: '会员ID/商家ID'},
                    {field: 'chain.title', minWidth: 80, title: '链名称'},
                    {field: 'coin.title', minWidth: 80, title: '币种名称'},
                    {field: 'cate', title: '人员分类', minWidth: 85, search: 'select', selectList: {1: '商户地址', 2: '会员地址'}},
                    {field: 'type', title: '地址分类', minWidth: 85, search: 'select', selectList: {1: '充值', 1: '游戏1',2:'游戏二'}},
                    {field: 'sort', minWidth: 80, title: '排序', edit: 'text'},
                    {field: 'create_time', minWidth: 80, title: '创建时间', search: 'range'},
                    // {width: 250, title: '操作', templet: ea.table.tool}
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