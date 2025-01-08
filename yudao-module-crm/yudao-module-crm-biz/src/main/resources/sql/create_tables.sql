-- 1. CRM 商機表
CREATE TABLE `crm_business` (
    `id`                   BIGINT       NOT NULL AUTO_INCREMENT COMMENT '編號',
    `name`                 VARCHAR(128) NOT NULL COMMENT '商機名稱',
    `customer_id`         BIGINT       NOT NULL COMMENT '客戶編號',
    `follow_up_status`    TINYINT      NOT NULL DEFAULT 0 COMMENT '跟進狀態',
    `contact_last_time`   DATETIME     COMMENT '最後跟進時間',
    `contact_next_time`   DATETIME     COMMENT '下次聯繫時間',
    `owner_user_id`       BIGINT       NOT NULL COMMENT '負責人的用戶編號',
    `status_type_id`      BIGINT       NOT NULL COMMENT '商機狀態組編號',
    `status_id`           BIGINT       NOT NULL COMMENT '商機狀態編號',
    `end_status`          TINYINT      COMMENT '結束狀態',
    `end_remark`          VARCHAR(512) COMMENT '結束備註',
    `deal_time`           DATETIME     COMMENT '預計成交日期',
    `total_product_price` DECIMAL(10,2) COMMENT '產品總金額',
    `discount_percent`    DECIMAL(10,2) COMMENT '整單折扣(%)',
    `total_price`         DECIMAL(10,2) COMMENT '商機總金額',
    `remark`              VARCHAR(512) COMMENT '備註',
    `creator`             VARCHAR(64)  COMMENT '創建者',
    `updater`             VARCHAR(64)  COMMENT '更新者',
    `create_time`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`             TINYINT      NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`           BIGINT       NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    INDEX `idx_customer_id` (`customer_id`, `tenant_id`),
    INDEX `idx_status` (`status_type_id`, `status_id`, `tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 商機表';

-- 2. CRM 商機產品關聯表
CREATE TABLE `crm_business_product` (
    `id`              BIGINT        NOT NULL AUTO_INCREMENT COMMENT '主键',
    `business_id`     BIGINT        NOT NULL COMMENT '商機編號',
    `product_id`      BIGINT        NOT NULL COMMENT '產品編號',
    `product_price`   DECIMAL(10,2) NOT NULL COMMENT '產品單價',
    `business_price`  DECIMAL(10,2) NOT NULL COMMENT '商機價格',
    `count`           DECIMAL(10,2) NOT NULL COMMENT '數量',
    `total_price`     DECIMAL(10,2) NOT NULL COMMENT '總計價格',
    `creator`         VARCHAR(64)   COMMENT '創建者',
    `updater`         VARCHAR(64)   COMMENT '更新者',
    `create_time`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`         TINYINT       NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`       BIGINT        NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    INDEX `idx_business_id` (`business_id`, `tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 商機產品關聯表';

-- 3. CRM 商機狀態表
CREATE TABLE `crm_business_status` (
    `id`          BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
    `type_id`     BIGINT      NOT NULL COMMENT '狀態類型編號',
    `name`        VARCHAR(64) NOT NULL COMMENT '狀態名',
    `percent`     TINYINT     NOT NULL COMMENT '贏單率(%)',
    `sort`        INT         NOT NULL DEFAULT 0 COMMENT '排序',
    `creator`     VARCHAR(64) COMMENT '創建者',
    `updater`     VARCHAR(64) COMMENT '更新者',
    `create_time` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`     TINYINT     NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`   BIGINT      NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    INDEX `idx_type_id` (`type_id`, `tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 商機狀態表';

-- 4. CRM 商機狀態組表
CREATE TABLE `crm_business_status_type` (
    `id`          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        VARCHAR(64)  NOT NULL COMMENT '狀態類型名',
    `dept_ids`    VARCHAR(512) NOT NULL COMMENT '使用的部門編號',
    `creator`     VARCHAR(64)  COMMENT '創建者',
    `updater`     VARCHAR(64)  COMMENT '更新者',
    `create_time` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`     TINYINT      NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`   BIGINT       NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 商機狀態組表';

-- 5. CRM 線索表
CREATE TABLE `crm_clue` (
    `id`                    BIGINT       NOT NULL AUTO_INCREMENT COMMENT '編號',
    `name`                  VARCHAR(128) NOT NULL COMMENT '線索名稱',
    `follow_up_status`      TINYINT      NOT NULL DEFAULT 0 COMMENT '跟進狀態',
    `contact_last_time`     DATETIME     COMMENT '最後跟進時間',
    `contact_last_content`  VARCHAR(512) COMMENT '最後跟進內容',
    `contact_next_time`     DATETIME     COMMENT '下次聯繫時間',
    `owner_user_id`         BIGINT       NOT NULL COMMENT '負責人用戶編號',
    `transform_status`      TINYINT      NOT NULL DEFAULT 0 COMMENT '轉化狀態',
    `customer_id`           BIGINT       COMMENT '客戶編號',
    `mobile`                VARCHAR(32)  COMMENT '手機號',
    `telephone`             VARCHAR(32)  COMMENT '電話',
    `qq`                    VARCHAR(32)  COMMENT 'QQ',
    `wechat`               VARCHAR(32)  COMMENT '微信',
    `email`                VARCHAR(128) COMMENT '郵箱',
    `area_id`              INT          COMMENT '所在地區域編號',
    `detail_address`       VARCHAR(512) COMMENT '詳細地址',
    `industry_id`          INT          COMMENT '所屬行業',
    `level`                TINYINT      COMMENT '客戶等級',
    `source`               TINYINT      COMMENT '客戶來源',
    `remark`               VARCHAR(512) COMMENT '備註',
    `creator`              VARCHAR(64)  COMMENT '創建者',
    `updater`              VARCHAR(64)  COMMENT '更新者',
    `create_time`          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`              TINYINT      NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`            BIGINT       NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    INDEX `idx_customer_id` (`customer_id`, `tenant_id`),
    INDEX `idx_mobile` (`mobile`, `tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 線索表';

-- 6. CRM 聯系人與商機關聯表
CREATE TABLE `crm_contact_business` (
    `id`           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主鍵',
    `contact_id`   BIGINT      NOT NULL COMMENT '聯系人編號',
    `business_id`  BIGINT      NOT NULL COMMENT '商機編號',
    `creator`      VARCHAR(64) COMMENT '創建者',
    `updater`      VARCHAR(64) COMMENT '更新者',
    `create_time`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`      TINYINT     NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`    BIGINT      NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    INDEX `idx_contact_id` (`contact_id`, `tenant_id`),
    INDEX `idx_business_id` (`business_id`, `tenant_id`),
    UNIQUE KEY `uk_contact_business` (`contact_id`, `business_id`, `tenant_id`, `deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 聯系人商機關聯表';

-- 7. CRM 聯系人表
CREATE TABLE `crm_contact` (
    `id`                   BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主鍵',
    `name`                 VARCHAR(64)  NOT NULL COMMENT '聯系人姓名',
    `customer_id`          BIGINT       NOT NULL COMMENT '客戶編號',
    `contact_last_time`    DATETIME     COMMENT '最後跟進時間',
    `contact_last_content` VARCHAR(512) COMMENT '最後跟進內容',
    `contact_next_time`    DATETIME     COMMENT '下次聯系時間',
    `owner_user_id`        BIGINT       NOT NULL COMMENT '負責人用戶編號',
    `mobile`               VARCHAR(32)   COMMENT '手機號',
    `telephone`            VARCHAR(32)   COMMENT '電話',
    `email`                VARCHAR(128)  COMMENT '電子郵箱',
    `qq`                   BIGINT       COMMENT 'QQ',
    `wechat`              VARCHAR(32)   COMMENT '微信',
    `area_id`             INT          COMMENT '所在地',
    `detail_address`      VARCHAR(512) COMMENT '詳細地址',
    `sex`                 TINYINT      COMMENT '性別',
    `master`              TINYINT      NOT NULL DEFAULT 0 COMMENT '是否關鍵決策人',
    `post`                VARCHAR(64)  COMMENT '職位',
    `parent_id`           BIGINT      COMMENT '直屬上級',
    `remark`              VARCHAR(512) COMMENT '備註',
    `creator`             VARCHAR(64)  COMMENT '創建者',
    `updater`             VARCHAR(64)  COMMENT '更新者',
    `create_time`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`             TINYINT      NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`           BIGINT       NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    INDEX `idx_customer_id` (`customer_id`, `tenant_id`),
    INDEX `idx_mobile` (`mobile`, `tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 聯系人表';

-- 8. CRM 合同配置表
CREATE TABLE `crm_contract_config` (
    `id`             BIGINT    NOT NULL AUTO_INCREMENT COMMENT '編號',
    `notify_enabled` TINYINT   NOT NULL DEFAULT 0 COMMENT '是否開啟提前提醒',
    `notify_days`    INT       COMMENT '提前提醒天數',
    `creator`        VARCHAR(64) COMMENT '創建者',
    `updater`        VARCHAR(64) COMMENT '更新者',
    `create_time`    DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`    DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`        TINYINT    NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`      BIGINT     NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 合同配置表';

-- 9. CRM 合同表
CREATE TABLE `crm_contract` (
    `id`                  BIGINT         NOT NULL AUTO_INCREMENT COMMENT '合同編號',
    `name`                VARCHAR(128)   NOT NULL COMMENT '合同名稱',
    `no`                  VARCHAR(64)    NOT NULL COMMENT '合同編號',
    `customer_id`         BIGINT         NOT NULL COMMENT '客戶編號',
    `business_id`         BIGINT         COMMENT '商機編號',
    `contact_last_time`   DATETIME       COMMENT '最後跟進時間',
    `owner_user_id`       BIGINT         NOT NULL COMMENT '負責人用戶編號',
    `process_instance_id` VARCHAR(64)    COMMENT '工作流編號',
    `audit_status`        TINYINT        NOT NULL DEFAULT 0 COMMENT '審批狀態',
    `order_date`          DATETIME       NOT NULL COMMENT '下單日期',
    `start_time`          DATETIME       NOT NULL COMMENT '開始時間',
    `end_time`            DATETIME       NOT NULL COMMENT '結束時間',
    `total_product_price` DECIMAL(10,2)  NOT NULL COMMENT '產品總金額',
    `discount_percent`    DECIMAL(10,2)  NOT NULL DEFAULT 100 COMMENT '整單折扣',
    `total_price`         DECIMAL(10,2)  NOT NULL COMMENT '合同總金額',
    `sign_contact_id`     BIGINT         COMMENT '客戶簽約人',
    `sign_user_id`        BIGINT         COMMENT '公司簽約人',
    `remark`              VARCHAR(512)   COMMENT '備註',
    `creator`             VARCHAR(64)    COMMENT '創建者',
    `updater`             VARCHAR(64)    COMMENT '更新者',
    `create_time`         DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`         DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`             TINYINT        NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`           BIGINT         NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_no` (`no`, `tenant_id`, `deleted`),
    INDEX `idx_customer_id` (`customer_id`, `tenant_id`),
    INDEX `idx_business_id` (`business_id`, `tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 合同表';

-- 10. CRM 合同產品關聯表
CREATE TABLE `crm_contract_product` (
    `id`              BIGINT        NOT NULL AUTO_INCREMENT COMMENT '主鍵',
    `contract_id`     BIGINT        NOT NULL COMMENT '合同編號',
    `product_id`      BIGINT        NOT NULL COMMENT '產品編號',
    `product_price`   DECIMAL(10,2) NOT NULL COMMENT '產品單價',
    `contract_price`  DECIMAL(10,2) NOT NULL COMMENT '合同價格',
    `count`           DECIMAL(10,2) NOT NULL COMMENT '數量',
    `total_price`     DECIMAL(10,2) NOT NULL COMMENT '總計價格',
    `creator`         VARCHAR(64)   COMMENT '創建者',
    `updater`         VARCHAR(64)   COMMENT '更新者',
    `create_time`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    `update_time`     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    `deleted`         TINYINT       NOT NULL DEFAULT 0 COMMENT '是否刪除',
    `tenant_id`       BIGINT        NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (`id`),
    INDEX `idx_contract_id` (`contract_id`, `tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='CRM 合同產品關聯表';

-- 1.客戶表
CREATE TABLE crm_customer (
    id              BIGINT      NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id       BIGINT      NOT NULL DEFAULT 0 COMMENT '租戶編號',
    name            VARCHAR(100) NOT NULL COMMENT '客戶名稱',
    follow_up_status BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '跟進狀態',
    contact_last_time DATETIME   DEFAULT NULL COMMENT '最後跟進時間',
    contact_last_content VARCHAR(500) DEFAULT NULL COMMENT '最後跟進內容',
    contact_next_time DATETIME   DEFAULT NULL COMMENT '下次聯繫時間',
    owner_user_id   BIGINT      DEFAULT NULL COMMENT '負責人用戶編號',
    owner_time      DATETIME    DEFAULT NULL COMMENT '成為負責人的時間',
    lock_status     BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '鎖定狀態',
    deal_status     BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '成交狀態',
    mobile          VARCHAR(20)  DEFAULT NULL COMMENT '手機號碼',
    telephone       VARCHAR(20)  DEFAULT NULL COMMENT '電話號碼',
    qq              VARCHAR(20)  DEFAULT NULL COMMENT 'QQ',
    wechat          VARCHAR(30)  DEFAULT NULL COMMENT '微信',
    email           VARCHAR(50)  DEFAULT NULL COMMENT '郵箱',
    area_id         INT         DEFAULT NULL COMMENT '所在地區編號',
    detail_address  VARCHAR(200) DEFAULT NULL COMMENT '詳細地址',
    industry_id     INT         DEFAULT NULL COMMENT '所屬行業',
    level           INT         DEFAULT NULL COMMENT '客戶等級',
    source          INT         DEFAULT NULL COMMENT '客戶來源',
    remark          VARCHAR(500) DEFAULT NULL COMMENT '備註',
    creator         VARCHAR(64)  NOT NULL COMMENT '創建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater         VARCHAR(64)  NOT NULL COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_owner_user_id (owner_user_id),
    KEY idx_create_time (create_time),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM客戶表';

-- 2.客戶限制配置表
CREATE TABLE crm_customer_limit_config (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id       BIGINT       NOT NULL DEFAULT 0 COMMENT '租戶編號',
    type            INT          NOT NULL COMMENT '規則類型',
    user_ids        VARCHAR(1024) DEFAULT NULL COMMENT '規則適用人群',
    dept_ids        VARCHAR(1024) DEFAULT NULL COMMENT '規則適用部門',
    max_count       INT          NOT NULL COMMENT '數量上限',
    deal_count_enabled BOOLEAN    NOT NULL DEFAULT FALSE COMMENT '成交客戶是否占有擁有客戶數',
    creator         VARCHAR(64)   NOT NULL COMMENT '創建者',
    create_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater         VARCHAR(64)   NOT NULL COMMENT '更新者',
    update_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted         BOOLEAN      NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客戶限制配置表';

-- 3.客戶公海配置表
CREATE TABLE crm_customer_pool_config (
    id                BIGINT    NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id         BIGINT    NOT NULL DEFAULT 0 COMMENT '租戶編號',
    enabled           BOOLEAN   NOT NULL DEFAULT FALSE COMMENT '是否啟用客戶公海',
    contact_expire_days INT     DEFAULT NULL COMMENT '未跟進放入公海天數',
    deal_expire_days   INT     DEFAULT NULL COMMENT '未成交放入公海天數',
    notify_enabled     BOOLEAN  NOT NULL DEFAULT FALSE COMMENT '是否開啟提前提醒',
    notify_days        INT     DEFAULT NULL COMMENT '提前提醒天數',
    creator           VARCHAR(64) NOT NULL COMMENT '創建者',
    create_time       DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater           VARCHAR(64) NOT NULL COMMENT '更新者',
    update_time       DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted           BOOLEAN    NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客戶公海配置表';

-- 4.跟進記錄表
CREATE TABLE crm_follow_up_record (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id       BIGINT       NOT NULL DEFAULT 0 COMMENT '租戶編號',
    biz_type        INT          NOT NULL COMMENT '數據類型',
    biz_id          BIGINT       NOT NULL COMMENT '數據編號',
    type            INT          NOT NULL COMMENT '跟進類型',
    content         TEXT         NOT NULL COMMENT '跟進內容',
    next_time       DATETIME     DEFAULT NULL COMMENT '下次聯繫時間',
    pic_urls        VARCHAR(1024) DEFAULT NULL COMMENT '圖片地址',
    file_urls       VARCHAR(1024) DEFAULT NULL COMMENT '附件地址',
    business_ids    VARCHAR(1024) DEFAULT NULL COMMENT '關聯的商機編號數組',
    contact_ids     VARCHAR(1024) DEFAULT NULL COMMENT '關聯的聯繫人編號數組',
    creator         VARCHAR(64)   NOT NULL COMMENT '創建者',
    create_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater         VARCHAR(64)   NOT NULL COMMENT '更新者',
    update_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted         BOOLEAN      NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_biz_type_id (biz_type, biz_id),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='跟進記錄表';

-- 5.CRM數據權限表
CREATE TABLE crm_permission (
    id              BIGINT      NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id       BIGINT      NOT NULL DEFAULT 0 COMMENT '租戶編號',
    biz_type        INT         NOT NULL COMMENT '數據類型',
    biz_id          BIGINT      NOT NULL COMMENT '數據編號',
    user_id         BIGINT      NOT NULL COMMENT '用戶編號',
    level           INT         NOT NULL COMMENT '權限級別',
    creator         VARCHAR(64)  NOT NULL COMMENT '創建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater         VARCHAR(64)  NOT NULL COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_biz_user (biz_type, biz_id, user_id, deleted),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRM數據權限表';


-- 6.產品分類表
CREATE TABLE crm_product_category (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id       BIGINT       NOT NULL DEFAULT 0 COMMENT '租戶編號',
    name            VARCHAR(100)  NOT NULL COMMENT '分類名稱',
    parent_id       BIGINT       NOT NULL DEFAULT 0 COMMENT '父級編號',
    creator         VARCHAR(64)   NOT NULL COMMENT '創建者',
    create_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater         VARCHAR(64)   NOT NULL COMMENT '更新者',
    update_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted         BOOLEAN      NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_parent_id (parent_id),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='產品分類表';

-- 7.產品表
CREATE TABLE crm_product (
    id              BIGINT         NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id       BIGINT         NOT NULL DEFAULT 0 COMMENT '租戶編號',
    name            VARCHAR(100)    NOT NULL COMMENT '產品名稱',
    no              VARCHAR(50)     NOT NULL COMMENT '產品編碼',
    unit            INT            NOT NULL COMMENT '單位',
    price           DECIMAL(10,2)  NOT NULL COMMENT '價格',
    status          INT            NOT NULL COMMENT '狀態',
    category_id     BIGINT         NOT NULL COMMENT '產品分類ID',
    description     TEXT           DEFAULT NULL COMMENT '產品描述',
    owner_user_id   BIGINT         NOT NULL COMMENT '負責人用戶編號',
    creator         VARCHAR(64)     NOT NULL COMMENT '創建者',
    create_time     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater         VARCHAR(64)     NOT NULL COMMENT '更新者',
    update_time     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted         BOOLEAN        NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no, tenant_id, deleted),
    KEY idx_category_id (category_id),
    KEY idx_owner_user_id (owner_user_id),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='產品表';

-- 8.回款表
CREATE TABLE crm_receivable (
    id                  BIGINT         NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id           BIGINT         NOT NULL DEFAULT 0 COMMENT '租戶編號',
    no                  VARCHAR(50)     NOT NULL COMMENT '回款編號',
    plan_id             BIGINT         DEFAULT NULL COMMENT '回款計劃編號',
    customer_id         BIGINT         NOT NULL COMMENT '客戶編號',
    contract_id         BIGINT         NOT NULL COMMENT '合同編號',
    owner_user_id       BIGINT         NOT NULL COMMENT '負責人用戶編號',
    return_time         DATETIME       NOT NULL COMMENT '回款日期',
    return_type         INT            NOT NULL COMMENT '回款方式',
    price              DECIMAL(10,2)   NOT NULL COMMENT '計劃回款金額',
    remark             VARCHAR(500)    DEFAULT NULL COMMENT '備註',
    process_instance_id VARCHAR(64)    DEFAULT NULL COMMENT '工作流編號',
    audit_status        INT           NOT NULL COMMENT '審批狀態',
    creator             VARCHAR(64)    NOT NULL COMMENT '創建者',
    create_time         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater             VARCHAR(64)    NOT NULL COMMENT '更新者',
    update_time         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted             BOOLEAN       NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no, tenant_id, deleted),
    KEY idx_plan_id (plan_id),
    KEY idx_customer_id (customer_id),
    KEY idx_contract_id (contract_id),
    KEY idx_owner_user_id (owner_user_id),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='回款表';

-- 9.回款計劃表
CREATE TABLE crm_receivable_plan (
    id              BIGINT         NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id       BIGINT         NOT NULL DEFAULT 0 COMMENT '租戶編號',
    period          INT            NOT NULL COMMENT '期數',
    customer_id     BIGINT         NOT NULL COMMENT '客戶編號',
    contract_id     BIGINT         NOT NULL COMMENT '合同編號',
    owner_user_id   BIGINT         NOT NULL COMMENT '負責人用戶編號',
    return_time     DATETIME       NOT NULL COMMENT '計劃回款日期',
    return_type     INT            NOT NULL COMMENT '計劃回款類型',
    price           DECIMAL(10,2)  NOT NULL COMMENT '計劃回款金額',
    receivable_id   BIGINT         DEFAULT NULL COMMENT '回款編號',
    remind_days     INT            DEFAULT NULL COMMENT '提前幾天提醒',
    remind_time     DATETIME       DEFAULT NULL COMMENT '提醒日期',
    remark          VARCHAR(500)   DEFAULT NULL COMMENT '備註',
    creator         VARCHAR(64)     NOT NULL COMMENT '創建者',
    create_time     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater         VARCHAR(64)     NOT NULL COMMENT '更新者',
    update_time     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted         BOOLEAN        NOT NULL DEFAULT FALSE COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_customer_id (customer_id),
    KEY idx_contract_id (contract_id),
    KEY idx_owner_user_id (owner_user_id),
    KEY idx_receivable_id (receivable_id),
    KEY idx_tenant_id (tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='回款計劃表';