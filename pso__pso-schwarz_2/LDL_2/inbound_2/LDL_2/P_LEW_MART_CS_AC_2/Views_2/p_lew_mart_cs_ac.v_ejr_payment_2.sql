/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_ejr_payment_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_ejr_payment_2 (
  store_id
 ,client_id
 ,pos_terminal_id
 ,dat_formdate
 ,time_receipt_ejr
 ,orig_receipt_nr_ejr
 ,orig_receipt_serial_nr_ejr
 ,timezone_cd
 ,dat_dayend
 ,checker_id
 ,transactiontype_id
 ,tendertype_id
 ,cnt_payment_ejr
 ,val_retail_payment_ejr
 ,tendertype_cd_ejr
 ,val_foreign_curr_ejr
 ,val_diff_rounding_ejr
 ,currency_iso_cd
 ,timestamp_begin_ejr
 ,timestamp_end_ejr
 ,load_id
) AS
SELECT
  store_id
 ,client_id
 ,pos_terminal_id
 ,dat_formdate
 ,time_receipt_ejr
 ,orig_receipt_nr_ejr
 ,orig_receipt_serial_nr_ejr
 ,timezone_cd
 ,dat_dayend
 ,checker_id
 ,transactiontype_id
 ,tendertype_id
 ,cnt_payment_ejr
 ,val_retail_payment_ejr
 ,tendertype_cd_ejr
 ,val_foreign_curr_ejr
 ,val_diff_rounding_ejr
 ,currency_iso_cd
 ,timestamp_begin_ejr
 ,timestamp_end_ejr
 ,load_id
FROM p_lew_mart_cs.v_ejr_payment_2
;