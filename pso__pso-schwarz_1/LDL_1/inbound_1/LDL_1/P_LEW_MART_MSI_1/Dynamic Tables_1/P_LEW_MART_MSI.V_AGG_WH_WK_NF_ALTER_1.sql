
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_WH_WK_NF_ALTER_1
(
cy_week_partial_week_id
, cy_week_partial_week_id2
, client_id
, wh_id
, currency_iso_cd
, byr
, month_id
, week_id
, cur_stock_wh
, pwd_stock_wh
, nf_alter_wh_wk_asis
, nf_alter_wh_wk_pyd
, nf_alter_wh_mth_asis
, nf_alter_wh_mth_pyd
, nf_alter_wh_py_asis
, nf_alter_wh_py_pyd
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   agg.cy_week_partial_week_id,
   agg.cy_week_partial_week_id2,
   agg.client_id,
   wh.src_wh_id AS wh_id,
   agg.currency_iso_cd,
   agg.byr,
   agg.month_id,
   agg.week_id,
   agg.cur_stock_wh,
   agg.pwd_stock_wh,
   agg.nf_alter_wh_wk_asis,
   agg.nf_alter_wh_wk_pyd,
   agg.nf_alter_wh_mth_asis,
   agg.nf_alter_wh_mth_pyd,
   agg.nf_alter_wh_py_asis,
   agg.nf_alter_wh_py_pyd
  FROM p_lew_mart_msi.t_agg_wh_wk_nf_alter_1 AS agg
   -- WH Auflösung
   JOIN
   p_lew_bil_ac.v_warehouse_1 AS wh
   ON agg.client_id=wh.client_id
   AND agg.wh_loc_sid=wh.loc_sid_wh
   AND wh.dwh_actual_fg = 1
;
