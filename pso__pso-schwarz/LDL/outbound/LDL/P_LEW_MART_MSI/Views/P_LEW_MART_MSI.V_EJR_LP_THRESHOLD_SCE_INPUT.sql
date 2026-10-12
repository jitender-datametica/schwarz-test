/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_SCE_INPUT
#----------------------------------------------------------------------------
# History:
#  1.0  18.10.2017    -                        Generiert aus Teradata
#  1.1  09.11.2017    Arnold,Arne              Tabellenreferenz fuer Daten korrigiert. Vorher war noch F_MSI_VIEW referenziert.
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder - show_price_val_max & show_price_val_min - Gruppe 15
#  1.5  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  1.6  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.7  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  1.8  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New columns for metrics Money return with no original receipt
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_threshold_sce_input AS SELECT client_id,
 approval_fg,
 MAX(CASE
   WHEN threshold_group_id = - 1
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS default_val_max,
 MAX(CASE
   WHEN threshold_group_id = 1
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS stornoquote_max,
 MAX(CASE
   WHEN threshold_group_id = 2
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS cancelations_per_100_max,
 MAX(CASE
   WHEN threshold_group_id = 3
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS deposit_rate_max,
 MAX(CASE
   WHEN threshold_group_id = 4
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS payout_manual_val_max,
 MAX(CASE
   WHEN threshold_group_id = 5
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS payout_clean_val_max,
 MAX(CASE
   WHEN threshold_group_id = 6
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS logon_count_max,
 MAX(CASE
   WHEN threshold_group_id = 7
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_smallest_max,
 MAX(CASE
   WHEN threshold_group_id = 8
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_val_max,
 MAX(CASE
   WHEN threshold_group_id = 9
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS total_cash_returns_max,
 MAX(CASE
   WHEN threshold_group_id = 10
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_quota_max,
 MAX(CASE
   WHEN threshold_group_id = 11
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_val_max,
 MAX(CASE
   WHEN threshold_group_id = 12
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_provision_val_max,
 MAX(CASE
   WHEN threshold_group_id = 13
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_count_max,
 MAX(CASE
   WHEN threshold_group_id = 14
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS moneyback_val_max,
 MAX(CASE
   WHEN threshold_group_id = 15
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS show_price_val_max,
 MAX(CASE
   WHEN threshold_group_id = 16
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS discount_cnt_max,
 MAX(CASE
   WHEN threshold_group_id = 17
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS discountquote_max,
 MAX(CASE
   WHEN threshold_group_id = 18
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS mreturn_no_receipt_val_max,
 MIN(CASE
   WHEN threshold_group_id = - 1
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS default_val_min,
 MIN(CASE
   WHEN threshold_group_id = 1
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS stornoquote_min,
 MIN(CASE
   WHEN threshold_group_id = 2
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS cancelations_per_100_min,
 MIN(CASE
   WHEN threshold_group_id = 3
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS deposit_rate_min,
 MIN(CASE
   WHEN threshold_group_id = 4
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS payout_manual_val_min,
 MIN(CASE
   WHEN threshold_group_id = 5
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS payout_clean_val_min,
 MIN(CASE
   WHEN threshold_group_id = 6
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS logon_count_min,
 MIN(CASE
   WHEN threshold_group_id = 7
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_smallest_min,
 MIN(CASE
   WHEN threshold_group_id = 8
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_val_min,
 MIN(CASE
   WHEN threshold_group_id = 9
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS total_cash_returns_min,
 MIN(CASE
   WHEN threshold_group_id = 10
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_quota_min,
 MIN(CASE
   WHEN threshold_group_id = 11
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_val_min,
 MIN(CASE
   WHEN threshold_group_id = 12
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_provision_val_min,
 MIN(CASE
   WHEN threshold_group_id = 13
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_count_min,
 MIN(CASE
   WHEN threshold_group_id = 14
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS moneyback_val_min,
 MIN(CASE
   WHEN threshold_group_id = 15
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS show_price_val_min,
 MIN(CASE
   WHEN threshold_group_id = 16
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS discount_cnt_min,
 MIN(CASE
   WHEN threshold_group_id = 17
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS discountquote_min,
 MIN(CASE
   WHEN threshold_group_id = 18
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS mreturn_no_receipt_val_min
FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario
WHERE dat_rec_end = DATE '9999-12-31'
 AND approval_fg = 1
GROUP BY client_id,
 approval_fg
UNION ALL
SELECT client_id,
 - 1 AS x_approval_fg,
 MAX(CASE
   WHEN threshold_group_id = - 1
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS default_val_max,
 MAX(CASE
   WHEN threshold_group_id = 1
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS stornoquote_max,
 MAX(CASE
   WHEN threshold_group_id = 2
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS cancelations_per_100_max,
 MAX(CASE
   WHEN threshold_group_id = 3
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS deposit_rate_max,
 MAX(CASE
   WHEN threshold_group_id = 4
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS payout_manual_val_max,
 MAX(CASE
   WHEN threshold_group_id = 5
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS payout_clean_val_max,
 MAX(CASE
   WHEN threshold_group_id = 6
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS logon_count_max,
 MAX(CASE
   WHEN threshold_group_id = 7
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_smallest_max,
 MAX(CASE
   WHEN threshold_group_id = 8
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_val_max,
 MAX(CASE
   WHEN threshold_group_id = 9
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS total_cash_returns_max,
 MAX(CASE
   WHEN threshold_group_id = 10
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_quota_max,
 MAX(CASE
   WHEN threshold_group_id = 11
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_val_max,
 MAX(CASE
   WHEN threshold_group_id = 12
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_provision_val_max,
 MAX(CASE
   WHEN threshold_group_id = 13
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_count_max,
 MAX(CASE
   WHEN threshold_group_id = 14
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS moneyback_val_max,
 MAX(CASE
   WHEN threshold_group_id = 15
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS show_price_val_max,
 MAX(CASE
   WHEN threshold_group_id = 16
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS discount_cnt_max,
 MAX(CASE
   WHEN threshold_group_id = 17
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS discountquote_max,
 MAX(CASE
   WHEN threshold_group_id = 18
   THEN max_val_retail_ejr
   ELSE CAST('- 99999999999999999999' AS BIGNUMERIC)
   END) AS mreturn_no_receipt_val_max,
 MIN(CASE
   WHEN threshold_group_id = - 1
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS default_val_min,
 MIN(CASE
   WHEN threshold_group_id = 1
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS stornoquote_min,
 MIN(CASE
   WHEN threshold_group_id = 2
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS cancelations_per_100_min,
 MIN(CASE
   WHEN threshold_group_id = 3
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS deposit_rate_min,
 MIN(CASE
   WHEN threshold_group_id = 4
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS payout_manual_val_min,
 MIN(CASE
   WHEN threshold_group_id = 5
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS payout_clean_val_min,
 MIN(CASE
   WHEN threshold_group_id = 6
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS logon_count_min,
 MIN(CASE
   WHEN threshold_group_id = 7
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_smallest_min,
 MIN(CASE
   WHEN threshold_group_id = 8
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_val_min,
 MIN(CASE
   WHEN threshold_group_id = 9
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS total_cash_returns_min,
 MIN(CASE
   WHEN threshold_group_id = 10
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS moneyreturn_quota_min,
 MIN(CASE
   WHEN threshold_group_id = 11
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_val_min,
 MIN(CASE
   WHEN threshold_group_id = 12
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_provision_val_min,
 MIN(CASE
   WHEN threshold_group_id = 13
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS coupon_abort_count_min,
 MIN(CASE
   WHEN threshold_group_id = 14
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS moneyback_val_min,
 MIN(CASE
   WHEN threshold_group_id = 15
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS show_price_val_min,
 MIN(CASE
   WHEN threshold_group_id = 16
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS discount_cnt_min,
 MIN(CASE
   WHEN threshold_group_id = 17
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS discountquote_min,
 MIN(CASE
   WHEN threshold_group_id = 18
   THEN min_val_retail_ejr
   ELSE CAST('99999999999999999999' AS BIGNUMERIC)
   END) AS mreturn_no_receipt_val_min
FROM (SELECT *
  FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(threshold_group_id AS STRING) ORDER BY
        approval_fg IS NULL, approval_fg, dat_rec_end IS NULL, dat_rec_end)) = 1) AS t3
WHERE dat_rec_end = DATE '9999-12-31'
GROUP BY client_id,
 x_approval_fg
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING) ORDER BY x_approval_fg IS NULL, x_approval_fg)) = 1;


