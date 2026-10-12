/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.v_ptm_plan_time_store_day_1
#----------------------------------------------------------------------------
# History:
#  1.0  Teradata      hwieber               Access Layer
#  2.0  2022-05-09    Marcin Malec          columns added
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_PTM_PLAN_TIME_STORE_DAY_1
(
  client_id
, store_id
, dat_plantime
, cal_week
, val_turnover
, val_sales_pieces_pep
, val_avg_price_pep
, val_hours
, val_performance
, val_inventory
, val_training
, val_misc
, val_working
, val_workingdays
, val_holidays
, release_fg
, plantimeday_desc
, dat_last_update
, dat_creation
, dat_dayend
, currency_iso_cd
 )
AS
SELECT
  client_id
, store_id
, dat_plantime
, cal_week
, val_turnover
, val_sales_pieces_pep
, val_avg_price_pep
, val_hours
, val_performance
, val_inventory
, val_training
, val_misc
, val_working
, val_workingdays
, val_holidays
, release_fg
, plantimeday_desc
, dat_last_update
, dat_creation
, dat_dayend
, currency_iso_cd
FROM p_lew_mart_msi.v_ptm_plan_time_store_day_1
;