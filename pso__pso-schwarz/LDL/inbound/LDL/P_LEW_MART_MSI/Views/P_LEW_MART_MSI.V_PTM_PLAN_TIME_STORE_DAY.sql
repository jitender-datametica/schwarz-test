/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ptm_plan_time_store_day
#----------------------------------------------------------------------------
# History:
#  1.0  Teradata      awandtke              Arbeitszeiterfassung
#  2.0  2022-05-09    Marcin Malec          Logic moved to new BIL view P_LEW_BIL.v_ptm_plan_time_store_day - val_turnover adjustment for France and BIL view usage in other objects
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_PTM_PLAN_TIME_STORE_DAY 
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
FROM P_LEW_BIL_AC.V_PTM_PLAN_TIME_STORE_DAY
;