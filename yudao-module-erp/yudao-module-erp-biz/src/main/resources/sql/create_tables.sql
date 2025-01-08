-- 结算账户表
CREATE TABLE IF NOT EXISTS erp_account (
    id           BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '结算账户编号',
    name         VARCHAR(100) NOT NULL COMMENT '账户名称',
    no           VARCHAR(50)  NOT NULL COMMENT '账户编码',
    remark       VARCHAR(500) COMMENT '备注',
    status       TINYINT     NOT NULL COMMENT '开启状态',
    sort         INT         NOT NULL DEFAULT 0 COMMENT '排序',
    default_status BOOLEAN   NOT NULL DEFAULT FALSE COMMENT '是否默认',
    creator      VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建者',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater      VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新者',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted      BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    UNIQUE KEY uk_no (no, deleted),
    KEY idx_status_sort (status, sort, deleted)
) ENGINE = InnoDB COMMENT '结算账户';

-- 产品单位表
CREATE TABLE IF NOT EXISTS erp_product_unit (
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '单位编号',
    name        VARCHAR(100) NOT NULL COMMENT '单位名称',
    status      TINYINT     NOT NULL COMMENT '单位状态',
    creator     VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater     VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted     BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    UNIQUE KEY uk_name (name, deleted),
    KEY idx_status (status, deleted)
) ENGINE = InnoDB COMMENT '产品单位';

-- 产品分类表
CREATE TABLE IF NOT EXISTS erp_product_category (
    id          BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '分类编号',
    parent_id   BIGINT      NOT NULL DEFAULT 0 COMMENT '父分类编号',
    name        VARCHAR(100) NOT NULL COMMENT '分类名称',
    code        VARCHAR(50)  NOT NULL COMMENT '分类编码',
    sort        INT         NOT NULL DEFAULT 0 COMMENT '分类排序',
    status      TINYINT     NOT NULL COMMENT '开启状态',
    creator     VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater     VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted     BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    UNIQUE KEY uk_code (code, deleted),
    KEY idx_parent_sort (parent_id, sort, deleted),
    KEY idx_status (status, deleted)
) ENGINE = InnoDB COMMENT '产品分类';

-- 产品表
CREATE TABLE IF NOT EXISTS erp_product (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '产品编号',
    name            VARCHAR(200) NOT NULL COMMENT '产品名称',
    bar_code        VARCHAR(50)  NOT NULL COMMENT '产品条码',
    category_id     BIGINT      NOT NULL COMMENT '产品分类编号',
    unit_id         BIGINT      NOT NULL COMMENT '单位编号',
    status          TINYINT     NOT NULL COMMENT '产品状态',
    standard        VARCHAR(100) COMMENT '产品规格',
    remark          VARCHAR(500) COMMENT '产品备注',
    expiry_day      INT COMMENT '保质期天数',
    weight          DECIMAL(10,2) COMMENT '基础重量(kg)',
    purchase_price  DECIMAL(10,2) NOT NULL COMMENT '采购价格',
    sale_price      DECIMAL(10,2) NOT NULL COMMENT '销售价格',
    min_price       DECIMAL(10,2) NOT NULL COMMENT '最低价格',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    UNIQUE KEY uk_bar_code (bar_code, deleted),
    KEY idx_category (category_id, deleted),
    KEY idx_status (status, deleted)
) ENGINE = InnoDB COMMENT '产品';

-- 收款单表
CREATE TABLE IF NOT EXISTS erp_finance_receipt (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '编号',
    no              VARCHAR(50)  NOT NULL COMMENT '收款单号',
    status          TINYINT     NOT NULL COMMENT '收款状态',
    receipt_time    DATETIME    NOT NULL COMMENT '收款时间',
    finance_user_id BIGINT      NOT NULL COMMENT '财务人员编号',
    customer_id     BIGINT      NOT NULL COMMENT '客户编号',
    account_id      BIGINT      NOT NULL COMMENT '收款账户编号',
    total_price     DECIMAL(10,2) NOT NULL COMMENT '合计价格',
    discount_price  DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '优惠金额',
    receipt_price   DECIMAL(10,2) NOT NULL COMMENT '实付金额',
    remark          VARCHAR(500) COMMENT '备注',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    UNIQUE KEY uk_no (no, deleted),
    KEY idx_receipt_time (receipt_time, deleted),
    KEY idx_customer (customer_id, deleted),
    KEY idx_status (status, deleted)
) ENGINE = InnoDB COMMENT '收款单';

-- 收款项表
CREATE TABLE IF NOT EXISTS erp_finance_receipt_item (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '收款项编号',
    receipt_id      BIGINT      NOT NULL COMMENT '收款单编号',
    biz_type        TINYINT     NOT NULL COMMENT '业务类型',
    biz_id          BIGINT      NOT NULL COMMENT '业务编号',
    biz_no          VARCHAR(50) NOT NULL COMMENT '业务单号',
    total_price     DECIMAL(10,2) NOT NULL COMMENT '应收金额',
    receipted_price DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '已收金额',
    receipt_price   DECIMAL(10,2) NOT NULL COMMENT '本次收款',
    remark          VARCHAR(500) COMMENT '备注',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    KEY idx_receipt (receipt_id, deleted),
    KEY idx_biz (biz_type, biz_id, deleted)
) ENGINE = InnoDB COMMENT '收款项';

-- 付款单表
CREATE TABLE IF NOT EXISTS erp_finance_payment (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '编号',
    no              VARCHAR(50)  NOT NULL COMMENT '付款单号',
    status          TINYINT     NOT NULL COMMENT '付款状态',
    payment_time    DATETIME    NOT NULL COMMENT '付款时间',
    finance_user_id BIGINT      NOT NULL COMMENT '财务人员编号',
    supplier_id     BIGINT      NOT NULL COMMENT '供应商编号',
    account_id      BIGINT      NOT NULL COMMENT '付款账户编号',
    total_price     DECIMAL(10,2) NOT NULL COMMENT '合计价格',
    discount_price  DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '优惠金额',
    payment_price   DECIMAL(10,2) NOT NULL COMMENT '实付金额',
    remark          VARCHAR(500) COMMENT '备注',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    UNIQUE KEY uk_no (no, deleted),
    KEY idx_payment_time (payment_time, deleted),
    KEY idx_supplier (supplier_id, deleted),
    KEY idx_status (status, deleted)
) ENGINE = InnoDB COMMENT '付款单';

-- 付款项表
CREATE TABLE IF NOT EXISTS erp_finance_payment_item (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '付款项编号',
    payment_id      BIGINT      NOT NULL COMMENT '付款单编号',
    biz_type        TINYINT     NOT NULL COMMENT '业务类型',
    biz_id          BIGINT      NOT NULL COMMENT '业务编号',
    biz_no          VARCHAR(50) NOT NULL COMMENT '业务单号',
    total_price     DECIMAL(10,2) NOT NULL COMMENT '应付金额',
    paid_price      DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '已付金额',
    payment_price   DECIMAL(10,2) NOT NULL COMMENT '本次付款',
    remark          VARCHAR(500) COMMENT '备注',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    KEY idx_payment (payment_id, deleted),
    KEY idx_biz (biz_type, biz_id, deleted)
) ENGINE = InnoDB COMMENT '付款项';

-- 供应商表
CREATE TABLE IF NOT EXISTS erp_supplier (
    id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '供应商编号',
    name         VARCHAR(100) NOT NULL COMMENT '供应商名称',
    contact      VARCHAR(50) COMMENT '联系人',
    mobile       VARCHAR(20) COMMENT '手机号码',
    telephone    VARCHAR(20) COMMENT '联系电话',
    email        VARCHAR(100) COMMENT '电子邮箱',
    fax          VARCHAR(20) COMMENT '传真',
    remark       VARCHAR(500) COMMENT '备注',
    status       TINYINT NOT NULL COMMENT '开启状态',
    sort         INT COMMENT '排序',
    tax_no       VARCHAR(50) COMMENT '纳税人识别号',
    tax_percent  DECIMAL(8,2) COMMENT '税率',
    bank_name    VARCHAR(100) COMMENT '开户行',
    bank_account VARCHAR(100) COMMENT '开户账号',
    bank_address VARCHAR(200) COMMENT '开户地址',
    creator      VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater      VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted      TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_status_deleted (deleted, status),
    KEY idx_name (name)
) COMMENT '供应商表';

-- 采购订单表
CREATE TABLE IF NOT EXISTS erp_purchase_order (
    id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    no                  VARCHAR(50) NOT NULL COMMENT '采购订单号',
    status             TINYINT NOT NULL COMMENT '采购状态',
    supplier_id         BIGINT NOT NULL COMMENT '供应商编号',
    account_id         BIGINT NOT NULL COMMENT '结算账户编号',
    order_time         DATETIME NOT NULL COMMENT '下单时间',
    total_count        DECIMAL(10,2) NOT NULL COMMENT '合计数量',
    total_price        DECIMAL(10,2) NOT NULL COMMENT '最终合计价格',
    total_product_price DECIMAL(10,2) NOT NULL COMMENT '合计产品价格',
    total_tax_price    DECIMAL(10,2) NOT NULL COMMENT '合计税额',
    discount_percent   DECIMAL(8,2) COMMENT '优惠率',
    discount_price     DECIMAL(10,2) COMMENT '优惠金额',
    deposit_price      DECIMAL(10,2) COMMENT '定金金额',
    in_count          DECIMAL(10,2) DEFAULT 0 COMMENT '采购入库数量',
    return_count      DECIMAL(10,2) DEFAULT 0 COMMENT '采购退货数量',
    file_url          VARCHAR(500) COMMENT '附件地址',
    remark            VARCHAR(500) COMMENT '备注',
    creator           VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater           VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted           TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    tenant_id          BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no),
    KEY idx_status_deleted (deleted, status),
    KEY idx_supplier_id (supplier_id),
    KEY idx_order_time (order_time)
) COMMENT '采购订单表';

-- 采购订单项表
CREATE TABLE IF NOT EXISTS erp_purchase_order_items (
    id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    order_id         BIGINT NOT NULL COMMENT '采购订单编号',
    product_id       BIGINT NOT NULL COMMENT '产品编号',
    product_unit_id  BIGINT NOT NULL COMMENT '产品单位',
    product_price    DECIMAL(10,2) NOT NULL COMMENT '产品单价',
    count            DECIMAL(10,2) NOT NULL COMMENT '数量',
    total_price      DECIMAL(10,2) NOT NULL COMMENT '总价',
    tax_percent      DECIMAL(8,2) COMMENT '税率',
    tax_price        DECIMAL(10,2) COMMENT '税额',
    in_count         DECIMAL(10,2) DEFAULT 0 COMMENT '采购入库数量',
    return_count     DECIMAL(10,2) DEFAULT 0 COMMENT '采购退货数量',
    remark           VARCHAR(500) COMMENT '备注',
    creator          VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater          VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted          TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_order_deleted (deleted, order_id),
    KEY idx_product_id (product_id)
) COMMENT '采购订单项表';

-- 采购入库表
CREATE TABLE IF NOT EXISTS erp_purchase_in (
    id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    no                  VARCHAR(50) NOT NULL COMMENT '采购入库单号',
    status              TINYINT NOT NULL COMMENT '入库状态',
    supplier_id         BIGINT NOT NULL COMMENT '供应商编号',
    account_id          BIGINT NOT NULL COMMENT '结算账户编号',
    in_time             DATETIME NOT NULL COMMENT '入库时间',
    order_id            BIGINT COMMENT '采购订单编号',
    order_no            VARCHAR(50) COMMENT '采购订单号',
    total_count         DECIMAL(10,2) NOT NULL COMMENT '合计数量',
    total_price         DECIMAL(10,2) NOT NULL COMMENT '最终合计价格',
    total_product_price DECIMAL(10,2) NOT NULL COMMENT '合计产品价格',
    total_tax_price     DECIMAL(10,2) NOT NULL COMMENT '合计税额',
    discount_percent    DECIMAL(8,2) COMMENT '优惠率',
    discount_price      DECIMAL(10,2) COMMENT '优惠金额',
    other_price         DECIMAL(10,2) COMMENT '其它金额',
    payment_price       DECIMAL(10,2) DEFAULT 0 COMMENT '已支付金额',
    file_url           VARCHAR(500) COMMENT '附件地址',
    remark             VARCHAR(500) COMMENT '备注',
    creator            VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater            VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted            TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    tenant_id          BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no),
    KEY idx_status_deleted (deleted, status),
    KEY idx_supplier_id (supplier_id),
    KEY idx_order_id (order_id),
    KEY idx_in_time (in_time)
) COMMENT '采购入库表';

-- 采购入库项表
CREATE TABLE IF NOT EXISTS erp_purchase_in_items (
    id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    in_id            BIGINT NOT NULL COMMENT '采购入库编号',
    order_item_id    BIGINT COMMENT '采购订单项编号',
    warehouse_id     BIGINT NOT NULL COMMENT '仓库编号',
    product_id       BIGINT NOT NULL COMMENT '产品编号',
    product_unit_id  BIGINT NOT NULL COMMENT '产品单位',
    product_price    DECIMAL(10,2) NOT NULL COMMENT '产品单价',
    count            DECIMAL(10,2) NOT NULL COMMENT '数量',
    total_price      DECIMAL(10,2) NOT NULL COMMENT '总价',
    tax_percent      DECIMAL(8,2) COMMENT '税率',
    tax_price        DECIMAL(10,2) COMMENT '税额',
    remark           VARCHAR(500) COMMENT '备注',
    creator          VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater          VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted          TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_in_deleted (deleted, in_id),
    KEY idx_order_item_id (order_item_id),
    KEY idx_warehouse_id (warehouse_id),
    KEY idx_product_id (product_id)
) COMMENT '采购入库项表';

-- 采购退货表
CREATE TABLE IF NOT EXISTS erp_purchase_return (
    id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    no                  VARCHAR(50) NOT NULL COMMENT '采购退货单号',
    status              TINYINT NOT NULL COMMENT '退货状态',
    supplier_id         BIGINT NOT NULL COMMENT '供应商编号',
    account_id          BIGINT NOT NULL COMMENT '结算账户编号',
    return_time         DATETIME NOT NULL COMMENT '退货时间',
    order_id            BIGINT COMMENT '采购订单编号',
    order_no            VARCHAR(50) COMMENT '采购订单号',
    total_count         DECIMAL(10,2) NOT NULL COMMENT '合计数量',
    total_price         DECIMAL(10,2) NOT NULL COMMENT '最终合计价格',
    total_product_price DECIMAL(10,2) NOT NULL COMMENT '合计产品价格',
    total_tax_price     DECIMAL(10,2) NOT NULL COMMENT '合计税额',
    discount_percent    DECIMAL(8,2) COMMENT '优惠率',
    discount_price      DECIMAL(10,2) COMMENT '优惠金额',
    other_price         DECIMAL(10,2) COMMENT '其它金额',
    refund_price        DECIMAL(10,2) DEFAULT 0 COMMENT '已退款金额',
    file_url           VARCHAR(500) COMMENT '附件地址',
    remark             VARCHAR(500) COMMENT '备注',
    creator            VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater            VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted            TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    tenant_id          BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no),
    KEY idx_status_deleted (deleted, status),
    KEY idx_supplier_id (supplier_id),
    KEY idx_order_id (order_id),
    KEY idx_return_time (return_time)
) COMMENT '采购退货表';

-- 采购退货项表
CREATE TABLE IF NOT EXISTS erp_purchase_return_items (
    id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    return_id        BIGINT NOT NULL COMMENT '采购退货编号',
    order_item_id    BIGINT COMMENT '采购订单项编号',
    warehouse_id     BIGINT NOT NULL COMMENT '仓库编号',
    product_id       BIGINT NOT NULL COMMENT '产品编号',
    product_unit_id  BIGINT NOT NULL COMMENT '产品单位',
    product_price    DECIMAL(10,2) NOT NULL COMMENT '产品单价',
    count            DECIMAL(10,2) NOT NULL COMMENT '数量',
    total_price      DECIMAL(10,2) NOT NULL COMMENT '总价',
    tax_percent      DECIMAL(8,2) COMMENT '税率',
    tax_price        DECIMAL(10,2) COMMENT '税额',
    remark           VARCHAR(500) COMMENT '备注',
    creator          VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater          VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted          TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_return_deleted (deleted, return_id),
    KEY idx_order_item_id (order_item_id),
    KEY idx_warehouse_id (warehouse_id),
    KEY idx_product_id (product_id)
) COMMENT '采购退货项表';

-- 客户表
CREATE TABLE IF NOT EXISTS erp_customer (
    id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '客户编号',
    name         VARCHAR(100) NOT NULL COMMENT '客户名称',
    contact      VARCHAR(50) COMMENT '联系人',
    mobile       VARCHAR(20) COMMENT '手机号码',
    telephone    VARCHAR(20) COMMENT '联系电话',
    email        VARCHAR(100) COMMENT '电子邮箱',
    fax          VARCHAR(20) COMMENT '传真',
    remark       VARCHAR(500) COMMENT '备注',
    status       TINYINT NOT NULL COMMENT '开启状态',
    sort         INT COMMENT '排序',
    tax_no       VARCHAR(50) COMMENT '纳税人识别号',
    tax_percent  DECIMAL(8,2) COMMENT '税率',
    bank_name    VARCHAR(100) COMMENT '开户行',
    bank_account VARCHAR(100) COMMENT '开户账号',
    bank_address VARCHAR(200) COMMENT '开户地址',
    creator      VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater      VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted      TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_status_deleted (deleted, status),
    KEY idx_name (name)
) COMMENT '客户表';

-- 销售订单表
CREATE TABLE IF NOT EXISTS erp_sale_order (
    id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    no                  VARCHAR(50) NOT NULL COMMENT '销售订单号',
    status              TINYINT NOT NULL COMMENT '销售状态',
    customer_id         BIGINT NOT NULL COMMENT '客户编号',
    account_id          BIGINT NOT NULL COMMENT '结算账户编号',
    sale_user_id        BIGINT NOT NULL COMMENT '销售员编号',
    order_time          DATETIME NOT NULL COMMENT '下单时间',
    total_count         DECIMAL(10,2) NOT NULL COMMENT '合计数量',
    total_price         DECIMAL(10,2) NOT NULL COMMENT '最终合计价格',
    total_product_price DECIMAL(10,2) NOT NULL COMMENT '合计产品价格',
    total_tax_price     DECIMAL(10,2) NOT NULL COMMENT '合计税额',
    discount_percent    DECIMAL(8,2) COMMENT '优惠率',
    discount_price      DECIMAL(10,2) COMMENT '优惠金额',
    deposit_price       DECIMAL(10,2) COMMENT '定金金额',
    out_count           DECIMAL(10,2) DEFAULT 0 COMMENT '销售出库数量',
    return_count        DECIMAL(10,2) DEFAULT 0 COMMENT '销售退货数量',
    file_url           VARCHAR(500) COMMENT '附件地址',
    remark             VARCHAR(500) COMMENT '备注',
    creator            VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater            VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted            TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no),
    KEY idx_status_deleted (deleted, status),
    KEY idx_customer_id (customer_id),
    KEY idx_sale_user_id (sale_user_id),
    KEY idx_order_time (order_time)
) COMMENT '销售订单表';

-- 销售订单项表
CREATE TABLE IF NOT EXISTS erp_sale_order_items (
    id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    order_id         BIGINT NOT NULL COMMENT '销售订单编号',
    product_id       BIGINT NOT NULL COMMENT '产品编号',
    product_unit_id  BIGINT NOT NULL COMMENT '产品单位',
    product_price    DECIMAL(10,2) NOT NULL COMMENT '产品单价',
    count            DECIMAL(10,2) NOT NULL COMMENT '数量',
    total_price      DECIMAL(10,2) NOT NULL COMMENT '总价',
    tax_percent      DECIMAL(8,2) COMMENT '税率',
    tax_price        DECIMAL(10,2) COMMENT '税额',
    out_count        DECIMAL(10,2) DEFAULT 0 COMMENT '销售出库数量',
    return_count     DECIMAL(10,2) DEFAULT 0 COMMENT '销售退货数量',
    remark           VARCHAR(500) COMMENT '备注',
    creator          VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater          VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted          TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_order_deleted (deleted, order_id),
    KEY idx_product_id (product_id)
) COMMENT '销售订单项表';

-- 销售出库表
CREATE TABLE IF NOT EXISTS erp_sale_out (
    id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    no                  VARCHAR(50) NOT NULL COMMENT '销售出库单号',
    status              TINYINT NOT NULL COMMENT '出库状态',
    customer_id         BIGINT NOT NULL COMMENT '客户编号',
    account_id          BIGINT NOT NULL COMMENT '结算账户编号',
    sale_user_id        BIGINT NOT NULL COMMENT '销售员编号',
    out_time            DATETIME NOT NULL COMMENT '出库时间',
    order_id            BIGINT COMMENT '销售订单编号',
    order_no            VARCHAR(50) COMMENT '销售订单号',
    total_count         DECIMAL(10,2) NOT NULL COMMENT '合计数量',
    total_price         DECIMAL(10,2) NOT NULL COMMENT '最终合计价格',
    total_product_price DECIMAL(10,2) NOT NULL COMMENT '合计产品价格',
    total_tax_price     DECIMAL(10,2) NOT NULL COMMENT '合计税额',
    discount_percent    DECIMAL(8,2) COMMENT '优惠率',
    discount_price      DECIMAL(10,2) COMMENT '优惠金额',
    other_price         DECIMAL(10,2) COMMENT '其它金额',
    receipt_price       DECIMAL(10,2) DEFAULT 0 COMMENT '已收款金额',
    file_url           VARCHAR(500) COMMENT '附件地址',
    remark             VARCHAR(500) COMMENT '备注',
    creator            VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater            VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted            TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    tenant_id          BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no),
    KEY idx_status_deleted (deleted, status),
    KEY idx_customer_id (customer_id),
    KEY idx_sale_user_id (sale_user_id),
    KEY idx_order_id (order_id),
    KEY idx_out_time (out_time)
) COMMENT '销售出库表';

-- 销售出库项表
CREATE TABLE IF NOT EXISTS erp_sale_out_items (
    id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    out_id           BIGINT NOT NULL COMMENT '销售出库编号',
    order_item_id    BIGINT COMMENT '销售订单项编号',
    warehouse_id     BIGINT NOT NULL COMMENT '仓库编号',
    product_id       BIGINT NOT NULL COMMENT '产品编号',
    product_unit_id  BIGINT NOT NULL COMMENT '产品单位',
    product_price    DECIMAL(10,2) NOT NULL COMMENT '产品单价',
    count            DECIMAL(10,2) NOT NULL COMMENT '数量',
    total_price      DECIMAL(10,2) NOT NULL COMMENT '总价',
    tax_percent      DECIMAL(8,2) COMMENT '税率',
    tax_price        DECIMAL(10,2) COMMENT '税额',
    remark           VARCHAR(500) COMMENT '备注',
    creator          VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater          VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted          TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_out_deleted (deleted, out_id),
    KEY idx_order_item_id (order_item_id),
    KEY idx_warehouse_id (warehouse_id),
    KEY idx_product_id (product_id)
) COMMENT '销售出库项表';

-- 销售退货表
CREATE TABLE IF NOT EXISTS erp_sale_return (
    id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    no                  VARCHAR(50) NOT NULL COMMENT '销售退货单号',
    status              TINYINT NOT NULL COMMENT '退货状态',
    customer_id         BIGINT NOT NULL COMMENT '客户编号',
    account_id          BIGINT NOT NULL COMMENT '结算账户编号',
    sale_user_id        BIGINT NOT NULL COMMENT '销售员编号',
    return_time         DATETIME NOT NULL COMMENT '退货时间',
    order_id            BIGINT COMMENT '销售订单编号',
    order_no            VARCHAR(50) COMMENT '销售订单号',
    total_count         DECIMAL(10,2) NOT NULL COMMENT '合计数量',
    total_price         DECIMAL(10,2) NOT NULL COMMENT '最终合计价格',
    total_product_price DECIMAL(10,2) NOT NULL COMMENT '合计产品价格',
    total_tax_price     DECIMAL(10,2) NOT NULL COMMENT '合计税额',
    discount_percent    DECIMAL(8,2) COMMENT '优惠率',
    discount_price      DECIMAL(10,2) COMMENT '优惠金额',
    other_price         DECIMAL(10,2) COMMENT '其它金额',
    refund_price        DECIMAL(10,2) DEFAULT 0 COMMENT '已退款金额',
    file_url           VARCHAR(500) COMMENT '附件地址',
    remark             VARCHAR(500) COMMENT '备注',
    creator            VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater            VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted            TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    tenant_id          BIGINT NOT NULL DEFAULT 0 COMMENT '租戶編號',
    PRIMARY KEY (id),
    UNIQUE KEY uk_no (no),
    KEY idx_status_deleted (deleted, status),
    KEY idx_customer_id (customer_id),
    KEY idx_sale_user_id (sale_user_id),
    KEY idx_order_id (order_id),
    KEY idx_return_time (return_time)
) COMMENT '销售退货表';

-- 销售退货项表
CREATE TABLE IF NOT EXISTS erp_sale_return_items (
    id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
    return_id        BIGINT NOT NULL COMMENT '销售退货编号',
    order_item_id    BIGINT COMMENT '销售订单项编号',
    warehouse_id     BIGINT NOT NULL COMMENT '仓库编号',
    product_id       BIGINT NOT NULL COMMENT '产品编号',
    product_unit_id  BIGINT NOT NULL COMMENT '产品单位',
    product_price    DECIMAL(10,2) NOT NULL COMMENT '产品单价',
    count            DECIMAL(10,2) NOT NULL COMMENT '数量',
    total_price      DECIMAL(10,2) NOT NULL COMMENT '总价',
    tax_percent      DECIMAL(8,2) COMMENT '税率',
    tax_price        DECIMAL(10,2) COMMENT '税额',
    remark           VARCHAR(500) COMMENT '备注',
    creator          VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater          VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted          TINYINT NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (id),
    KEY idx_return_deleted (deleted, return_id),
    KEY idx_order_item_id (order_item_id),
    KEY idx_warehouse_id (warehouse_id),
    KEY idx_product_id (product_id)
) COMMENT '销售退货项表';

-- ERP销售出库项表
CREATE TABLE IF NOT EXISTS erp_sale_out_items (
    id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '编号',
    out_id       BIGINT      NOT NULL COMMENT '销售出库编号',
    order_item_id BIGINT     NOT NULL COMMENT '销售订单项编号',
    warehouse_id BIGINT      NOT NULL COMMENT '仓库编号',
    product_id   BIGINT      NOT NULL COMMENT '产品编号',
    product_unit_id BIGINT   NOT NULL COMMENT '产品单位',
    product_price DECIMAL(10, 2) NOT NULL COMMENT '产品单位单价',
    count        DECIMAL(10, 2) NOT NULL COMMENT '数量',
    total_price  DECIMAL(10, 2) NOT NULL COMMENT '总价',
    tax_percent  DECIMAL(10, 2) NOT NULL COMMENT '税率',
    tax_price    DECIMAL(10, 2) NOT NULL COMMENT '税额',
    remark       VARCHAR(500) COMMENT '备注',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    INDEX idx_out_id (out_id, deleted),
    INDEX idx_order_item_id (order_item_id, deleted),
    INDEX idx_warehouse_product (warehouse_id, product_id, deleted)
) ENGINE = InnoDB COMMENT 'ERP销售出库项';

-- ERP销售退货表
CREATE TABLE IF NOT EXISTS erp_sale_return (
    id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '编号',
    no           VARCHAR(64)  NOT NULL COMMENT '销售退货单号',
    status       TINYINT     NOT NULL COMMENT '退货状态',
    customer_id  BIGINT      NOT NULL COMMENT '客户编号',
    account_id   BIGINT      NOT NULL COMMENT '结算账户编号',
    sale_user_id BIGINT      NOT NULL COMMENT '销售员编号',
    return_time  DATETIME    NOT NULL COMMENT '退货时间',
    order_id     BIGINT      NOT NULL COMMENT '销售订单编号',
    order_no     VARCHAR(64) NOT NULL COMMENT '销售订单号',
    total_count  DECIMAL(10, 2) NOT NULL COMMENT '合计数量',
    total_price  DECIMAL(10, 2) NOT NULL COMMENT '最终合计价格',
    refund_price DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '已退款金额',
    total_product_price DECIMAL(10, 2) NOT NULL COMMENT '合计产品价格',
    total_tax_price DECIMAL(10, 2) NOT NULL COMMENT '合计税额',
    discount_percent DECIMAL(10, 2) COMMENT '优惠率',
    discount_price DECIMAL(10, 2) COMMENT '优惠金额',
    other_price  DECIMAL(10, 2) COMMENT '其它金额',
    file_url     VARCHAR(500) COMMENT '附件地址',
    remark       VARCHAR(500) COMMENT '备注',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE INDEX idx_no (no, deleted),
    INDEX idx_customer (customer_id, deleted),
    INDEX idx_order (order_id, deleted),
    INDEX idx_status_time (status, return_time, deleted)
) ENGINE = InnoDB COMMENT 'ERP销售退货';

-- ERP销售退货项表
CREATE TABLE IF NOT EXISTS erp_sale_return_items (
    id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '编号',
    return_id    BIGINT      NOT NULL COMMENT '销售退货编号',
    order_item_id BIGINT     NOT NULL COMMENT '销售订单项编号',
    warehouse_id BIGINT      NOT NULL COMMENT '仓库编号',
    product_id   BIGINT      NOT NULL COMMENT '产品编号',
    product_unit_id BIGINT   NOT NULL COMMENT '产品单位',
    product_price DECIMAL(10, 2) NOT NULL COMMENT '产品单位单价',
    count        DECIMAL(10, 2) NOT NULL COMMENT '数量',
    total_price  DECIMAL(10, 2) NOT NULL COMMENT '总价',
    tax_percent  DECIMAL(10, 2) NOT NULL COMMENT '税率',
    tax_price    DECIMAL(10, 2) NOT NULL COMMENT '税额',
    remark       VARCHAR(500) COMMENT '备注',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    INDEX idx_return_id (return_id, deleted),
    INDEX idx_order_item_id (order_item_id, deleted),
    INDEX idx_warehouse_product (warehouse_id, product_id, deleted)
) ENGINE = InnoDB COMMENT 'ERP销售退货项';

-- ERP库存盘点表
CREATE TABLE IF NOT EXISTS erp_stock_check (
    id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '盘点编号',
    no           VARCHAR(64)  NOT NULL COMMENT '盘点单号',
    check_time   DATETIME    NOT NULL COMMENT '盘点时间',
    total_count  DECIMAL(10, 2) NOT NULL COMMENT '合计数量',
    total_price  DECIMAL(10, 2) NOT NULL COMMENT '合计金额',
    status       TINYINT     NOT NULL COMMENT '状态',
    remark       VARCHAR(500) COMMENT '备注',
    file_url     VARCHAR(500) COMMENT '附件URL',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE INDEX idx_no (no, deleted),
    INDEX idx_status_time (status, check_time, deleted)
) ENGINE = InnoDB COMMENT 'ERP库存盘点';

-- ERP库存盘点项表
CREATE TABLE IF NOT EXISTS erp_stock_check_item (
    id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '盘点项编号',
    check_id     BIGINT      NOT NULL COMMENT '盘点编号',
    warehouse_id BIGINT      NOT NULL COMMENT '仓库编号',
    product_id   BIGINT      NOT NULL COMMENT '产品编号',
    product_unit_id BIGINT   NOT NULL COMMENT '产品单位编号',
    product_price DECIMAL(10, 2) NOT NULL COMMENT '产品单价',
    stock_count  DECIMAL(10, 2) NOT NULL COMMENT '账面数量',
    actual_count DECIMAL(10, 2) NOT NULL COMMENT '实际数量',
    count        DECIMAL(10, 2) NOT NULL COMMENT '盈亏数量',
    total_price  DECIMAL(10, 2) NOT NULL COMMENT '合计金额',
    remark       VARCHAR(500) COMMENT '备注',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    INDEX idx_check_id (check_id, deleted),
    INDEX idx_warehouse_product (warehouse_id, product_id, deleted)
) ENGINE = InnoDB COMMENT 'ERP库存盘点项';

-- ERP产品库存表
CREATE TABLE IF NOT EXISTS erp_stock (
    id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '编号',
    product_id   BIGINT      NOT NULL COMMENT '产品编号',
    warehouse_id BIGINT      NOT NULL COMMENT '仓库编号',
    count        DECIMAL(10, 2) NOT NULL COMMENT '库存数量',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE INDEX idx_warehouse_product (warehouse_id, product_id, deleted)
) ENGINE = InnoDB COMMENT 'ERP产品库存';

-- ERP其它入库单表
CREATE TABLE IF NOT EXISTS erp_stock_in (
    id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '入库编号',
    no           VARCHAR(64)  NOT NULL COMMENT '入库单号',
    supplier_id  BIGINT      NOT NULL COMMENT '供应商编号',
    in_time      DATETIME    NOT NULL COMMENT '入库时间',
    total_count  DECIMAL(10, 2) NOT NULL COMMENT '合计数量',
    total_price  DECIMAL(10, 2) NOT NULL COMMENT '合计金额',
    status       TINYINT     NOT NULL COMMENT '状态',
    remark       VARCHAR(500) COMMENT '备注',
    file_url     VARCHAR(500) COMMENT '附件URL',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE INDEX idx_no (no, deleted),
    INDEX idx_supplier (supplier_id, deleted),
    INDEX idx_status_time (status, in_time, deleted)
) ENGINE = InnoDB COMMENT 'ERP其它入库单';

-- ERP其它入库单项表
CREATE TABLE IF NOT EXISTS erp_stock_in_item (
    id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '入库项编号',
    in_id        BIGINT      NOT NULL COMMENT '入库编号',
    warehouse_id BIGINT      NOT NULL COMMENT '仓库编号',
    product_id   BIGINT      NOT NULL COMMENT '产品编号',
    product_unit_id BIGINT   NOT NULL COMMENT '产品单位编号',
    product_price DECIMAL(10, 2) NOT NULL COMMENT '产品单价',
    count        DECIMAL(10, 2) NOT NULL COMMENT '产品数量',
    total_price  DECIMAL(10, 2) NOT NULL COMMENT '合计金额',
    remark       VARCHAR(500) COMMENT '备注',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    deleted      BIT         NOT NULL DEFAULT FALSE COMMENT '是否删除',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    INDEX idx_in_id (in_id, deleted),
    INDEX idx_warehouse_product (warehouse_id, product_id, deleted)
) ENGINE = InnoDB COMMENT 'ERP其它入库单项';

-- 仓库表
CREATE TABLE IF NOT EXISTS erp_warehouse (
    id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '仓库编号',
    name         VARCHAR(100) NOT NULL COMMENT '仓库名称',
    address      VARCHAR(200)          DEFAULT NULL COMMENT '仓库地址',
    sort         BIGINT      NOT NULL DEFAULT 0 COMMENT '排序',
    remark       VARCHAR(500)          DEFAULT NULL COMMENT '备注',
    principal    VARCHAR(50)           DEFAULT NULL COMMENT '负责人',
    warehouse_price DECIMAL(10, 2)     DEFAULT 0 COMMENT '仓储费，单位：元',
    truckage_price DECIMAL(10, 2)      DEFAULT 0 COMMENT '搬运费，单位：元',
    status       TINYINT     NOT NULL DEFAULT 0 COMMENT '开启状态',
    default_status BOOLEAN   NOT NULL DEFAULT FALSE COMMENT '是否默认',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted      BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    PRIMARY KEY (id),
    INDEX idx_status_deleted (status, deleted) COMMENT '状态和删除标记联合索引'
) ENGINE = InnoDB COMMENT = 'ERP 仓库表';

-- 库存调拨单表
CREATE TABLE IF NOT EXISTS erp_stock_move (
    id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '调拨编号',
    no           VARCHAR(50)  NOT NULL COMMENT '调拨单号',
    move_time    DATETIME    NOT NULL COMMENT '调拨时间',
    total_count  DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '合计数量',
    total_price  DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '合计金额，单位：元',
    status       TINYINT     NOT NULL DEFAULT 0 COMMENT '状态',
    remark       VARCHAR(500)          DEFAULT NULL COMMENT '备注',
    file_url     VARCHAR(500)          DEFAULT NULL COMMENT '附件URL',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted      BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    PRIMARY KEY (id),
    UNIQUE INDEX unq_no (no, deleted) COMMENT '单号唯一索引',
    INDEX idx_move_time (move_time, deleted) COMMENT '调拨时间索引',
    INDEX idx_status (status, deleted) COMMENT '状态索引'
) ENGINE = InnoDB COMMENT = 'ERP 库存调拨单';

-- 库存调拨单项表
CREATE TABLE IF NOT EXISTS erp_stock_move_item (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '调拨项编号',
    move_id         BIGINT       NOT NULL COMMENT '调拨编号',
    from_warehouse_id BIGINT     NOT NULL COMMENT '调出仓库编号',
    to_warehouse_id  BIGINT      NOT NULL COMMENT '调入仓库编号',
    product_id      BIGINT       NOT NULL COMMENT '产品编号',
    product_unit_id BIGINT       NOT NULL COMMENT '产品单位编号',
    product_price   DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '产品单价',
    count           DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '产品数量',
    total_price     DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '合计金额，单位：元',
    remark          VARCHAR(500)          DEFAULT NULL COMMENT '备注',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    PRIMARY KEY (id),
    INDEX idx_move (move_id, deleted) COMMENT '调拨单索引',
    INDEX idx_warehouses (from_warehouse_id, to_warehouse_id, deleted) COMMENT '仓库索引',
    INDEX idx_product (product_id, deleted) COMMENT '产品索引'
) ENGINE = InnoDB COMMENT = 'ERP 库存调拨单项';

-- 其它出库单表
CREATE TABLE IF NOT EXISTS erp_stock_out (
    id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '出库编号',
    no           VARCHAR(50)  NOT NULL COMMENT '出库单号',
    customer_id  BIGINT               DEFAULT NULL COMMENT '客户编号',
    out_time     DATETIME    NOT NULL COMMENT '出库时间',
    total_count  DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '合计数量',
    total_price  DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '合计金额，单位：元',
    status       TINYINT     NOT NULL DEFAULT 0 COMMENT '状态',
    remark       VARCHAR(500)          DEFAULT NULL COMMENT '备注',
    file_url     VARCHAR(500)          DEFAULT NULL COMMENT '附件URL',
    creator      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater      VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted      BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    PRIMARY KEY (id),
    UNIQUE INDEX unq_no (no, deleted) COMMENT '单号唯一索引',
    INDEX idx_customer (customer_id, deleted) COMMENT '客户索引',
    INDEX idx_out_time (out_time, deleted) COMMENT '出库时间索引',
    INDEX idx_status (status, deleted) COMMENT '状态索引'
) ENGINE = InnoDB COMMENT = 'ERP 其它出库单';

-- 其它出库单项表
CREATE TABLE IF NOT EXISTS erp_stock_out_item (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '出库项编号',
    out_id          BIGINT       NOT NULL COMMENT '出库编号',
    warehouse_id    BIGINT       NOT NULL COMMENT '仓库编号',
    product_id      BIGINT       NOT NULL COMMENT '产品编号',
    product_unit_id BIGINT       NOT NULL COMMENT '产品单位编号',
    product_price   DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '产品单价',
    count           DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '产品数量',
    total_price     DECIMAL(10, 2) NOT NULL DEFAULT 0 COMMENT '合计金额，单位：元',
    remark          VARCHAR(500)          DEFAULT NULL COMMENT '备注',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    PRIMARY KEY (id),
    INDEX idx_out (out_id, deleted) COMMENT '出库单索引',
    INDEX idx_warehouse (warehouse_id, deleted) COMMENT '仓库索引',
    INDEX idx_product (product_id, deleted) COMMENT '产品索引'
) ENGINE = InnoDB COMMENT = 'ERP 其它出库单项';

-- 产品库存明细表
CREATE TABLE IF NOT EXISTS erp_stock_record (
    id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '编号',
    product_id      BIGINT       NOT NULL COMMENT '产品编号',
    warehouse_id    BIGINT       NOT NULL COMMENT '仓库编号',
    count           DECIMAL(10, 2) NOT NULL COMMENT '出入库数量',
    total_count     DECIMAL(10, 2) NOT NULL COMMENT '总库存量',
    biz_type        TINYINT     NOT NULL COMMENT '业务类型',
    biz_id          BIGINT       NOT NULL COMMENT '业务编号',
    biz_item_id     BIGINT       NOT NULL COMMENT '业务项编号',
    biz_no          VARCHAR(50)  NOT NULL COMMENT '业务单号',
    creator         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    create_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updater         VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '更新者',
    update_time     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    deleted         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '是否删除',
    PRIMARY KEY (id),
    INDEX idx_product_warehouse (product_id, warehouse_id, deleted) COMMENT '产品仓库索引',
    INDEX idx_biz (biz_type, biz_id, deleted) COMMENT '业务类型索引',
    INDEX idx_biz_no (biz_no, deleted) COMMENT '业务单号索引'
) ENGINE = InnoDB COMMENT = 'ERP 产品库存明细';