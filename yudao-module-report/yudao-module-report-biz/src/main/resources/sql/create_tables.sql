CREATE TABLE `report_go_view_project` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `name` VARCHAR(100) NOT NULL COMMENT '項目名稱',
    `pic_url` VARCHAR(512) DEFAULT NULL COMMENT '預覽圖片URL',
    `content` TEXT COMMENT '報表內容(JSON配置)',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '發布狀態(0-已發布 1-未發布)',
    `remark` VARCHAR(500) DEFAULT NULL COMMENT '項目備註',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_id` (`tenant_id`) COMMENT '租戶索引',
    KEY `idx_create_time` (`create_time`) COMMENT '創建時間索引'
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='GoView項目表';