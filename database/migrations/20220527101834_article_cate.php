<?php

use think\migration\Migrator;
use think\migration\db\Column;

class ArticleCate extends Migrator
{
    /**
     * Change Method.
     *
     * Write your reversible migrations using this method.
     *
     * More information on writing migrations is available here:
     * http://docs.phinx.org/en/latest/migrations.html#the-abstractmigration-class
     *
     * The following commands can be used in this method and Phinx will
     * automatically reverse them when rolling back:
     *
     *    createTable
     *    renameTable
     *    addColumn
     *    renameColumn
     *    addIndex
     *    addForeignKey
     *
     * Remember to call "create()" or "update()" and NOT "save()" when working
     * with the Table class.
     */
    public function change()
    {
        $table = $this->table('article_cate', array('engine' => 'InnoDB'));
        $table->addColumn('title', 'string', array( 'limit' => 25, 'default' => '', 'comment' => '标题'))
            ->addColumn('image', 'string', array('default' => '', 'comment' => '封面'))
            ->addColumn('sort', 'integer', array('limit' => 4, 'default' => 0, 'comment' => '排序'))
            ->addColumn('status', 'boolean', array('limit' => 1, 'default' => 0, 'comment' => '状态'))
            ->addColumn('remark', 'string', array('limit' => 0, 'default' => '', 'comment' => '备注'))
            ->addColumn('create_time', 'datetime', array('limit' => 1, 'default' => 0, 'comment' => '创建时间'))
            ->addColumn('update_time', 'datetime', array('limit' => 1, 'default' => 0, 'comment' => '更新时间'))
            ->addColumn('delete_time', 'datetime', array('limit' => 1, 'default' => 0, 'comment' => '删除时间'))
            ->addIndex(array('id'), array('unique' => true))
            ->create();
    }
}
