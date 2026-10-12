/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_ADD_THRESHOLD_SCENARIO
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Parameter: show_price_val_max & show_price_val_min - Gruppe_1 15
#  1.3  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New parameters for discount (Rabatt) metrics
#  1.4  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.5  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  1.6  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New columns: mreturn_no_receipt_val_max, mreturn_no_receipt_val_min for metrics Money return with no original receipt
#  1.7  05.11.2021    Wandtke,Andrzej          AP0089687 "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_add_threshold_scenario(
    CLIENT_ID FLOAT64, 
    DEFAULT_VAL_MAX FLOAT64, 
    STORNOQUOTE_MAX FLOAT64, 
    CANCELATIONS_PER_100_MAX FLOAT64, 
    DEPOSIT_RATE_MAX FLOAT64, 
    PAYOUT_MANUAL_VAL_MAX FLOAT64, 
    PAYOUT_CLEAN_VAL_MAX FLOAT64, 
    LOGON_COUNT_MAX FLOAT64, 
    COUPON_SMALLEST_MAX FLOAT64, 
    MONEYRETURN_VAL_MAX FLOAT64, 
    TOTAL_CASH_RETURNS_MAX FLOAT64, 
    MONEYRETURN_QUOTA_MAX FLOAT64, 
    COUPON_ABORT_VAL_MAX FLOAT64, 
    COUPON_PROVISION_VAL_MAX FLOAT64, 
    COUPON_ABORT_COUNT_MAX FLOAT64, 
    MONEYBACK_VAL_MAX FLOAT64, 
    SHOW_PRICE_VAL_MAX FLOAT64, 
    DISCOUNT_CNT_MAX FLOAT64, 
    DISCOUNTQUOTE_MAX FLOAT64, 
    MRETURN_NO_RECEIPT_VAL_MAX FLOAT64, 
    DEFAULT_VAL_MIN FLOAT64, 
    STORNOQUOTE_MIN FLOAT64, 
    CANCELATIONS_PER_100_MIN FLOAT64, 
    DEPOSIT_RATE_MIN FLOAT64, 
    PAYOUT_MANUAL_VAL_MIN FLOAT64, 
    PAYOUT_CLEAN_VAL_MIN FLOAT64, 
    LOGON_COUNT_MIN FLOAT64, 
    COUPON_SMALLEST_MIN FLOAT64, 
    MONEYRETURN_VAL_MIN FLOAT64, 
    TOTAL_CASH_RETURNS_MIN FLOAT64, 
    MONEYRETURN_QUOTA_MIN FLOAT64, 
    COUPON_ABORT_VAL_MIN FLOAT64, 
    COUPON_PROVISION_VAL_MIN FLOAT64, 
    COUPON_ABORT_COUNT_MIN FLOAT64, 
    MONEYBACK_VAL_MIN FLOAT64, 
    SHOW_PRICE_VAL_MIN FLOAT64, 
    DISCOUNT_CNT_MIN FLOAT64, 
    DISCOUNTQUOTE_MIN FLOAT64, 
    MRETURN_NO_RECEIPT_VAL_MIN FLOAT64, 
    REQUESTING_USER STRING
)
BEGIN

  BEGIN TRANSACTION;

  /* Delete rows with selected CLIENT_ID that already exists.  */
  EXECUTE IMMEDIATE """
    DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1
    WHERE client_id = @CLIENT_ID
      AND approval_fg = -1
  """ USING CLIENT_ID as CLIENT_ID;

  /* Inserts new row if client_id exists and at least one row changed  */
  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (
        client_id
        ,dat_rec_start
        ,dat_rec_end
        ,threshold_group_id
        ,threshold_group_desc
        ,min_val_retail_ejr
        ,max_val_retail_ejr
        ,requesting_user
        ,timestamp_request
        ,approval_fg
    )
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin")                             AS dat_rec_start,
      DATE '9999-12-31'                          AS dat_rec_end,
      CAST(-1 AS INT64)                          AS threshold_group_id,
      'Default'                                  AS threshold_group_desc,
      CAST(@DEFAULT_VAL_MIN AS NUMERIC)                                          AS min_val_retail_ejr,
      CAST(@DEFAULT_VAL_MAX AS NUMERIC)                                          AS max_val_retail_ejr,
      @REQUESTING_USER                                          AS requesting_user,
      CAST(CURRENT_TIMESTAMP() AS DATETIME)                        AS timestamp_request,
      CAST(-1 AS INT64)                          AS approval_fg
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = -1
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@DEFAULT_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@DEFAULT_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING DEFAULT_VAL_MIN as DEFAULT_VAL_MIN, DEFAULT_VAL_MAX as DEFAULT_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin")                             AS dat_rec_start,
      DATE '9999-12-31'                          AS dat_rec_end,
      CAST(1 AS INT64)                           AS threshold_group_id,
      'Stornoquote'                              AS threshold_group_desc,
      CAST(@STORNOQUOTE_MIN AS NUMERIC), CAST(@STORNOQUOTE_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 1
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@STORNOQUOTE_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@STORNOQUOTE_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING STORNOQUOTE_MIN as STORNOQUOTE_MIN, STORNOQUOTE_MAX as STORNOQUOTE_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(2 AS INT64), 'Anzahl Storni pro 100 Bons',
      CAST(@CANCELATIONS_PER_100_MIN AS NUMERIC), CAST(@CANCELATIONS_PER_100_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 2
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@CANCELATIONS_PER_100_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@CANCELATIONS_PER_100_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING CANCELATIONS_PER_100_MIN as CANCELATIONS_PER_100_MIN, CANCELATIONS_PER_100_MAX as CANCELATIONS_PER_100_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(3 AS INT64), 'Pfandquote',
      CAST(@DEPOSIT_RATE_MIN AS NUMERIC), CAST(@DEPOSIT_RATE_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 3
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@DEPOSIT_RATE_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@DEPOSIT_RATE_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING DEPOSIT_RATE_MIN as DEPOSIT_RATE_MIN, DEPOSIT_RATE_MAX as DEPOSIT_RATE_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(4 AS INT64), 'Wert manuelle Pfandauszahlung',
      CAST(@PAYOUT_MANUAL_VAL_MIN AS NUMERIC), CAST(@PAYOUT_MANUAL_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 4
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@PAYOUT_MANUAL_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@PAYOUT_MANUAL_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING PAYOUT_MANUAL_VAL_MIN as PAYOUT_MANUAL_VAL_MIN, PAYOUT_MANUAL_VAL_MAX as PAYOUT_MANUAL_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(5 AS INT64), 'Wert reine Pfandauszahlung',
      CAST(@PAYOUT_CLEAN_VAL_MIN AS NUMERIC), CAST(@PAYOUT_CLEAN_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 5
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@PAYOUT_CLEAN_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@PAYOUT_CLEAN_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING PAYOUT_CLEAN_VAL_MIN as PAYOUT_CLEAN_VAL_MIN, PAYOUT_CLEAN_VAL_MAX as PAYOUT_CLEAN_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(6 AS INT64), 'Ø-Anzahl An-/Abmeldung',
      CAST(@LOGON_COUNT_MIN AS NUMERIC), CAST(@LOGON_COUNT_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 6
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@LOGON_COUNT_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@LOGON_COUNT_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING LOGON_COUNT_MIN as LOGON_COUNT_MIN, LOGON_COUNT_MAX as LOGON_COUNT_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(7 AS INT64), 'Anzahl Kleinstbon',
      CAST(@COUPON_SMALLEST_MIN AS NUMERIC), CAST(@COUPON_SMALLEST_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 7
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_SMALLEST_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_SMALLEST_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING COUPON_SMALLEST_MIN as COUPON_SMALLEST_MIN, COUPON_SMALLEST_MAX as COUPON_SMALLEST_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(8 AS INT64), 'Ø-Geldrückgabenwert',
      CAST(@MONEYRETURN_VAL_MIN AS NUMERIC), CAST(@MONEYRETURN_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 8
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@MONEYRETURN_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@MONEYRETURN_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING MONEYRETURN_VAL_MIN as MONEYRETURN_VAL_MIN, MONEYRETURN_VAL_MAX as MONEYRETURN_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(9 AS INT64), 'Gesamtanzahl Geldrückgaben',
      CAST(@TOTAL_CASH_RETURNS_MIN AS NUMERIC), CAST(@TOTAL_CASH_RETURNS_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 9
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@TOTAL_CASH_RETURNS_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@TOTAL_CASH_RETURNS_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING TOTAL_CASH_RETURNS_MIN as TOTAL_CASH_RETURNS_MIN, TOTAL_CASH_RETURNS_MAX as TOTAL_CASH_RETURNS_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(10 AS INT64), 'Geldrückgabenquote',
      CAST(@MONEYRETURN_QUOTA_MIN AS NUMERIC), CAST(@MONEYRETURN_QUOTA_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 10
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@MONEYRETURN_QUOTA_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@MONEYRETURN_QUOTA_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING MONEYRETURN_QUOTA_MIN as MONEYRETURN_QUOTA_MIN, MONEYRETURN_QUOTA_MAX as MONEYRETURN_QUOTA_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(11 AS INT64), 'Gesamtwert Bonabbruch (>=X €)',
      CAST(@COUPON_ABORT_VAL_MIN AS NUMERIC), CAST(@COUPON_ABORT_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 11
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_ABORT_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_ABORT_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING COUPON_ABORT_VAL_MIN as COUPON_ABORT_VAL_MIN, COUPON_ABORT_VAL_MAX as COUPON_ABORT_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(12 AS INT64), 'Gesamtanzahl offene Bonrückstellung',
      CAST(@COUPON_PROVISION_VAL_MIN AS NUMERIC), CAST(@COUPON_PROVISION_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 12
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_PROVISION_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_PROVISION_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING COUPON_PROVISION_VAL_MIN as COUPON_PROVISION_VAL_MIN, COUPON_PROVISION_VAL_MAX as COUPON_PROVISION_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(13 AS INT64), 'Gesamtanzahl Bonabbruch',
      CAST(@COUPON_ABORT_COUNT_MIN AS NUMERIC), CAST(@COUPON_ABORT_COUNT_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 13
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_ABORT_COUNT_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@COUPON_ABORT_COUNT_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING COUPON_ABORT_COUNT_MIN as COUPON_ABORT_COUNT_MIN, COUPON_ABORT_COUNT_MAX as COUPON_ABORT_COUNT_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(14 AS INT64), 'Geldrückgabe manual',
      CAST(@MONEYBACK_VAL_MIN AS NUMERIC), CAST(@MONEYBACK_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 14
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@MONEYBACK_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@MONEYBACK_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING MONEYBACK_VAL_MIN as MONEYBACK_VAL_MIN, MONEYBACK_VAL_MAX as MONEYBACK_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(15 AS INT64), 'Preisanzeige manual',
      CAST(@SHOW_PRICE_VAL_MIN AS NUMERIC), CAST(@SHOW_PRICE_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 15
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@SHOW_PRICE_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@SHOW_PRICE_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING SHOW_PRICE_VAL_MIN as SHOW_PRICE_VAL_MIN, SHOW_PRICE_VAL_MAX as SHOW_PRICE_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(16 AS INT64), 'Gesamtanzahl manueller Rabatt',
      CAST(@DISCOUNT_CNT_MIN AS NUMERIC), CAST(@DISCOUNT_CNT_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 16
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@DISCOUNT_CNT_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@DISCOUNT_CNT_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING DISCOUNT_CNT_MIN as DISCOUNT_CNT_MIN, DISCOUNT_CNT_MAX as DISCOUNT_CNT_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(17 AS INT64), 'Rabattquote',
      CAST(@DISCOUNTQUOTE_MIN AS NUMERIC), CAST(@DISCOUNTQUOTE_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 17
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@DISCOUNTQUOTE_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@DISCOUNTQUOTE_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING DISCOUNTQUOTE_MIN as DISCOUNTQUOTE_MIN, DISCOUNTQUOTE_MAX as DISCOUNTQUOTE_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
    (client_id, dat_rec_start, dat_rec_end, threshold_group_id, threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr, requesting_user, timestamp_request, approval_fg)
    SELECT
      cnt.client_id,
      CURRENT_DATE("Europe/Berlin"), DATE '9999-12-31', CAST(18 AS INT64), 'Gesamtanzahl Geldrückgabe ohne Originalbon',
      CAST(@MRETURN_NO_RECEIPT_VAL_MIN AS NUMERIC), CAST(@MRETURN_NO_RECEIPT_VAL_MAX AS NUMERIC), @REQUESTING_USER, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(-1 AS INT64)
    FROM p_lew_core_ac.v_wawi_ref_client_country_1 AS cnt
    LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 AS orig
      ON cnt.client_id = orig.client_id
      AND CURRENT_DATE("Europe/Berlin") BETWEEN orig.dat_rec_start AND orig.dat_rec_end
      AND orig.threshold_group_id = 18
    WHERE cnt.client_id = @CLIENT_ID
      AND ( COALESCE(orig.max_val_retail_ejr, -99999999999999.0) <> COALESCE(@MRETURN_NO_RECEIPT_VAL_MAX, -99999999999999.0)
         OR COALESCE(orig.min_val_retail_ejr, -99999999999999.0) <> COALESCE(@MRETURN_NO_RECEIPT_VAL_MIN, -99999999999999.0)
         OR orig.client_id IS NULL )
  """ USING MRETURN_NO_RECEIPT_VAL_MIN as MRETURN_NO_RECEIPT_VAL_MIN, MRETURN_NO_RECEIPT_VAL_MAX as MRETURN_NO_RECEIPT_VAL_MAX, REQUESTING_USER as REQUESTING_USER, CLIENT_ID as CLIENT_ID;

  COMMIT TRANSACTION;

END;