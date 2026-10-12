/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_EJR_LP_THRESHOLD_SCE_INPUT_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  03.05.2018    Wieber.Harald            Release 3.6
#  1.9  17.05.2018    Wieber,Harald            Update Release 3.8
#  2.0  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder - show_price_val_max & show_price_val_min
#  2.1  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  2.2  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  2.3  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  2.4  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New columns mreturn_no_receipt_val_max, mreturn_no_receipt_val_min for metrics Money return with no original receipt
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_LP_THRESHOLD_SCE_INPUT_1
(
      client_id
    , approval_fg
    , default_val_max
    , stornoquote_max
    , cancelations_per_100_max
    , deposit_rate_max
    , payout_manual_val_max
    , payout_clean_val_max
    , logon_count_max
    , coupon_smallest_max
    , moneyreturn_val_max
    , total_cash_returns_max
    , moneyreturn_quota_max
    , coupon_abort_val_max
    , coupon_provision_val_max
    , coupon_abort_count_max
    , moneyback_val_max
    , show_price_val_max
    , discount_cnt_max
    , discountquote_max
    , mreturn_no_receipt_val_max
    , default_val_min
    , stornoquote_min
    , cancelations_per_100_min
    , deposit_rate_min
    , payout_manual_val_min
    , payout_clean_val_min
    , logon_count_min
    , coupon_smallest_min
    , moneyreturn_val_min
    , total_cash_returns_min
    , moneyreturn_quota_min
    , coupon_abort_val_min
    , coupon_provision_val_min
    , coupon_abort_count_min
    , moneyback_val_min
    , show_price_val_min
    , discount_cnt_min
    , discountquote_min
    , mreturn_no_receipt_val_min
)
AS
   SELECT
   client_id,
   approval_fg,
   default_val_max,
   stornoquote_max,
   cancelations_per_100_max,
   deposit_rate_max,
   payout_manual_val_max,
   payout_clean_val_max,
   logon_count_max,
   coupon_smallest_max,
   moneyreturn_val_max,
   total_cash_returns_max,
   moneyreturn_quota_max,
   coupon_abort_val_max,
   coupon_provision_val_max,
   coupon_abort_count_max,
   moneyback_val_max,
   show_price_val_max,
   discount_cnt_max,
   discountquote_max,
   mreturn_no_receipt_val_max,
   default_val_min,
   stornoquote_min,
   cancelations_per_100_min,
   deposit_rate_min,
   payout_manual_val_min,
   payout_clean_val_min,
   logon_count_min,
   coupon_smallest_min,
   moneyreturn_val_min,
   total_cash_returns_min,
   moneyreturn_quota_min,
   coupon_abort_val_min,
   coupon_provision_val_min,
   coupon_abort_count_min,
   moneyback_val_min,
   show_price_val_min,
   discount_cnt_min,
   discountquote_min,
   mreturn_no_receipt_val_min
  FROM p_lew_mart_msi.v_ejr_lp_threshold_sce_input_1
;