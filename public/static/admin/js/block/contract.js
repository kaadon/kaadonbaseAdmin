define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'block.contract/index',
        add_url: 'block.contract/add',
        edit_url: 'block.contract/edit',
        delete_url: 'block.contract/delete',
        export_url: 'block.contract/export',
        modify_url: 'block.contract/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'sort', width: 80, title: '排序', edit: 'text'},
                    {field: 'coin.title', minWidth: 80, title: '币种名称'},
                    {field: 'coin.image', minWidth: 80, title: '币种图片', search: false, templet: ea.table.image},
                    {field: 'chain.title', minWidth: 80, title: '链'},
                    {field: 'status', title: '币种状态', width: 85, search: 'select', selectList: {0: '禁用', 1: '启用'}, templet: ea.table.switch},
                    {field: 'withdrawal', title: '提现', width: 85, search: 'select', selectList: {0: '禁用', 1: '启用'}, templet: ea.table.switch},
                    {field: 'recharge', title: '充值', width: 85, search: 'select', selectList: {0: '禁用', 1: '启用'}, templet: ea.table.switch},
                    {field: 'create_time', minWidth: 80, title: '创建时间', search: 'range'},
                    {width: 250, title: '操作', templet: ea.table.tool}
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