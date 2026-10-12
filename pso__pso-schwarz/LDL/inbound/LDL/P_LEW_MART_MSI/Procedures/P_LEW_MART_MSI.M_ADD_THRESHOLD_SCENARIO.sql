/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_ADD_THRESHOLD_SCENARIO
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Parameter: show_price_val_max & show_price_val_min - Gruppe 15
#  1.3  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New parameters for discount (Rabatt) metrics
#  1.4  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.5  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  1.6  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New columns: mreturn_no_receipt_val_max, mreturn_no_receipt_val_min for metrics Money return with no original receipt
#  1.7  05.11.2021    Wandtke,Andrzej          AP0089687 "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.M_ADD_THRESHOLD_SCENARIO (CLIENT_ID FLOAT, DEFAULT_VAL_MAX FLOAT, STORNOQUOTE_MAX FLOAT, CANCELATIONS_PER_100_MAX FLOAT, DEPOSIT_RATE_MAX FLOAT, PAYOUT_MANUAL_VAL_MAX FLOAT, PAYOUT_CLEAN_VAL_MAX FLOAT, LOGON_COUNT_MAX FLOAT, COUPON_SMALLEST_MAX FLOAT, MONEYRETURN_VAL_MAX FLOAT, TOTAL_CASH_RETURNS_MAX FLOAT, MONEYRETURN_QUOTA_MAX FLOAT, COUPON_ABORT_VAL_MAX FLOAT, COUPON_PROVISION_VAL_MAX FLOAT, COUPON_ABORT_COUNT_MAX FLOAT, MONEYBACK_VAL_MAX FLOAT, SHOW_PRICE_VAL_MAX FLOAT, DISCOUNT_CNT_MAX FLOAT, DISCOUNTQUOTE_MAX FLOAT, MRETURN_NO_RECEIPT_VAL_MAX FLOAT, DEFAULT_VAL_MIN FLOAT, STORNOQUOTE_MIN FLOAT, CANCELATIONS_PER_100_MIN FLOAT, DEPOSIT_RATE_MIN FLOAT, PAYOUT_MANUAL_VAL_MIN FLOAT, PAYOUT_CLEAN_VAL_MIN FLOAT, LOGON_COUNT_MIN FLOAT, COUPON_SMALLEST_MIN FLOAT, MONEYRETURN_VAL_MIN FLOAT, TOTAL_CASH_RETURNS_MIN FLOAT, MONEYRETURN_QUOTA_MIN FLOAT, COUPON_ABORT_VAL_MIN FLOAT, COUPON_PROVISION_VAL_MIN FLOAT, COUPON_ABORT_COUNT_MIN FLOAT, MONEYBACK_VAL_MIN FLOAT, SHOW_PRICE_VAL_MIN FLOAT, DISCOUNT_CNT_MIN FLOAT, DISCOUNTQUOTE_MIN FLOAT, MRETURN_NO_RECEIPT_VAL_MIN FLOAT, REQUESTING_USER VARCHAR(128))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT, INTO;
var fixBind = function (arg) {
   arg = arg == undefined ? null : arg instanceof Date ? arg.toISOString() : arg;
   return arg;
};
var EXEC = function (stmt,binds,noCatch,catchFunction) {
   try {
      binds = binds ? binds.map(fixBind) : binds;
      _RS = snowflake.createStatement({
            sqlText : stmt,
            binds : binds
         });
      _ROWS = _RS.execute();
      ROW_COUNT = _RS.getRowCount();
      ACTIVITY_COUNT = _RS.getNumRowsAffected();
      if (INTO) return {
         INTO : function () {
            return INTO();
         }
      };
   } catch(error) {
      MESSAGE_TEXT = error.message;
      SQLCODE = error.code;
      SQLSTATE = error.state;
      var msg = `ERROR CODE: ${SQLCODE} SQLSTATE: ${SQLSTATE} MESSAGE: ${MESSAGE_TEXT}`;
      if (catchFunction) catchFunction(error);
      if (!noCatch && ERROR_HANDLERS) ERROR_HANDLERS(error); else throw new Error(msg);
   }
};

/* Delete rows with selected CLIENT_ID that already exists.  */
EXEC(`DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario
WHERE  client_id = ?
AND approval_fg = -1`,[CLIENT_ID]);

/* Inserts new row if client_id exists and at least one row changed  */
EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario 
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
    ,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE             AS dat_rec_start,
'9999-12-31'::DATE       AS dat_rec_end,
CAST(-1 AS SMALLINT)     AS threshold_group_id,
'Default'                AS threshold_group_desc,
?                        AS min_val_retail_ejr,
?                        AS max_val_retail_ejr,
?                        AS requesting_user,
CURRENT_TIMESTAMP(0)     AS timestamp_request,
CAST(-1 AS BYTEINT)      AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country   AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = -1
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[DEFAULT_VAL_MIN,DEFAULT_VAL_MAX,REQUESTING_USER,CLIENT_ID,DEFAULT_VAL_MAX,DEFAULT_VAL_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario 
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
    ,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE           AS dat_rec_start,
'9999-12-31'::DATE     AS dat_rec_end,
CAST(1 AS SMALLINT)    AS threshold_group_id,
'Stornoquote'          AS threshold_group_desc,
?                      AS min_val_retail_ejr,
?                      AS max_val_retail_ejr,
?                      AS requesting_user,
CURRENT_TIMESTAMP(0)   AS timestamp_request,
CAST(-1 AS BYTEINT)    AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 1
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[STORNOQUOTE_MIN,STORNOQUOTE_MAX,REQUESTING_USER,CLIENT_ID,STORNOQUOTE_MAX,STORNOQUOTE_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario 
(client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                  AS dat_rec_start,
'9999-12-31'::DATE            AS dat_rec_end,
CAST(2 AS SMALLINT)           AS threshold_group_id,
'Anzahl Storni pro 100 Bons'  AS threshold_group_desc,
?                             AS min_val_retail_ejr,
?                             AS max_val_retail_ejr,
?                             AS requesting_user,
CURRENT_TIMESTAMP(0)          AS timestamp_request,
CAST(-1 AS BYTEINT)           AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 2
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
     OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
     OR orig.client_id IS NULL )`
,[CANCELATIONS_PER_100_MIN,CANCELATIONS_PER_100_MAX,REQUESTING_USER,CLIENT_ID,CANCELATIONS_PER_100_MAX,CANCELATIONS_PER_100_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario 
 ( client_id
 , dat_rec_start
 , dat_rec_end
 , threshold_group_id
 , threshold_group_desc
 , min_val_retail_ejr
 , max_val_retail_ejr
 , requesting_user
 , timestamp_request
 , approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE          AS dat_rec_start,
'9999-12-31'::DATE    AS dat_rec_end,
CAST(3 AS SMALLINT)   AS threshold_group_id,
'Pfandquote'          AS threshold_group_desc,
?                     AS min_val_retail_ejr,
?                     AS max_val_retail_ejr,
?                     AS requesting_user,
CURRENT_TIMESTAMP(0)  AS timestamp_request,
CAST(-1 AS BYTEINT)   AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 3
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[DEPOSIT_RATE_MIN,DEPOSIT_RATE_MAX,REQUESTING_USER,CLIENT_ID,DEPOSIT_RATE_MAX,DEPOSIT_RATE_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario 
 ( client_id
 , dat_rec_start
 , dat_rec_end
 , threshold_group_id
 , threshold_group_desc
 , min_val_retail_ejr
 , max_val_retail_ejr
 , requesting_user
 , timestamp_request
 , approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE                    AS dat_rec_start,
'9999-12-31'::DATE              AS dat_rec_end,
CAST(4 AS SMALLINT)             AS threshold_group_id,
'Wert manuelle Pfandauszahlung' AS threshold_group_desc,
?                               AS min_val_retail_ejr,
?                               AS max_val_retail_ejr,
?                               AS requesting_user,
CURRENT_TIMESTAMP(0)            AS timestamp_request,
CAST(-1 AS BYTEINT)             AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 4
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[PAYOUT_MANUAL_VAL_MIN,PAYOUT_MANUAL_VAL_MAX,REQUESTING_USER,CLIENT_ID,PAYOUT_MANUAL_VAL_MAX,PAYOUT_MANUAL_VAL_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario 
(client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE                  AS dat_rec_start,
'9999-12-31'::DATE            AS dat_rec_end,
CAST(5 AS SMALLINT)           AS threshold_group_id,
'Wert reine Pfandauszahlung'  AS threshold_group_desc,
?                             AS min_val_retail_ejr,
?                             AS max_val_retail_ejr,
?                             AS requesting_user,
CURRENT_TIMESTAMP(0)          AS timestamp_request,
CAST(-1 AS BYTEINT)           AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 5
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[PAYOUT_CLEAN_VAL_MIN,PAYOUT_CLEAN_VAL_MAX,REQUESTING_USER,CLIENT_ID,PAYOUT_CLEAN_VAL_MAX,PAYOUT_CLEAN_VAL_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario 
(client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                   AS dat_rec_start,
'9999-12-31'::DATE             AS dat_rec_end,
CAST(6 AS SMALLINT)            AS threshold_group_id,
'Ã-Anzahl An-/Abmeldung'     AS threshold_group_desc,
?                              AS min_val_retail_ejr,
?                              AS max_val_retail_ejr,
?                              AS requesting_user,
CURRENT_TIMESTAMP(0)           AS timestamp_request,
CAST(-1 AS BYTEINT)            AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 6
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[LOGON_COUNT_MIN,LOGON_COUNT_MAX,REQUESTING_USER,CLIENT_ID,LOGON_COUNT_MAX,LOGON_COUNT_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE             AS dat_rec_start,
'9999-12-31'::DATE       AS dat_rec_end,
CAST(7 AS SMALLINT)      AS threshold_group_id,
'Anzahl Kleinstbon'      AS threshold_group_desc,
?                        AS min_val_retail_ejr,
?                        AS max_val_retail_ejr,
?                        AS requesting_user,
CURRENT_TIMESTAMP(0)     AS timestamp_request,
CAST(-1 AS BYTEINT)      AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 7
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[COUPON_SMALLEST_MIN,COUPON_SMALLEST_MAX,REQUESTING_USER,CLIENT_ID,COUPON_SMALLEST_MAX,COUPON_SMALLEST_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                AS dat_rec_start,
'9999-12-31'::DATE          AS dat_rec_end,
CAST(8 AS SMALLINT)         AS threshold_group_id,
'Ã-GeldrÃ¼ckgabenwert'     AS threshold_group_desc,
?                           AS min_val_retail_ejr,
?                           AS max_val_retail_ejr,
?                           AS requesting_user,
CURRENT_TIMESTAMP(0)        AS timestamp_request,
CAST(-1 AS BYTEINT)         AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 8
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[MONEYRETURN_VAL_MIN,MONEYRETURN_VAL_MAX,REQUESTING_USER,CLIENT_ID,MONEYRETURN_VAL_MAX,MONEYRETURN_VAL_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                  AS dat_rec_start,
'9999-12-31'::DATE            AS dat_rec_end,
CAST(9 AS SMALLINT)           AS threshold_group_id,
'Gesamtanzahl GeldrÃ¼ckgaben' AS threshold_group_desc,
?                             AS min_val_retail_ejr,
?                             AS max_val_retail_ejr,
?                             AS requesting_user,
CURRENT_TIMESTAMP(0)          AS timestamp_request,
CAST(-1 AS BYTEINT)           AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 9
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[TOTAL_CASH_RETURNS_MIN,TOTAL_CASH_RETURNS_MAX,REQUESTING_USER,CLIENT_ID,TOTAL_CASH_RETURNS_MAX,TOTAL_CASH_RETURNS_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE              AS dat_rec_start,
'9999-12-31'::DATE        AS dat_rec_end,
CAST(10 AS SMALLINT)      AS threshold_group_id,
'GeldrÃ¼ckgabenquote'     AS threshold_group_desc,
?                         AS min_val_retail_ejr,
?                         AS max_val_retail_ejr,
?                         AS requesting_user,
CURRENT_TIMESTAMP(0)      AS timestamp_request,
CAST(-1 AS BYTEINT)       AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 10
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[MONEYRETURN_QUOTA_MIN,MONEYRETURN_QUOTA_MAX,REQUESTING_USER,CLIENT_ID,MONEYRETURN_QUOTA_MAX,MONEYRETURN_QUOTA_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                       AS dat_rec_start,
'9999-12-31'::DATE                 AS dat_rec_end,
CAST(11 AS SMALLINT)               AS threshold_group_id,
'Gesamtwert Bonabbruch (>=X Å¡)'   AS threshold_group_desc,
?                                  AS min_val_retail_ejr,
?                                  AS max_val_retail_ejr,
?                                  AS requesting_user,
CURRENT_TIMESTAMP(0)               AS timestamp_request,
CAST(-1 AS BYTEINT)                AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 11
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[COUPON_ABORT_VAL_MIN,COUPON_ABORT_VAL_MAX,REQUESTING_USER,CLIENT_ID,COUPON_ABORT_VAL_MAX,COUPON_ABORT_VAL_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                            AS dat_rec_start,
'9999-12-31'::DATE                      AS dat_rec_end,
CAST(12 AS SMALLINT)                    AS threshold_group_id,
'Gesamtanzahl offene BonrÃ¼ckstellung'  AS threshold_group_desc,
?                                       AS min_val_retail_ejr,
?                                       AS max_val_retail_ejr,
?                                       AS requesting_user,
CURRENT_TIMESTAMP(0)                    AS timestamp_request,
CAST(-1 AS BYTEINT)                     AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 12
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[COUPON_PROVISION_VAL_MIN,COUPON_PROVISION_VAL_MAX,REQUESTING_USER,CLIENT_ID,COUPON_PROVISION_VAL_MAX,COUPON_PROVISION_VAL_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE               AS dat_rec_start,
'9999-12-31'::DATE         AS dat_rec_end,
CAST(13 AS SMALLINT)       AS threshold_group_id,
'Gesamtanzahl Bonabbruch'  AS threshold_group_desc,
?                          AS min_val_retail_ejr,
?                          AS max_val_retail_ejr,
?                          AS requesting_user,
CURRENT_TIMESTAMP(0)       AS timestamp_request,
CAST(-1 AS BYTEINT)        AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 13
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[COUPON_ABORT_COUNT_MIN,COUPON_ABORT_COUNT_MAX,REQUESTING_USER,CLIENT_ID,COUPON_ABORT_COUNT_MAX,COUPON_ABORT_COUNT_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE             AS dat_rec_start,
'9999-12-31'::DATE       AS dat_rec_end,
CAST(14 AS SMALLINT)     AS threshold_group_id,
'GeldrÃ¼ckgabe manual'   AS threshold_group_desc,
?                        AS min_val_retail_ejr,
?                        AS max_val_retail_ejr,
?                        AS requesting_user,
CURRENT_TIMESTAMP(0)     AS timestamp_request,
CAST(-1 AS BYTEINT)      AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id           = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 14
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[MONEYBACK_VAL_MIN,MONEYBACK_VAL_MAX,REQUESTING_USER,CLIENT_ID,MONEYBACK_VAL_MAX,MONEYBACK_VAL_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE            AS dat_rec_start,
'9999-12-31'::DATE      AS dat_rec_end,
CAST(15 AS SMALLINT)    AS threshold_group_id,
'Preisanzeige manual'   AS threshold_group_desc,
?                       AS min_val_retail_ejr,
?                       AS max_val_retail_ejr,
?                       AS requesting_user,
CURRENT_TIMESTAMP(0)    AS timestamp_request,
CAST(-1 AS BYTEINT)     AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id           = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 15
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[SHOW_PRICE_VAL_MIN,SHOW_PRICE_VAL_MAX,REQUESTING_USER,CLIENT_ID,SHOW_PRICE_VAL_MAX,SHOW_PRICE_VAL_MIN]);


EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                    AS dat_rec_start,
'9999-12-31'::DATE              AS dat_rec_end,
CAST(16 AS SMALLINT)            AS threshold_group_id,
'Gesamtanzahl manueller Rabatt' AS threshold_group_desc,
?                               AS min_val_retail_ejr,
?                               AS max_val_retail_ejr,
?                               AS requesting_user,
CURRENT_TIMESTAMP(0)            AS timestamp_request,
CAST(-1 AS BYTEINT)             AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id           = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 16
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[DISCOUNT_CNT_MIN,DISCOUNT_CNT_MAX,REQUESTING_USER,CLIENT_ID,DISCOUNT_CNT_MAX,DISCOUNT_CNT_MIN]);


EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)SELECT
cnt.client_id,
CURRENT_DATE                    AS dat_rec_start,
'9999-12-31'::DATE              AS dat_rec_end,
CAST(17 AS SMALLINT)            AS threshold_group_id,
'Rabattquote'                   AS threshold_group_desc,
?                               AS min_val_retail_ejr,
?                               AS max_val_retail_ejr,
?                               AS requesting_user,
CURRENT_TIMESTAMP(0)            AS timestamp_request,
CAST(-1 AS BYTEINT)             AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id           = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 17
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[DISCOUNTQUOTE_MIN,DISCOUNTQUOTE_MAX,REQUESTING_USER,CLIENT_ID,DISCOUNTQUOTE_MAX,DISCOUNTQUOTE_MIN]);

EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario (
client_id
,dat_rec_start
,dat_rec_end
,threshold_group_id
,threshold_group_desc
,min_val_retail_ejr
,max_val_retail_ejr
,requesting_user
,timestamp_request
,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE                                              AS dat_rec_start,
'9999-12-31'::DATE                                        AS dat_rec_end,
CAST(18 AS SMALLINT)                                      AS threshold_group_id,
'Gesamtanzahl Geldr'||'\u00FC'||'ckgabe ohne Originalbon' AS threshold_group_desc,
?                                                         AS min_val_retail_ejr,
?                                                         AS max_val_retail_ejr,
?                                                         AS requesting_user,
CURRENT_TIMESTAMP(0)                                      AS timestamp_request,
CAST(-1 AS BYTEINT)                                       AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario AS orig
ON cnt.client_id           = orig.client_id
AND CURRENT_DATE BETWEEN orig.dat_rec_start AND orig.dat_rec_end
AND orig.threshold_group_id = 18
WHERE cnt.client_id = ?
AND (    COALESCE(orig.max_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR COALESCE(orig.min_val_retail_ejr,-99999999999999)  <> COALESCE(? ,-99999999999999)
      OR orig.client_id IS NULL )`
,[MRETURN_NO_RECEIPT_VAL_MIN,MRETURN_NO_RECEIPT_VAL_MAX,REQUESTING_USER,CLIENT_ID,MRETURN_NO_RECEIPT_VAL_MAX,MRETURN_NO_RECEIPT_VAL_MIN]);


var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$
;