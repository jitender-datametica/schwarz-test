/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_RECEIPT_DISTINCT_PAYMENT_2
#
# Purpose: There can be multiple payment type records for receipt, both of same and different types, including cashback, change, paying partially by card and cash, or registering several bills separately.
#          Initially MSTR reports in CO were using p_lew_mart_msi_ac.v_ejr_payment_2, which holds all these records separately, so when joining with receipt, this produces a multiplied receipt value.
#          This view fetches only distinct payment types, with a proportion of payment for specific payment type to whole payment - in case of multiple payment types for one receipt, i.e. paying partially by card and cash,
#          so that a proper value can be calculated for every payment type.
#          It is on receiptline level, MSTR reposrts need to use receiptline, so we have to have it here also to avoid multiplication.
#
#----------------------------------------------------------------------------
# History:
#  1.0  15-05-2024    Marcin Malec         Initial version, AP0162953, User Story 508622: [BE] - BBT-5833 | Zahlungsarten Bon-Level
#  1.1  24-10-2024    Marcin Malec         Add column curr_tot_id; INC9601992
#  1.2  28-01-2025    Marcin Malec         Adding column val_retail_ejr_adjusted - Sales_2 gross value from receiptline adjusted by proportion of payment for specific payment type to whole payment
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_RECEIPT_DISTINCT_PAYMENT_2 COMMENT = 'Distinct payment types for receipt on line level, with a proportion of payment for specific payment type to whole payment'
(
  store_id
, client_id
, pos_terminal_id
, dat_formdate
, time_receipt_ejr
, orig_receipt_nr_ejr
, orig_receipt_serial_nr_ejr
, orig_receipt_id_ejr_sales
, timezone_cd
, dat_dayend
, checker_id
, rln_transactiontype_id
, paym_transactiontype_id
, tendertype_cd_ejr
, curr_tot_id
, currency_iso_cd
, val_retail_payment_ejr COMMENT 'Payment value for specific payment type'
, val_retail_payment_sum COMMENT 'Payment value for whole receipt'
, val_retail_payment_perc_of_sum COMMENT 'Proportion of payment for specific payment type to whole payment'
, val_retail_net_ejr COMMENT 'Sales_2 value from receiptline'
, val_retail_net_ejr_adjusted COMMENT 'Sales_2 value from receiptline adjusted by proportion of payment for specific payment type to whole payment'
, val_retail_ejr_adjusted COMMENT 'Sales_2 gross value from receiptline adjusted by proportion of payment for specific payment type to whole payment'
)
AS

SELECT pay.store_id
     , pay.client_id
     , pay.pos_terminal_id
     , pay.dat_formdate
     , pay.time_receipt_ejr
     , pay.orig_receipt_nr_ejr
     , rl.orig_receipt_serial_nr_ejr
     , rl.orig_receipt_id_ejr_sales
     , pay.timezone_cd
     , pay.dat_dayend
     , pay.checker_id
     , rl.transactiontype_id AS rln_transactiontype_id
     , pay.transactiontype_id AS paym_transactiontype_id
     , pay.tendertype_cd_ejr
     , curr.curr_tot_id
     , rl.currency_iso_cd
     , pay.val_retail_payment_ejr
     , pay.val_retail_payment_sum
     , pay.val_retail_payment_perc_of_sum
     , rl.val_retail_net_ejr
     , rl.val_retail_net_ejr * pay.val_retail_payment_perc_of_sum AS val_retail_net_ejr_adjusted
     , rl.val_retail_ejr * pay.val_retail_payment_perc_of_sum AS val_retail_ejr_adjusted
FROM
(
    SELECT store_id
         , client_id
         , pos_terminal_id
         , dat_formdate
         , time_receipt_ejr
         , orig_receipt_nr_ejr
         , timezone_cd
         , dat_dayend
         , checker_id
         , transactiontype_id
         , tendertype_cd_ejr
         , SUM(val_retail_payment_ejr) AS val_retail_payment_ejr
         , CASE WHEN MAX(val_retail_payment_sum) = 0 THEN 1 ELSE MAX(val_retail_payment_sum) END AS val_retail_payment_sum
         , CASE WHEN tendertype_cd_ejr = 12 AND SUM(val_retail_payment_ejr) > MAX(val_retail_payment_sum) THEN 1 /* cashback, count only shopping value, not cash withdrawal amount */
                ELSE SUM(val_retail_payment_ejr) / CASE WHEN MAX(val_retail_payment_sum) = 0 THEN 1 ELSE MAX(val_retail_payment_sum) END END AS val_retail_payment_perc_of_sum
    FROM (SELECT loc_sid                                                                                    AS store_id
               , client_id                                                                                  AS client_id
               , register_id                                                                                AS pos_terminal_id
               , dwh_cal_dt                                                                                 AS dat_formdate
               , CAST(SUBSTRING(CAST(CAST(receipt_tmsp AS TIME(6)) AS VARCHAR(30)), 1, 8) AS TIME(0))       AS time_receipt_ejr
               , receipt_id                                                                                 AS orig_receipt_nr_ejr
               , timezone_id                                                                                AS timezone_cd
               , receipt_dt                                                                                 AS dat_dayend
               , cashier_id                                                                                 AS checker_id
               , transaction_type_cd                                                                        AS transactiontype_id
               , payment_fg                                                                                 AS cnt_payment_ejr
               , tendertype_ejr_cd                                                                          AS tendertype_cd_ejr
               , payment_val                                                                                AS val_retail_payment_ejr
               , SUM(payment_val) OVER (PARTITION BY client_id,dwh_cal_dt,loc_sid,register_id,receipt_id)   AS val_retail_payment_sum
          FROM P_LEW_CORE_AC.v_pos_ctrl_payment_2    
          WHERE turnover_relevant_fg = 1)
    GROUP BY store_id
           , client_id
           , pos_terminal_id
           , dat_formdate
           , time_receipt_ejr
           , orig_receipt_nr_ejr
           , timezone_cd
           , dat_dayend
           , checker_id
           , transactiontype_id
           , tendertype_cd_ejr
    HAVING MAX(cnt_payment_ejr) > 0 /* only payment types, which have at least one relevant record */
) AS pay

INNER JOIN P_LEW_MART_MSI_AC.v_ejr_receiptline_2 AS rl
ON pay.client_id = rl.client_id
AND pay.dat_formdate = rl.dat_formdate
AND pay.store_id = rl.store_id
AND pay.pos_terminal_id = rl.pos_terminal_id
AND pay.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr

INNER JOIN P_LEW_MART_LEAD_AC.v_ref_currency_2 AS curr
ON pay.client_id = curr.client_id
AND rl.currency_iso_cd = curr.currency_iso_cd
;
