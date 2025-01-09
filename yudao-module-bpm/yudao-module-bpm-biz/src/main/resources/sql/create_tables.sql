-- 1. BPM 流程分類表
CREATE TABLE `bpm_category` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '分類編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `name` VARCHAR(100) NOT NULL COMMENT '分類名',
    `code` VARCHAR(50) NOT NULL COMMENT '分類標誌',
    `description` VARCHAR(500) COMMENT '分類描述',
    `status` TINYINT NOT NULL COMMENT '分類狀態',
    `sort` INT NOT NULL DEFAULT 0 COMMENT '分類排序',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code_tenant` (`code`, `tenant_id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程分類表';

-- 2. BPM 流程表單定義表
CREATE TABLE `bpm_form` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '表單編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `name` VARCHAR(100) NOT NULL COMMENT '表單名',
    `status` TINYINT NOT NULL COMMENT '狀態',
    `conf` TEXT NOT NULL COMMENT '表單配置',
    `fields` JSON COMMENT '表單項數組',
    `remark` VARCHAR(500) COMMENT '備註',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_status` (`tenant_id`, `status`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 工作流表單定義表';

-- 3. BPM 流程定義擴展表
CREATE TABLE `bpm_process_definition_info` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `process_definition_id` VARCHAR(64) NOT NULL COMMENT '流程定義的編號',
    `model_id` VARCHAR(64) NOT NULL COMMENT '流程模型的編號',
    `model_type` TINYINT NOT NULL COMMENT '流程模型的類型',
    `icon` VARCHAR(255) COMMENT '圖標',
    `description` VARCHAR(500) COMMENT '描述',
    `form_type` TINYINT NOT NULL COMMENT '表單類型',
    `form_id` BIGINT COMMENT '動態表單編號',
    `form_conf` TEXT COMMENT '表單的配置',
    `form_fields` JSON COMMENT '表單項的數組',
    `form_custom_create_path` VARCHAR(255) COMMENT '自定義表單的提交路徑',
    `form_custom_view_path` VARCHAR(255) COMMENT '自定義表單的查看路徑',
    `simple_model` TEXT COMMENT 'SIMPLE設計器模型數據',
    `visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可見',
    `sort` BIGINT DEFAULT 0 COMMENT '排序值',
    `start_user_ids` VARCHAR(1000) COMMENT '可發起用戶編號數組',
    `manager_user_ids` VARCHAR(1000) COMMENT '可管理用戶編號數組',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_process_definition_id` (`process_definition_id`),
    KEY `idx_form_id` (`form_id`),
    KEY `idx_visible` (`visible`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程定義擴展表';

-- 4. BPM 流程表達式表
CREATE TABLE `bpm_process_expression` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `name` VARCHAR(100) NOT NULL COMMENT '表達式名字',
    `status` TINYINT NOT NULL COMMENT '表達式狀態',
    `expression` TEXT NOT NULL COMMENT '表達式',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_status` (`tenant_id`, `status`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程表達式表';

-- 5. BPM 流程監聽器表
CREATE TABLE `bpm_process_listener` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `name` VARCHAR(100) NOT NULL COMMENT '監聽器名字',
    `status` TINYINT NOT NULL COMMENT '狀態',
    `type` VARCHAR(50) NOT NULL COMMENT '監聽類型',
    `event` VARCHAR(50) NOT NULL COMMENT '監聽事件',
    `value_type` VARCHAR(50) NOT NULL COMMENT '值類型',
    `value` VARCHAR(500) NOT NULL COMMENT '值',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_status` (`tenant_id`, `status`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程監聽器表';

-- 6. BPM 用戶組表
CREATE TABLE `bpm_user_group` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `name` VARCHAR(100) NOT NULL COMMENT '組名',
    `description` VARCHAR(500) COMMENT '描述',
    `status` TINYINT NOT NULL COMMENT '狀態',
    `user_ids` JSON COMMENT '成員用戶編號數組',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    KEY `idx_tenant_status` (`tenant_id`, `status`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 用戶組表';

-- 7. BPM OA請假表
CREATE TABLE `bpm_oa_leave` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '請假表單主键',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `user_id` BIGINT NOT NULL COMMENT '申請人的用戶編號',
    `type` VARCHAR(100) NOT NULL COMMENT '請假類型',
    `reason` VARCHAR(500) NOT NULL COMMENT '原因',
    `start_time` datetime NOT NULL COMMENT '開始時間',
    `end_time` datetime NOT NULL COMMENT '結束時間',
    `day` DECIMAL(10,1) NOT NULL COMMENT '請假天數',
    `status` TINYINT NOT NULL COMMENT '審批結果',
    `process_instance_id` VARCHAR(64) COMMENT '對應的流程編號',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_process_instance_id` (`process_instance_id`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM OA請假表';

-- 8. BPM 流程抄送表
CREATE TABLE `bpm_process_instance_copy` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    `tenant_id` BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    `start_user_id` BIGINT NOT NULL COMMENT '發起人Id',
    `process_instance_name` VARCHAR(255) NOT NULL COMMENT '流程名',
    `process_instance_id` VARCHAR(64) NOT NULL COMMENT '流程實例的編號',
    `category` VARCHAR(64) NOT NULL COMMENT '流程分類',
    `activity_id` VARCHAR(64) NOT NULL COMMENT '流程活動的編號',
    `activity_name` VARCHAR(255) NOT NULL COMMENT '流程活動的名字',
    `task_id` VARCHAR(64) COMMENT '流程任務的編號',
    `user_id` BIGINT NOT NULL COMMENT '用戶編號',
    `reason` VARCHAR(500) COMMENT '抄送意見',
    `creator` VARCHAR(64) DEFAULT '' COMMENT '創建者',
    `updater` VARCHAR(64) DEFAULT '' COMMENT '更新者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否刪除',
    PRIMARY KEY (`id`),
    KEY `idx_process_instance_id` (`process_instance_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BPM 流程抄送表';