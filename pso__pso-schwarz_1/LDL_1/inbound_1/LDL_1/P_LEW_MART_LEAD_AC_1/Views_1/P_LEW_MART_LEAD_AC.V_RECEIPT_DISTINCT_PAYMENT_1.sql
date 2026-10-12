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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_RECEIPT_DISTINCT_PAYMENT_1 COMMENT = 'Distinct payment types for receipton line level, with a proportion of payment for specific payment type to whole payment'
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
, val_retail_net_ejr COMMENT 'Sales_1 value from receiptline'
, val_retail_net_ejr_adjusted COMMENT 'Sales_1 value from receiptline adjusted by proportion of payment for specific payment type to whole payment'
, val_retail_ejr_adjusted COMMENT 'Sales_1 gross value from receiptline adjusted by proportion of payment for specific payment type to whole payment'
)
AS
SELECT store_id
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
     , val_retail_payment_ejr
     , val_retail_payment_sum
     , val_retail_payment_perc_of_sum
     , val_retail_net_ejr
     , val_retail_net_ejr_adjusted
     , val_retail_ejr_adjusted
FROM P_LEW_MART_LEAD.V_RECEIPT_DISTINCT_PAYMENT_1
;
