-- 會員收件地址表
CREATE TABLE member_address (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    user_id BIGINT NOT NULL COMMENT '用戶編號',
    name VARCHAR(32) NOT NULL COMMENT '收件人名稱',
    mobile VARCHAR(32) NOT NULL COMMENT '手機號',
    area_id BIGINT NOT NULL COMMENT '地區編號',
    detail_address VARCHAR(255) NOT NULL COMMENT '收件詳細地址',
    default_status TINYINT NOT NULL DEFAULT 0 COMMENT '是否默認',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_user_id (user_id, deleted)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員收件地址';

-- 會員配置表
CREATE TABLE member_config (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主鍵',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    point_trade_deduct_enable TINYINT NOT NULL DEFAULT 0 COMMENT '積分抵扣開關',
    point_trade_deduct_unit_price INT NOT NULL DEFAULT 0 COMMENT '積分抵扣單價(分)',
    point_trade_deduct_max_price INT NOT NULL DEFAULT 0 COMMENT '積分抵扣最大值',
    point_trade_give_point INT NOT NULL DEFAULT 0 COMMENT '1元贈送積分數',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員配置';

-- 會員用戶分組表
CREATE TABLE member_group (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    name VARCHAR(32) NOT NULL COMMENT '組名',
    remark VARCHAR(255) DEFAULT '' COMMENT '備註',
    status TINYINT NOT NULL COMMENT '狀態',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_name (name, deleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員用戶分組';

-- 會員經驗記錄表
CREATE TABLE member_experience_record (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    user_id BIGINT NOT NULL COMMENT '用戶編號',
    biz_type TINYINT NOT NULL COMMENT '業務類型',
    biz_id VARCHAR(64) NOT NULL COMMENT '業務編號',
    title VARCHAR(64) NOT NULL COMMENT '標題',
    description VARCHAR(255) DEFAULT '' COMMENT '描述',
    experience INT NOT NULL COMMENT '經驗值',
    total_experience INT NOT NULL COMMENT '變更後的經驗值',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_user_id (user_id, create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員經驗記錄';

-- 會員等級表
CREATE TABLE member_level (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    name VARCHAR(32) NOT NULL COMMENT '等級名稱',
    level INT NOT NULL COMMENT '等級',
    experience INT NOT NULL COMMENT '升級經驗',
    discount_percent INT NOT NULL COMMENT '享受折扣',
    icon VARCHAR(255) DEFAULT '' COMMENT '等級圖標',
    background_url VARCHAR(255) DEFAULT '' COMMENT '等級背景圖',
    status TINYINT NOT NULL COMMENT '狀態',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_level (level, deleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員等級';

-- 會員等級記錄表
CREATE TABLE member_level_record (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    user_id BIGINT NOT NULL COMMENT '用戶編號',
    level_id BIGINT NOT NULL COMMENT '等級編號',
    level INT NOT NULL COMMENT '會員等級',
    discount_percent INT NOT NULL COMMENT '享受折扣',
    experience INT NOT NULL COMMENT '升級經驗',
    user_experience INT NOT NULL COMMENT '會員當前經驗',
    remark VARCHAR(255) DEFAULT '' COMMENT '備註',
    description VARCHAR(255) DEFAULT '' COMMENT '描述',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_user_id (user_id, create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員等級記錄';

-- 會員積分記錄表
CREATE TABLE member_point_record (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    user_id BIGINT NOT NULL COMMENT '用戶編號',
    biz_id VARCHAR(64) NOT NULL COMMENT '業務編號',
    biz_type TINYINT NOT NULL COMMENT '業務類型',
    title VARCHAR(64) NOT NULL COMMENT '標題',
    description VARCHAR(255) DEFAULT '' COMMENT '描述',
    point INT NOT NULL COMMENT '變動積分',
    total_point INT NOT NULL COMMENT '變動後的積分',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_user_id (user_id, create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員積分記錄';

-- 會員簽到規則表
CREATE TABLE member_sign_in_config (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '規則編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    day INT NOT NULL COMMENT '簽到第幾天',
    point INT NOT NULL COMMENT '獎勵積分',
    experience INT NOT NULL COMMENT '獎勵經驗',
    status TINYINT NOT NULL COMMENT '狀態',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_day (day, tenant_id, deleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員簽到規則';

-- 會員簽到記錄表
CREATE TABLE member_sign_in_record (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    user_id BIGINT NOT NULL COMMENT '簽到用戶',
    day INT NOT NULL COMMENT '第幾天簽到',
    point INT NOT NULL COMMENT '簽到獲得積分',
    experience INT NOT NULL COMMENT '簽到獲得經驗',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    KEY idx_user_id (user_id, day)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員簽到記錄';

-- 會員標籤表
CREATE TABLE member_tag (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '編號',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    name VARCHAR(32) NOT NULL COMMENT '標籤名稱',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_name (name, tenant_id, deleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員標籤';

-- 會員用戶表
CREATE TABLE member_user (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '用戶ID',
    tenant_id BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    mobile VARCHAR(32) NOT NULL COMMENT '手機號',
    password VARCHAR(100) NOT NULL COMMENT '加密後的密碼',
    status TINYINT NOT NULL COMMENT '帳號狀態',
    register_ip VARCHAR(32) NOT NULL COMMENT '註冊IP',
    register_terminal TINYINT NOT NULL COMMENT '註冊終端',
    login_ip VARCHAR(32) DEFAULT '' COMMENT '最後登錄IP',
    login_date DATETIME DEFAULT NULL COMMENT '最後登錄時間',
    nickname VARCHAR(32) DEFAULT '' COMMENT '用戶暱稱',
    avatar VARCHAR(255) DEFAULT '' COMMENT '用戶頭像',
    name VARCHAR(32) DEFAULT '' COMMENT '真實姓名',
    sex TINYINT DEFAULT 0 COMMENT '性別',
    birthday DATETIME DEFAULT NULL COMMENT '出生日期',
    area_id INT DEFAULT NULL COMMENT '所在地',
    mark VARCHAR(255) DEFAULT '' COMMENT '用戶備註',
    point INT NOT NULL DEFAULT 0 COMMENT '積分',
    tag_ids VARCHAR(1024) DEFAULT '' COMMENT '會員標籤列表',
    level_id BIGINT DEFAULT NULL COMMENT '會員等級編號',
    experience INT NOT NULL DEFAULT 0 COMMENT '會員經驗',
    group_id BIGINT DEFAULT NULL COMMENT '用戶分組編號',
    creator VARCHAR(64) DEFAULT '' COMMENT '創建者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    updater VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_mobile (mobile, tenant_id, deleted),
    KEY idx_status (status),
    KEY idx_level_id (level_id),
    KEY idx_group_id (group_id)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員用戶';