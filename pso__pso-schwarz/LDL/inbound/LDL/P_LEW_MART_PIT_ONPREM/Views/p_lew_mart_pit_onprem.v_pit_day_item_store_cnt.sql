CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_DAY_ITEM_STORE_CNT

AS
   SELECT
   client_id
,   dwh_cal_dt
,   cy_month
,   F_Client_Store_Cnt
,   F_Client_Store_Cnt_Month
,   DIV0(F_Client_Store_Cnt,F_Client_Store_Cnt_Month)    AS F_diff_Store_Cnt_to_Month
-- ##Check   1 -  ( F_Client_Store_Cnt*1.00 )  / CASE WHEN COALESCE ( F_Client_Store_Cnt_Month*1.00, TO_NUMBER(  NULL, 38, 10)) = 0 THEN NULL ELSE COALESCE ( F_Client_Store_Cnt_Month*1.00, TO_NUMBER(  NULL, 38, 10)) END 
-- NULL AS F_diff_Store_Cnt_to_Month
   FROM p_lew_mart_pit_onprem.t_pit_day_item_store_cnt;