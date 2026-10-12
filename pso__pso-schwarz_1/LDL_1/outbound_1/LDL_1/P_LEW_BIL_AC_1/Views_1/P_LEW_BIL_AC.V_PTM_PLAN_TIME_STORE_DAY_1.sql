/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.v_ptm_plan_time_store_day_1
#----------------------------------------------------------------------------
# History:
#  1.0  2022-05-09    Marcin Malec          Created; 
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_ptm_plan_time_store_day_1 (client_id, store_id, dat_plantime, cal_week,
val_turnover, val_sales_pieces_pep, val_avg_price_pep, val_hours, val_performance, val_inventory, val_training, val_misc
, val_working, val_workingdays, val_holidays, release_fg, plantimeday_desc, dat_last_update, dat_creation, dat_dayend,
currency_iso_cd) AS SELECT client_id,
 store_id,
 dat_plantime,
 cal_week,
 val_turnover,
 val_sales_pieces_pep,
 val_avg_price_pep,
 val_hours,
 val_performance,
 val_inventory,
 val_training,
 val_misc,
 val_working,
 val_workingdays,
 val_holidays,
 release_fg,
 plantimeday_desc,
 dat_last_update,
 dat_creation,
 dat_dayend,
 currency_iso_cd
FROM ldl_p_lew_bil.v_ptm_plan_time_store_day_1;