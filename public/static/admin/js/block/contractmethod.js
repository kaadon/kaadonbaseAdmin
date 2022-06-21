define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'block.contractmethod/index',
        add_url: 'block.contractmethod/add',
        edit_url: 'block.contractmethod/edit',
        delete_url: 'block.contractmethod/delete',
        export_url: 'block.contractmethod/export',
        modify_url: 'block.contractmethod/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: "checkbox"},
                    {field: 'id', width: 80, title: 'ID'},
                    {field: 'sort', width: 80, title: '排序', edit: 'text'},
                    {field: 'title', minWidth: 80, title: '币种名称'},
                    {field: 'image', minWidth: 80, title: '币种图片', search: false, templet: ea.table.image},
                    {field: 'status', title: '币种状态', width: 85, search: 'select', selectList: {0: '禁用', 1: '启用'}, templet: ea.table.switch},
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