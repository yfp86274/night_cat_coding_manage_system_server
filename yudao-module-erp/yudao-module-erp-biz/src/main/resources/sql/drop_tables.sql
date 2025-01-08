-- 基礎資料相關表
DROP TABLE IF EXISTS erp_account; -- 結算賬戶表
DROP TABLE IF EXISTS erp_product_unit; -- 產品單位表
DROP TABLE IF EXISTS erp_product_category; -- 產品分類表
DROP TABLE IF EXISTS erp_product; -- 產品表

-- 財務相關表
DROP TABLE IF EXISTS erp_finance_receipt; -- 收款單表
DROP TABLE IF EXISTS erp_finance_receipt_item; -- 收款項表
DROP TABLE IF EXISTS erp_finance_payment; -- 付款單表
DROP TABLE IF EXISTS erp_finance_payment_item; -- 付款項表

-- 客戶供應商相關表
DROP TABLE IF EXISTS erp_supplier; -- 供應商表
DROP TABLE IF EXISTS erp_customer; -- 客戶表

-- 採購相關表
DROP TABLE IF EXISTS erp_purchase_order; -- 採購訂單表
DROP TABLE IF EXISTS erp_purchase_order_items; -- 採購訂單項表
DROP TABLE IF EXISTS erp_purchase_in; -- 採購入庫表
DROP TABLE IF EXISTS erp_purchase_in_items; -- 採購入庫項表
DROP TABLE IF EXISTS erp_purchase_return; -- 採購退貨表
DROP TABLE IF EXISTS erp_purchase_return_items; -- 採購退貨項表

-- 銷售相關表
DROP TABLE IF EXISTS erp_sale_order; -- 銷售訂單表
DROP TABLE IF EXISTS erp_sale_order_items; -- 銷售訂單項表
DROP TABLE IF EXISTS erp_sale_out; -- 銷售出庫表
DROP TABLE IF EXISTS erp_sale_out_items; -- 銷售出庫項表
DROP TABLE IF EXISTS erp_sale_return; -- 銷售退貨表
DROP TABLE IF EXISTS erp_sale_return_items; -- 銷售退貨項表

-- 庫存相關表
DROP TABLE IF EXISTS erp_stock_check; -- 庫存盤點表
DROP TABLE IF EXISTS erp_stock_check_item; -- 庫存盤點項表
DROP TABLE IF EXISTS erp_stock; -- 產品庫存表
DROP TABLE IF EXISTS erp_stock_in; -- 其它入庫單表
DROP TABLE IF EXISTS erp_stock_in_item; -- 其它入庫單項表
DROP TABLE IF EXISTS erp_warehouse; -- 倉庫表
DROP TABLE IF EXISTS erp_stock_move; -- 庫存調撥單表
DROP TABLE IF EXISTS erp_stock_move_item; -- 庫存調撥單項表
DROP TABLE IF EXISTS erp_stock_out; -- 其它出庫單表
DROP TABLE IF EXISTS erp_stock_out_item; -- 其它出庫單項表
DROP TABLE IF EXISTS erp_stock_record; -- 產品庫存明細表