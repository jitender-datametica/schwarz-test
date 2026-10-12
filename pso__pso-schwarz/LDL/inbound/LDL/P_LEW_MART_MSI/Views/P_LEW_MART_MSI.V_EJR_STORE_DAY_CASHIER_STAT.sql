CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_STORE_DAY_CASHIER_STAT
AS
   /*
   #DescStart#
   #$Revision: 15438 $, $LastChangedBy: ckumbhale $
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
   #DescEnd#
   */
   SELECT
   slti.client_id
   ,slti.loc_sid AS store_id
   ,Hash(slti.cashier_id) AS cashier_id -- hashed to encryp cashier for frontend
   ,slti.dat_formdate
   ,Max(CASE WHEN slti.recordtype_id = 201 THEN slti.val_stat_amount ELSE 0 END) AS val_shouldbe_turnover
   ,Max(CASE WHEN slti.recordtype_id = 202 THEN slti.stat_count      ELSE 0 END) AS cnt_customer
   ,Max(CASE WHEN slti.recordtype_id = 203 THEN slti.val_stat_amount ELSE 0 END) AS val_avg_purchase
   ,Max(CASE WHEN slti.recordtype_id = 204 THEN slti.stat_count      ELSE 0 END) AS cnt_pos_total
   ,Max(CASE WHEN slti.recordtype_id = 205 THEN slti.val_stat_amount ELSE 0 END) AS val_pos_per_minute
   ,Max(CASE WHEN slti.recordtype_id = 206 THEN slti.val_stat_amount ELSE 0 END) AS val_pos_per_purchase
   ,Max(CASE WHEN slti.recordtype_id = 301 THEN slti.stat_count      ELSE 0 END) AS val_servicetime
   FROM
   (SELECT
   sl.client_id AS client_id
   ,sl.loc_sid AS loc_sid
   ,sl.cashier_id AS cashier_id
   ,sl.dwh_cal_dt AS dat_formdate
   ,sl.statistic_id AS recordtype_id
   ,sl.statistic_cnt AS stat_count
   ,sl.statistic_val AS val_stat_amount
   FROM p_lew_core_ac.v_pos_ctrl_statistic AS sl
   WHERE sl.statistic_id BETWEEN 201 AND 206

   UNION ALL
   SELECT
   ti.client_id AS client_id
   ,ti.loc_sid AS loc_sid
   ,ti.cashier_id AS cashier_id
   ,ti.dwh_cal_dt AS dat_formdate
   ,ti.ti_cd::INTEGER AS recordtype_id
   ,ti.ti_cnt::INTEGER AS ti_count
   ,NULL::DECIMAL(18,5)
   FROM p_lew_core_ac.v_pos_ctrl_time_list AS ti
   WHERE ti.ti_cd = 301
 ) slti

 -- Consider only lines that are not yet anonymised.
 WHERE slti.cashier_id >= 0
   GROUP BY
   slti.client_id
  ,slti.loc_sid
  ,slti.cashier_id   -- see bdo_coex_view JIRA: LEAD-2495
  ,slti.dat_formdate
   ;