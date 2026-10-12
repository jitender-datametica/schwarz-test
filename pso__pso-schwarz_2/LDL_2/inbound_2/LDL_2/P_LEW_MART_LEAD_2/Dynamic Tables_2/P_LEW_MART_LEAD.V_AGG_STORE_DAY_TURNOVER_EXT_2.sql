CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_STORE_DAY_TURNOVER_EXT_2
( 
   client_id              COMMENT 'Landeskennzeichen'
 , orig_store_nr          COMMENT 'Original Filiall-Nr.'
 , dat_formdate           COMMENT 'Aenderungsdatum'
 , currency_iso_cd        COMMENT 'Waehrungsbezeichnung, wird vom Vorsystem Wawi geliefert' 
 , store_id               COMMENT 'Filial-Nr.'
 , cy_month               COMMENT 'Monat_2 des Geschaeftsjahres im Format "JJJJMM"'
 , cnt_customer           COMMENT 'Anzahl Kunden'
 , cnt_customer_extrapol  COMMENT 'Customer Count extrapolation'
 , val_rtl                COMMENT 'Retail value'
 , val_rtl_net 
 , val_rtl_extrapol 
 , val_rtl_net_extrapol 
 , val_rtl_kpges 
 , val_rtl_net_kpges
 , val_rtl_wawi           COMMENT '((Nettowert der Fakturaposition in Belegwaehrung; SAP-BW: t_bw_2lis_13_vditm.netwr) plus (Steuerbetrag in Belegwaehrung; SAP-BW : t_bw_2lis_13_vditm.mwsbp)) * (-1) oder wenn cond_type_cd = ZPRA AND src_mtart in (ZVM,ZKM) AND sales_type_cd = ZFPU dann 0'
 , val_rtl_net_wawi       COMMENT 'Nettowert der Fakturaposition in Belegwaehrung; SAP-BW: t_bw_2lis_13_vditm.netwr * (-1) oder wenn cond_type_cd = ZPRA AND src_mtart in (ZVM,ZKM) AND sales_type_cd = ZFPU dann 0'
 , val_rtl_txj
 , val_rtl_net_txj 
 , val_rtl_ejr 
 , val_rtl_net_ejr 
 , open_store_fg          COMMENT 'Open store flag'
 , bereinigt_fg           COMMENT 'Bereinigt flag'
 , bereinigt_VJW_fg       COMMENT 'Bereinigt VJ same week day flag'
 , bereinigt_VJM_fg       COMMENT 'Bereinigt VJ same calendar_2 day flag'
 , bereinigt_VVJ_fg       COMMENT 'Bereinigt VVJ flag'
 , bereinigt_VVJW_fg      COMMENT 'Bereinigt VVJ same week day flag'
 , bereinigt_VVJM_fg      COMMENT 'Bereinigt VVJ same calendar_2 day flag'
 , bereinigt_VVVJ_fg      COMMENT 'Bereinigt VVVJ flag'
 , bereinigt_VVVJW_fg     COMMENT 'Bereinigt VVVJ same week day flag'
 , bereinigt_VVVJM_fg     COMMENT 'Bereinigt VVVJ same calendar_2 day flag'
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_2 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD
AS
SELECT
  src.client_id
, src.src_orig_store_nr      AS orig_store_nr
, src.dat_formdate
, src.currency_iso_cd
, src.loc_sid_store          AS store_id
, src.cy_month
, src.cnt_customer
, src.cnt_customer_extrapol AS cnt_customer_extrapol
, src.val_rtl
, src.val_rtl_net
, src.val_rtl_extrapol
, src.val_rtl_net_extrapol
, src.val_rtl_kpges
, src.val_rtl_net_kpges
, src.val_rtl_wawi
, src.val_rtl_net_wawi
, src.val_rtl_txj
, src.val_rtl_net_txj
, src.val_rtl_ejr
, src.val_rtl_net_ejr
, CASE WHEN
           (src.dat_formdate BETWEEN store.dat_opening_ovis AND store.dat_closing_ovis - 1)
           OR (src.dat_formdate >= store.dat_opening_ovis AND store.dat_closing_ovis IS NULL)
       THEN 1
       ELSE 0
  END AS open_store_fg
, CASE WHEN  
           ((src.dat_formdate >= store.dat_calc_start_py AND store.move_fg = 1) 
           OR src.dat_formdate BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
           OR (src.dat_formdate >= store.dat_calc_start_py AND store.dat_calc_end_py IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_fg
, CASE WHEN 
           ((calwkber.cal_dt >=  store.dat_calc_start_py AND store.move_fg = 1)
           OR calwkber.cal_dt BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
           OR (calwkber.cal_dt >=  store.dat_calc_start_py
           AND store.dat_calc_end_py IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VJW_fg
, CASE WHEN  
           ((calmthber.cal_dt >= store.dat_calc_start_py AND store.move_fg = 1) 
           OR calmthber.cal_dt BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
           OR (calmthber.cal_dt >= store.dat_calc_start_py AND store.dat_calc_end_py IS NULL) 
       THEN 1
       ELSE 0
  END AS bereinigt_VJM_fg

  , CASE WHEN  
           ((src.dat_formdate >= store.dat_calc_start_ppy AND store.move_fg = 1) 
           OR src.dat_formdate BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
           OR (src.dat_formdate >= store.dat_calc_start_ppy AND store.dat_calc_end_ppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVJ_fg
, CASE WHEN 
           ((calwkber_VVJ.cal_dt >=  store.dat_calc_start_ppy AND store.move_fg = 1)
           OR calwkber_VVJ.cal_dt BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
           OR (calwkber_VVJ.cal_dt >=  store.dat_calc_start_ppy
           AND store.dat_calc_end_ppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVJW_fg
, CASE WHEN  
           ((calmthber_VVJ.cal_dt >= store.dat_calc_start_ppy AND store.move_fg = 1) 
           OR calmthber_VVJ.cal_dt BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
           OR (calmthber_VVJ.cal_dt >= store.dat_calc_start_ppy AND store.dat_calc_end_ppy IS NULL) 
       THEN 1
       ELSE 0
  END AS bereinigt_VVJM_fg

  , CASE WHEN  
           ((src.dat_formdate >= store.dat_calc_start_pppy AND store.move_fg = 1) 
           OR src.dat_formdate BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
           OR (src.dat_formdate >= store.dat_calc_start_pppy AND store.dat_calc_end_pppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVVJ_fg
, CASE WHEN 
           ((calwkber_VVVJ.cal_dt >=  store.dat_calc_start_pppy AND store.move_fg = 1)
           OR calwkber_VVVJ.cal_dt BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
           OR (calwkber_VVVJ.cal_dt >=  store.dat_calc_start_pppy
           AND store.dat_calc_end_pppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVVJW_fg
, CASE WHEN  
           ((calmthber_VVVJ.cal_dt >= store.dat_calc_start_pppy AND store.move_fg = 1) 
           OR calmthber_VVVJ.cal_dt BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
           OR (calmthber_VVVJ.cal_dt >= store.dat_calc_start_pppy AND store.dat_calc_end_pppy IS NULL) 
       THEN 1
       ELSE 0
  END AS bereinigt_VVVJM_fg
FROM P_LEW_BIL_AC.v_agg_store_day_turnover_ext_2 AS src

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_2 AS calwkber
ON calwkber.prev_cy_dat_calendar_swd_ber = src.dat_formdate

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_2 AS calmthber
ON calmthber.incl_cal_dt = src.dat_formdate
AND calmthber.bus_year_diff = 1

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_2 AS calwkber_VVJ
ON calwkber_VVJ.prev_prev_cy_dat_calendar_swd_ber = src.dat_formdate

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_2 AS calmthber_VVJ
ON calmthber_VVJ.incl_cal_dt = src.dat_formdate
AND calmthber_VVJ.bus_year_diff = 2

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_2 AS calwkber_VVVJ
ON calwkber_VVVJ.prev_prev_prev_cy_dat_calendar_swd_ber = src.dat_formdate

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_2 AS calmthber_VVVJ
ON calmthber_VVVJ.incl_cal_dt = src.dat_formdate
AND calmthber_VVVJ.bus_year_diff = 3

LEFT OUTER JOIN p_lew_mart_msi_ac.v_org_store_pre_2 AS store
ON  src.client_id = store.client_id
AND src.loc_sid_store = store.store_id
;
