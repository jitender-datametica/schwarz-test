/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_RECEIPT_DISTINCT_PAYMENT_1
#
# Purpose: There can be multiple payment type records for receipt, both of same and different types, including cashback, change, paying partially by card and cash, or registering several bills separately.
#          Initially MSTR reports in CO were using p_lew_mart_msi_ac.v_ejr_payment_1, which holds all these records separately, so when joining with receipt, this produces a multiplied receipt value.
#          This view fetches only distinct payment types, with a proportion of payment for specific payment type to whole payment - in case of multiple payment types for one receipt, i.e. paying partially by card and cash,
#          so that a proper value can be calculated for every payment type.
#          It is on receiptline level, MSTR reposrts need to use receiptline, so we have to have it here also to avoid multiplication.
#
#----------------------------------------------------------------------------
# History:
#  1.0  15-05-2024    Marcin Malec         Initial version, AP0162953, User Story 508622: [BE] - BBT-5833 | Zahlungsarten Bon-Level
#  1.1  24-10-2024    Marcin Malec         Add column curr_tot_id; INC9601992
#  1.2  28-01-2025    Marcin Malec         Adding column val_retail_ejr_adjusted - Sales_1 gross value from receiptline adjusted by proportion of payment for specific payment type to whole payment
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_receipt_distinct_payment_1 (store_id, client_id, pos_terminal_id,
dat_formdate, time_receipt_ejr, orig_receipt_nr_ejr, orig_receipt_serial_nr_ejr, orig_receipt_id_ejr_sales, timezone_cd
, dat_dayend, checker_id, rln_transactiontype_id, paym_transactiontype_id, tendertype_cd_ejr, curr_tot_id,
currency_iso_cd, val_retail_payment_ejr OPTIONS(description='Payment value for specific payment type'),
val_retail_payment_sum OPTIONS(description='Payment value for whole receipt'), val_retail_payment_perc_of_sum
OPTIONS(description='Proportion of payment for specific payment type to whole payment'), val_retail_net_ejr
OPTIONS(description='Sales_1 value from receiptline'), val_retail_net_ejr_adjusted
OPTIONS(description='Sales_1 value from receiptline adjusted by proportion of payment for specific payment type to whole payment'),
val_retail_ejr_adjusted
OPTIONS(description='Sales_1 gross value from receiptline adjusted by proportion of payment for specific payment type to whole payment'))
OPTIONS(DESCRIPTION = `DISTINCT PAYMENT TYPES FOR RECEIPT ON LINE LEVEL, WITH A PROPORTION OF PAYMENT FOR SPECIFIC PAYMENT TYPE TO WHOLE PAYMENT`)
AS SELECT pay.store_id,
 pay.client_id,
 pay.pos_terminal_id,
 pay.dat_formdate,
 pay.time_receipt_ejr,
 pay.orig_receipt_nr_ejr,
 RL.orig_receipt_serial_nr_ejr,
 RL.orig_receipt_id_ejr_sales,
 pay.timezone_cd,
 pay.dat_dayend,
 pay.checker_id,
 RL.transactiontype_id AS rln_transactiontype_id,
 pay.transactiontype_id AS paym_transactiontype_id,
 pay.tendertype_cd_ejr,
 CURR.curr_tot_id,
 RL.currency_iso_cd,
 pay.val_retail_payment_ejr,
 pay.val_retail_payment_sum,
 pay.val_retail_payment_perc_of_sum,
 RL.val_retail_net_ejr,
  RL.val_retail_net_ejr * pay.val_retail_payment_perc_of_sum AS val_retail_net_ejr_adjusted,
  RL.val_retail_ejr * pay.val_retail_payment_perc_of_sum AS val_retail_ejr_adjusted
FROM (SELECT store_id,
   client_id,
   pos_terminal_id,
   dat_formdate,
   time_receipt_ejr,
   orig_receipt_nr_ejr,
   timezone_cd,
   dat_dayend,
   checker_id,
   transactiontype_id,
   tendertype_cd_ejr,
   SUM(val_retail_payment_ejr) AS val_retail_payment_ejr,
    CASE
    WHEN MAX(val_retail_payment_sum) = 0
    THEN 1
    ELSE MAX(val_retail_payment_sum)
    END AS val_retail_payment_sum,
    CASE
    WHEN CAST(tendertype_cd_ejr AS FLOAT64) = 12 AND SUM(val_retail_payment_ejr) > MAX(val_retail_payment_sum)
    THEN 1
    ELSE SUM(val_retail_payment_ejr) / CASE
      WHEN MAX(val_retail_payment_sum) = 0
      THEN 1
      ELSE MAX(val_retail_payment_sum)
      END
    END AS val_retail_payment_perc_of_sum
  FROM (SELECT loc_sid AS store_id,
     client_id,
     register_id AS pos_terminal_id,
     dwh_cal_dt AS dat_formdate,
     CAST(TRIM(SUBSTR(CAST(CAST(receipt_tmsp AS TIME) AS STRING), 1, 8)) AS TIME) AS time_receipt_ejr,
     receipt_id AS orig_receipt_nr_ejr,
     timezone_id AS timezone_cd,
     receipt_dt AS dat_dayend,
     cashier_id AS checker_id,
     transaction_type_cd AS transactiontype_id,
     tendertype_ejr_cd AS tendertype_cd_ejr,
     payment_fg AS cnt_payment_ejr,
     payment_val AS val_retail_payment_ejr,
     SUM(payment_val) OVER (PARTITION BY CAST(client_id AS STRING), dwh_cal_dt, CAST(loc_sid AS STRING), CAST(register_id AS STRING)
        , CAST(receipt_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
     val_retail_payment_sum
    FROM ldl_p_lew_core_ac.v_pos_ctrl_payment_1
    WHERE turnover_relevant_fg = 1) AS t0
  GROUP BY store_id,
   client_id,
   pos_terminal_id,
   dat_formdate,
   time_receipt_ejr,
   orig_receipt_nr_ejr,
   timezone_cd,
   dat_dayend,
   checker_id,
   transactiontype_id,
   tendertype_cd_ejr
  HAVING val_retail_payment_ejr > 0) AS pay
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ejr_receiptline_1 AS RL ON pay.client_id = RL.client_id AND pay.dat_formdate = RL.dat_formdate
       AND pay.store_id = RL.store_id AND pay.pos_terminal_id = RL.pos_terminal_id AND pay.orig_receipt_nr_ejr = RL.orig_receipt_nr_ejr
   
 INNER JOIN ldl_p_lew_mart_lead_ac.v_ref_currency_1 AS CURR ON pay.client_id = CURR.client_id AND RL.currency_iso_cd =
   CURR.currency_iso_cd;

