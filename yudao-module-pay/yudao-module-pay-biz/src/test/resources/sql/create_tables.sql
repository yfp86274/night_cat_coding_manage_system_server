-- 支付應用表
create table IF not exists pay_app (
                                       id
                                       BIGINT
                                       not
                                       null
                                       AUTO_INCREMENT
                                       COMMENT
                                       '應用編號',
                                       app_key
                                       varchar (
                                       32
                                               ) not null COMMENT '應用標識', name varchar (
                                                                                               64
                                                                                           ) not null COMMENT '應用名', status TINYINT not null default 0 COMMENT '狀態(0:禁用 1:啟用)', remark varchar (
                                                                                                                                                                                                            256
                                                                                                                                                                                                        ) default null COMMENT '備註', order_notify_url varchar (
                                                                                                                                                                                                                                                                    1024
                                                                                                                                                                                                                                                                ) default null COMMENT '支付回調地址', refund_notify_url varchar (
                                                                                                                                                                                                                                                                                                                                     1024
                                                                                                                                                                                                                                                                                                                                 ) default null COMMENT '退款回調地址', transfer_notify_url varchar (
                                                                                                                                                                                                                                                                                                                                                                                                        1024
                                                                                                                                                                                                                                                                                                                                                                                                    ) default null COMMENT '轉賬回調地址', creator varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                               64
                                                                                                                                                                                                                                                                                                                                                                                                                                                           ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              64
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), unique key uk_app_key (
                                                                                                                                                            app_key,
                                                                                                                                                            tenant_id,
                                                                                                                                                            deleted
                                                                                                                                                        ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='支付應用信息';

-- 支付渠道表
create table IF not exists pay_channel (
                                           id
                                           BIGINT
                                           not
                                           null
                                           AUTO_INCREMENT
                                           COMMENT
                                           '渠道編號',
                                           code
                                           varchar (
                                           32
                                                   ) not null COMMENT '渠道編碼', status TINYINT not null default 0 COMMENT '狀態(0:禁用 1:啟用)', fee_rate decimal (
                                                                                                                                                                        10,
                                                                                                                                                                        6
                                                                                                                                                                    ) not null default 0 COMMENT '渠道費率', remark varchar (
                                                                                                                                                                                                                                256
                                                                                                                                                                                                                            ) default null COMMENT '備註',
    app_id BIGINT NOT NULL COMMENT '應用編號', config JSON not null COMMENT '渠道配置', creator varchar (
                                                                                                            64
                                                                                                        ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                           64
                                                                                                                                                       ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), key idx_app_id (
                                                                                                                                                     app_id,
                                                                                                                                                     deleted
                                                                                                                                                 ), key idx_code (
                                                                                                                                                                     code,
                                                                                                                                                                     status
                                                                                                                                                                 ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='支付渠道信息';

-- 支付訂單表
create table IF not exists pay_order (
                                         id
                                         BIGINT
                                         not
                                         null
                                         AUTO_INCREMENT
                                         COMMENT
                                         '訂單編號',
                                         app_id
                                         BIGINT
                                         not
                                         null
                                         COMMENT
                                         '應用編號',
                                         channel_id
                                         BIGINT
                                         not
                                         null
                                         COMMENT
                                         '渠道編號',
                                         channel_code
                                         varchar (
                                         32
                                                 ) not null COMMENT '渠道編碼', merchant_order_id varchar (
                                                                                                              64
                                                                                                          ) not null COMMENT '商戶訂單編號', subject varchar (
                                                                                                                                                                 256
                                                                                                                                                             ) not null COMMENT '交易標題', body varchar (
                                                                                                                                                                                                             512
                                                                                                                                                                                                         ) not null COMMENT '交易描述', notify_url varchar (
                                                                                                                                                                                                                                                               1024
                                                                                                                                                                                                                                                           ) default null COMMENT '回調地址', price BIGINT not null default 0 COMMENT '支付金額(分)', channel_fee_rate decimal (
                                                                                                                                                                                                                                                                                                                                                                                   10,
                                                                                                                                                                                                                                                                                                                                                                                   6
                                                                                                                                                                                                                                                                                                                                                                               ) default null COMMENT '渠道費率',
    channel_fee_price BIGINT DEFAULT NULL COMMENT '渠道手續費(分)', status TINYINT not null default 0 COMMENT '支付狀態', user_ip varchar (
                                                                                                                                              50
                                                                                                                                          ) not null COMMENT '用戶IP',
    expire_time DATETIME DEFAULT NULL COMMENT '過期時間',
    success_time DATETIME DEFAULT NULL COMMENT '成功時間', extension_id BIGINT default null COMMENT '拓展單號', no varchar (
                                                                                                                               64
                                                                                                                           ) default null COMMENT '外部訂單號', refund_price BIGINT not null default 0 COMMENT '退款金額(分)', channel_user_id varchar (
                                                                                                                                                                                                                                                           255
                                                                                                                                                                                                                                                       ) default null COMMENT '渠道用戶號', channel_order_no varchar (
                                                                                                                                                                                                                                                                                                                         64
                                                                                                                                                                                                                                                                                                                     ) default null COMMENT '渠道訂單號', creator varchar (
                                                                                                                                                                                                                                                                                                                                                                              64
                                                                                                                                                                                                                                                                                                                                                                          ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                             64
                                                                                                                                                                                                                                                                                                                                                                                                                         ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), unique key uk_merchant_order (
                                                                                                                                                                   merchant_order_id,
                                                                                                                                                                   tenant_id,
                                                                                                                                                                   deleted
                                                                                                                                                               ), key idx_app_channel (
                                                                                                                                                                                          app_id,
                                                                                                                                                                                          channel_id,
                                                                                                                                                                                          deleted
                                                                                                                                                                                      ), key idx_status_time (
                                                                                                                                                                                                                 status,
                                                                                                                                                                                                                 create_time
                                                                                                                                                                                                             ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='支付訂單';

-- 支付訂單擴展表
create table IF not exists pay_order_extension (
                                                   id
                                                   BIGINT
                                                   not
                                                   null
                                                   AUTO_INCREMENT
                                                   COMMENT
                                                   '訂單編號',
                                                   no
                                                   varchar (
                                                   64
                                                           ) not null COMMENT '外部訂單號',
    order_id BIGINT NOT NULL COMMENT '訂單編號', channel_id BIGINT not null COMMENT '渠道編號', channel_code varchar (
                                                                                                                         32
                                                                                                                     ) not null COMMENT '渠道編碼', user_ip varchar (
                                                                                                                                                                        50
                                                                                                                                                                    ) not null COMMENT '用戶IP',
    status TINYINT NOT NULL DEFAULT 0 COMMENT '支付狀態', channel_extras JSON default null COMMENT '渠道參數', channel_error_code varchar (
                                                                                                                                              128
                                                                                                                                          ) default null COMMENT '錯誤碼', channel_error_msg varchar (
                                                                                                                                                                                                         256
                                                                                                                                                                                                     ) default null COMMENT '錯誤描述', channel_notify_data TEXT default null COMMENT '通知數據', creator varchar (
                                                                                                                                                                                                                                                                                                                      64
                                                                                                                                                                                                                                                                                                                  ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                                                                                                                                                                                                                                     64
                                                                                                                                                                                                                                                                                                                                                                 ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), unique key uk_no (
                                                                                                                                                       no,
                                                                                                                                                       tenant_id,
                                                                                                                                                       deleted
                                                                                                                                                   ), key idx_order (
                                                                                                                                                                        order_id,
                                                                                                                                                                        deleted
                                                                                                                                                                    ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='支付訂單擴展';

-- 退款訂單表
create table IF not exists pay_refund (
                                          id
                                          BIGINT
                                          not
                                          null
                                          AUTO_INCREMENT
                                          COMMENT
                                          '退款編號',
                                          no
                                          varchar (
                                          64
                                                  ) not null COMMENT '退款單號',
    app_id BIGINT NOT NULL COMMENT '應用編號', channel_id BIGINT not null COMMENT '渠道編號', channel_code varchar (
                                                                                                                       32
                                                                                                                   ) not null COMMENT '渠道編碼', order_id BIGINT not null COMMENT '訂單編號', order_no varchar (
                                                                                                                                                                                                                    64
                                                                                                                                                                                                                ) not null COMMENT '訂單號', merchant_order_id varchar (
                                                                                                                                                                                                                                                                           64
                                                                                                                                                                                                                                                                       ) not null COMMENT '商戶訂單編號', merchant_refund_id varchar (
                                                                                                                                                                                                                                                                                                                                         64
                                                                                                                                                                                                                                                                                                                                     ) not null COMMENT '商戶退款編號', notify_url varchar (
                                                                                                                                                                                                                                                                                                                                                                                               1024
                                                                                                                                                                                                                                                                                                                                                                                           ) default null COMMENT '回調地址',
    status TINYINT NOT NULL DEFAULT 0 COMMENT '退款狀態',
    pay_price BIGINT NOT NULL DEFAULT 0 COMMENT '支付金額(分)', refund_price BIGINT not null default 0 COMMENT '退款金額(分)', reason varchar (
                                                                                                                                                  256
                                                                                                                                              ) not null COMMENT '退款原因', user_ip varchar (
                                                                                                                                                                                                 50
                                                                                                                                                                                             ) default null COMMENT '用戶IP', channel_order_no varchar (
                                                                                                                                                                                                                                                           64
                                                                                                                                                                                                                                                       ) default null COMMENT '渠道訂單號', channel_refund_no varchar (
                                                                                                                                                                                                                                                                                                                          64
                                                                                                                                                                                                                                                                                                                      ) default null COMMENT '渠道退款號', success_time DATETIME default null COMMENT '成功時間', channel_error_code varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                 128
                                                                                                                                                                                                                                                                                                                                                                                                                                             ) default null COMMENT '錯誤碼', channel_error_msg varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            256
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ) default null COMMENT '錯誤描述', channel_notify_data TEXT default null COMMENT '通知數據', creator varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         64
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        64
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), unique key uk_no (
                                                                                                                                                       no,
                                                                                                                                                       tenant_id,
                                                                                                                                                       deleted
                                                                                                                                                   ), unique key uk_merchant_refund (
                                                                                                                                                                                        merchant_refund_id,
                                                                                                                                                                                        tenant_id,
                                                                                                                                                                                        deleted
                                                                                                                                                                                    ), key idx_order (
                                                                                                                                                                                                         order_id,
                                                                                                                                                                                                         deleted
                                                                                                                                                                                                     ), key idx_status_time (
                                                                                                                                                                                                                                status,
                                                                                                                                                                                                                                create_time
                                                                                                                                                                                                                            ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='退款訂單';

-- 通知記錄表
create table IF not exists pay_notify_log (
                                              id
                                              BIGINT
                                              not
                                              null
                                              AUTO_INCREMENT
                                              COMMENT
                                              '日誌編號',
                                              task_id
                                              BIGINT
                                              not
                                              null
                                              COMMENT
                                              '任務編號',
                                              notify_times
                                              TINYINT
                                              not
                                              null
                                              default
                                              0
                                              COMMENT
                                              '通知次數',
                                              response
                                              varchar (
                                              2048
                                                      ) not null COMMENT '響應內容', status TINYINT not null default 0 COMMENT '通知狀態', creator varchar (
                                                                                                                                                               64
                                                                                                                                                           ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                                                                              64
                                                                                                                                                                                                          ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), key idx_task (
                                                                                                                                                   task_id,
                                                                                                                                                   deleted
                                                                                                                                               ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='通知記錄';

-- 錢包表
create table IF not exists pay_wallet (
                                          id
                                          BIGINT
                                          not
                                          null
                                          AUTO_INCREMENT
                                          COMMENT
                                          '錢包編號',
                                          user_id
                                          BIGINT
                                          not
                                          null
                                          COMMENT
                                          '用戶編號',
                                          user_type
                                          TINYINT
                                          not
                                          null
                                          default
                                          1
                                          COMMENT
                                          '用戶類型',
                                          balance
                                          BIGINT
                                          not
                                          null
                                          default
                                          0
                                          COMMENT
                                          '錢包餘額(分)',
                                          freeze_price
                                          BIGINT
                                          not
                                          null
                                          default
                                          0
                                          COMMENT
                                          '凍結金額(分)',
                                          total_expense
                                          BIGINT
                                          not
                                          null
                                          default
                                          0
                                          COMMENT
                                          '總支出(分)',
                                          total_recharge
                                          BIGINT
                                          not
                                          null
                                          default
                                          0
                                          COMMENT
                                          '總充值(分)',
                                          creator
                                          varchar (
                                          64
                                                  ) default '' COMMENT '創建者', updater varchar (
                                                                                                     64
                                                                                                 ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), unique key uk_user (
                                                                                                                                                         user_id,
                                                                                                                                                         user_type,
                                                                                                                                                         tenant_id,
                                                                                                                                                         deleted
                                                                                                                                                     ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='用戶錢包';

-- 錢包流水表
create table IF not exists pay_wallet_transaction (
                                                      id
                                                      BIGINT
                                                      not
                                                      null
                                                      AUTO_INCREMENT
                                                      COMMENT
                                                      '流水編號',
                                                      no
                                                      varchar (
                                                      64
                                                              ) not null COMMENT '流水號',
    wallet_id BIGINT NOT NULL COMMENT '錢包編號', biz_type TINYINT not null COMMENT '業務類型', biz_id varchar (
                                                                                                                   64
                                                                                                               ) not null COMMENT '業務編號', title varchar (
                                                                                                                                                                128
                                                                                                                                                            ) not null COMMENT '交易標題',
    price BIGINT NOT NULL DEFAULT 0 COMMENT '變動金額(分)', balance BIGINT not null default 0 COMMENT '變動後餘額(分)', creator varchar (
                                                                                                                                            64
                                                                                                                                        ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                                                           64
                                                                                                                                                                                       ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), unique key uk_no (
                                                                                                                                                       no,
                                                                                                                                                       tenant_id,
                                                                                                                                                       deleted
                                                                                                                                                   ), key idx_wallet (
                                                                                                                                                                         wallet_id,
                                                                                                                                                                         deleted
                                                                                                                                                                     ), key idx_biz (
                                                                                                                                                                                        biz_id,
                                                                                                                                                                                        biz_type,
                                                                                                                                                                                        deleted
                                                                                                                                                                                    ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='錢包流水';

-- 轉賬訂單表
create table IF not exists pay_transfer (
                                            id
                                            BIGINT
                                            not
                                            null
                                            AUTO_INCREMENT
                                            COMMENT
                                            '轉賬編號',
                                            no
                                            varchar (
                                            64
                                                    ) not null COMMENT '轉賬單號',
    app_id BIGINT NOT NULL COMMENT '應用編號', channel_id BIGINT not null COMMENT '渠道編號', channel_code varchar (
                                                                                                                       32
                                                                                                                   ) not null COMMENT '渠道編碼', merchant_transfer_id varchar (
                                                                                                                                                                                   64
                                                                                                                                                                               ) not null COMMENT '商戶轉賬單號',
    type TINYINT NOT NULL DEFAULT 0 COMMENT '轉賬類型', status TINYINT not null default 0 COMMENT '轉賬狀態', subject varchar (
                                                                                                                                  128
                                                                                                                              ) not null COMMENT '轉賬標題', price BIGINT not null default 0 COMMENT '轉賬金額(分)', user_name varchar (
                                                                                                                                                                                                                                           64
                                                                                                                                                                                                                                       ) not null COMMENT '收款人姓名', alipay_logon_id varchar (
                                                                                                                                                                                                                                                                                                    128
                                                                                                                                                                                                                                                                                                ) default null COMMENT '支付寶賬號', openid varchar (
                                                                                                                                                                                                                                                                                                                                                        128
                                                                                                                                                                                                                                                                                                                                                    ) default null COMMENT '微信openid', notify_url varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                1024
                                                                                                                                                                                                                                                                                                                                                                                                            ) default null COMMENT '回調地址', user_ip varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                                   50
                                                                                                                                                                                                                                                                                                                                                                                                                                                               ) default null COMMENT '用戶IP',
    success_time DATETIME DEFAULT NULL COMMENT '成功時間', channel_extras JSON default null COMMENT '渠道擴展參數', channel_transfer_no varchar (
                                                                                                                                                    64
                                                                                                                                                ) default null COMMENT '渠道轉賬單號', channel_error_code varchar (
                                                                                                                                                                                                                      128
                                                                                                                                                                                                                  ) default null COMMENT '渠道錯誤碼', channel_error_msg varchar (
                                                                                                                                                                                                                                                                                     256
                                                                                                                                                                                                                                                                                 ) default null COMMENT '渠道錯誤描述', channel_notify_data TEXT default null COMMENT '渠道通知數據', creator varchar (
                                                                                                                                                                                                                                                                                                                                                                                                          64
                                                                                                                                                                                                                                                                                                                                                                                                      ) default '' COMMENT '創建者', updater varchar (
                                                                                                                                                                                                                                                                                                                                                                                                                                                         64
                                                                                                                                                                                                                                                                                                                                                                                                                                                     ) default '' COMMENT '更新者',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
    deleted TINYINT NOT NULL DEFAULT 0 COMMENT '是否刪除', tenant_id BIGINT not null default 0 COMMENT '租戶編號', primary key (
                                                                                                                                   id
                                                                                                                               ), unique key uk_no (
                                                                                                                                                       no,
                                                                                                                                                       tenant_id,
                                                                                                                                                       deleted
                                                                                                                                                   ), unique key uk_merchant_transfer (
                                                                                                                                                                                          merchant_transfer_id,
                                                                                                                                                                                          tenant_id,
                                                                                                                                                                                          deleted
                                                                                                                                                                                      ), key idx_app_channel (
                                                                                                                                                                                                                 app_id,
                                                                                                                                                                                                                 channel_id,
                                                                                                                                                                                                                 deleted
                                                                                                                                                                                                             ), key idx_status_time (
                                                                                                                                                                                                                                        status,
                                                                                                                                                                                                                                        create_time
                                                                                                                                                                                                                                    ) ) ENGINE=InnoDB default CHARSET=utf8mb4 collate =utf8mb4_unicode_ci COMMENT='轉賬訂單';