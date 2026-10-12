
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STR_DAY_EJR_TXJ_WW_BO 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
          SELECT
             a.loc_sid AS store_id,
          a.client_id,
          a.dwh_cal_dt AS dat_formdate,
          CASE WHEN ez.eins = 1 THEN a.cy_month ELSE b.cy_month END AS cy_month,
          NULL AS orig_store_nr -- wird lt. AccCount nicht referenziert 
          ,
          CASE WHEN ez.eins = 1 THEN a.cnt_customer ELSE b.cnt_customer END AS cnt_customer,
          CASE WHEN ez.eins = 1 THEN a.cnt_customer_wawi ELSE b.cnt_customer_wawi END AS cnt_customer_wawi,
          CASE WHEN ez.eins = 1 THEN a.cnt_customer_pos_receipt ELSE b.cnt_customer_ejr_he END AS cnt_customer_ejr_he,
          CASE WHEN ez.eins = 1 THEN a.cnt_customer_pos_statistic ELSE b.cnt_customer_ejr_st END AS cnt_customer_ejr_st,
          CASE WHEN ez.eins = 1 THEN a.cnt_customer_txj ELSE b.cnt_customer_txj END AS cnt_customer_txj,
          CASE WHEN ez.eins = 1 THEN a.sales_gross_val ELSE COALESCE(b.val_retail,0) END AS val_retail,
          CASE WHEN ez.eins = 1 THEN a.sales_net_val ELSE COALESCE(b.val_retail_net,0) END AS val_retail_net,
          CASE WHEN ez.eins = 1 THEN a.sales_gross_val_wawi ELSE b.val_rtl_wawi END AS val_rtl_wawi,
          CASE WHEN ez.eins = 1 THEN a.sales_net_val_wawi ELSE b.val_rtl_net_wawi END AS val_rtl_net_wawi,
          CASE WHEN ez.eins = 1 THEN a.sales_gross_val_pos ELSE b.val_rtl_ejr END AS val_rtl_ejr,
          CASE WHEN ez.eins = 1 THEN a.sales_net_val_pos ELSE b.val_rtl_net_ejr END AS val_rtl_net_ejr,
          CASE WHEN ez.eins = 1 THEN a.sales_gross_val_txj_store ELSE b.val_rtl_txj_str END AS val_rtl_txj_str,
          CASE WHEN ez.eins = 1 THEN a.sales_net_val_txj_store ELSE b.val_rtl_net_txj_str END AS val_rtl_net_txj_str,
          CASE WHEN ez.eins = 1 THEN a.sales_gross_val_txj_item ELSE b.val_rtl_txj_item END AS val_rtl_txj_item,
          CASE WHEN ez.eins = 1 THEN a.sales_net_val_txj_item ELSE b.val_rtl_net_txj_item END AS val_rtl_net_txj_item,
          CASE WHEN ez.eins = 1 THEN a.vat_val_pos ELSE b.val_vatamount_ejr END AS val_vatamount_ejr,
          CASE WHEN ez.eins = 1 THEN a.vat_val_txj ELSE b.val_vatamount_txj END AS val_vatamount_txj,
          CASE WHEN ez.eins = 1 THEN a.vat_val_txj_net ELSE b.val_vatamount_net_txj END AS val_vatamount_net_txj
          FROM p_lew_bil_ac.v_agg_pos_txj_wawi_store_day a
          CROSS JOIN
          (
            SELECT
              eins
            FROM  (SELECT 1 AS eins) x
            UNION ALL
            SELECT
              eins
            FROM (SELECT 2 AS eins) y
          )ez
          LEFT JOIN p_lew_bil_ac.v_agg_sales_store_day b
          ON a.client_id = b.client_id
          AND a.loc_sid = b.loc_sid_store
          AND a.dwh_cal_dt = b.dat_formdate
          AND ((b.client_id IN(1,33) ) OR (b.client_id = 21 AND a.dwh_cal_dt >= '2016-09-05')) -- Replicate p_process_view.v_mast_migrt_core_wh 
          AND ez.eins = 2
  WHERE ez.eins = 1 OR b.client_id IS NOT NULL
;
