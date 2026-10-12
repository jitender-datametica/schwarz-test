/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_ADD_THRESHOLD_CUMULATION
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_freq_same_checker
#  1.3  04.11.2021    Wandtke,Andrzej          AP0089687 remove _mc (copy/paste error)
#  1.4  10.11.2021    Wandtke,Andrzej          AP0089687 apply preambule with EXEC function as to handle null values
#  1.5  08.12.2021    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add parameter PRICE_SSQ_DAYS_QTY_PAST_3M
#  1.6  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add columns deposit_noitm_qty_trans_past_3m and deposit_noitm_days_qty_past_3m
#  1.7  20.03.2023    Wandtke,Andrzej          AP0152808 : Add parameter I_RETURN_NO_RECEIPT_QTY
#  1.8  13.04.2023    Wandtke,Andrzej          AP0170366 : Add column I_RETURN_MANY_ITM_QTY
#  1.9  12.03.2024    Szewczyk,Milosz          AP0188368 : Add column I_PLUS_DAYS
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_add_threshold_cumulation (I_CLIENT_ID FLOAT, I_VOID_QTY_TRANS_PAST_3MTH FLOAT, I_VOID_QTY_TRANS_RANDOM_1W FLOAT, I_SUSP_QTY_TRANS_PAST_3MTH FLOAT, I_SUSP_QTY_TRANS_RANDOM_1W FLOAT, I_RETURN_QTY_TRANS_PAST_3MTH FLOAT, I_RETURN_FREQ_SAME_ITEM_IN_1W FLOAT, I_RET_THRESHOLD_QTY_WEEK_IN_3M FLOAT, I_RETURN_S2_QTY_TRANS_PAST_3M FLOAT, I_RETURN_QTY_TRANS_RANDOM_1W FLOAT, I_DEPOSIT_QTY_TRANS_PAST_3MTH FLOAT, I_DEPOSIT_EAN_QTY_TRANS_PAST_3M FLOAT, I_DEPOSIT_NOITM_QTY_TRANS_PAST_3M FLOAT, I_DEPOSIT_NOITM_DAYS_QTY_PAST_3M FLOAT, I_DEPOSIT_1ITM_QTY_TRANS_PAST_3M FLOAT, I_DEPOSIT_1ITM_QTY_TRANS_RAND_1W FLOAT, I_DEPOSIT_AMT_QTY_TRANS_PAST_3M FLOAT, I_DEPOSIT_AMT_QTY_TRANS_RAND_1W FLOAT, I_PRICE_SSQ_DAYS_QTY_PAST_3M FLOAT, I_PRICE_SSQ_QTY_TRANS_PAST_3M FLOAT, I_PRICE_SSQ_QTY_TRANS_RANDM_1W FLOAT, I_SUSP_QTY_TRANS_PAST_3MTH_MC FLOAT, I_SUSP_QTY_TRANS_RANDOM_1W_MC FLOAT, I_DEPOSIT_QTY_TOTAL_PAST_3MTH FLOAT, I_PRICE_SERIES_QTY_PAST_3M FLOAT, I_RET_QTY_STORE_SAME_REC_PAST_3M FLOAT, I_RET_QTY_NOT_AUTHORISED_PAST_3M FLOAT, I_RETURN_FREQ_SAME_CHECKER FLOAT, I_RETURN_NO_RECEIPT_QTY FLOAT, I_RETURN_MANY_ITM_QTY FLOAT, I_PLUS_DAYS FLOAT, I_REQUESTING_USER VARCHAR(128))
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

//Delete rows with selected CLIENT_ID that already exists.

EXEC(`DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2
WHERE  client_id = ?
AND approval_fg = -1`,[I_CLIENT_ID]);


//Inserts new row if client_id exists and at least one row changed
EXEC(`INSERT INTO p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2 (
client_id
,dat_rec_start
,dat_rec_end
,void_qty_trans_past_3mth
,void_qty_trans_random_1w
,susp_qty_trans_past_3mth
,susp_qty_trans_random_1w
,return_qty_trans_past_3mth
,return_freq_same_item_in_1w
,ret_threshold_qty_week_in_3m
,return_s2_qty_trans_past_3m
,return_qty_trans_random_1w
,deposit_qty_trans_past_3mth
,deposit_ean_qty_trans_past_3m
,deposit_noitm_qty_trans_past_3m
,deposit_noitm_days_qty_past_3m
,deposit_1itm_qty_trans_past_3m
,deposit_1itm_qty_trans_rand_1w
,deposit_amt_qty_trans_past_3m
,deposit_amt_qty_trans_rand_1w
,price_ssq_days_qty_past_3m
,price_ssq_qty_trans_past_3m
,price_ssq_qty_trans_randm_1w
,susp_qty_trans_past_3mth_mc
,susp_qty_trans_random_1w_mc
,deposit_qty_total_past_3mth
,price_series_qty_past_3m
,ret_qty_store_same_rec_past_3m
,ret_qty_not_authorised_past_3m
,return_freq_same_checker
,return_no_receipt_qty
,return_many_itm_qty
,plus_days
,requesting_user
,timestamp_request
,approval_fg)
SELECT
cnt.client_id,
CURRENT_DATE AS dat_rec_start,
'9999-12-31' AS dat_rec_end,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?,
? requesting_user,
CURRENT_TIMESTAMP(0) AS timestamp_request,
-1 AS approval_fg
FROM p_lew_core_ac.v_wawi_ref_client_country_2 AS cnt
LEFT OUTER JOIN p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2 AS orig
ON cnt.client_id = orig.client_id
AND Current_Date BETWEEN orig.dat_rec_start AND orig.dat_rec_end

WHERE  cnt.client_id = ?
AND
(
   Coalesce(orig.void_qty_trans_past_3mth       ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.void_qty_trans_random_1w       ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.susp_qty_trans_past_3mth       ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.susp_qty_trans_random_1w       ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.return_qty_trans_past_3mth     ,-99999999999999)  <> Coalesce(?     ,-99999999999999)
OR Coalesce(orig.return_freq_same_item_in_1w    ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.ret_threshold_qty_week_in_3m   ,-99999999999999)  <> Coalesce(?   ,-99999999999999)
OR Coalesce(orig.return_s2_qty_trans_past_3m    ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.return_qty_trans_random_1w     ,-99999999999999)  <> Coalesce(?     ,-99999999999999)
OR Coalesce(orig.deposit_qty_trans_past_3mth    ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.deposit_ean_qty_trans_past_3m  ,-99999999999999)  <> Coalesce(?  ,-99999999999999)
OR Coalesce(orig.deposit_noitm_qty_trans_past_3m,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_noitm_days_qty_past_3m ,-99999999999999)  <> Coalesce(?, -99999999999999)
OR Coalesce(orig.deposit_1itm_qty_trans_past_3m ,-99999999999999)  <> Coalesce(? ,-99999999999999)
OR Coalesce(orig.deposit_1itm_qty_trans_rand_1w ,-99999999999999)  <> Coalesce(? ,-99999999999999)
OR Coalesce(orig.deposit_amt_qty_trans_past_3m  ,-99999999999999)  <> Coalesce(?  ,-99999999999999)
OR Coalesce(orig.deposit_amt_qty_trans_rand_1w  ,-99999999999999)  <> Coalesce(?  ,-99999999999999)
OR Coalesce(orig.price_ssq_days_qty_past_3m     ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.price_ssq_qty_trans_past_3m    ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.price_ssq_qty_trans_randm_1w   ,-99999999999999)  <> Coalesce(?   ,-99999999999999)
OR Coalesce(orig.susp_qty_trans_past_3mth_mc    ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.susp_qty_trans_random_1w_mc    ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.deposit_qty_total_past_3mth    ,-99999999999999)  <> Coalesce(?    ,-99999999999999)
OR Coalesce(orig.price_series_qty_past_3m       ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.ret_qty_store_same_rec_past_3m ,-99999999999999)  <> Coalesce(? ,-99999999999999)
OR Coalesce(orig.ret_qty_not_authorised_past_3m ,-99999999999999)  <> Coalesce(? ,-99999999999999)
OR Coalesce(orig.return_freq_same_checker       ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.return_no_receipt_qty          ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.return_many_itm_qty            ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR Coalesce(orig.plus_days                      ,-99999999999999)  <> Coalesce(?       ,-99999999999999)
OR orig.client_id IS NULL
)`,[I_VOID_QTY_TRANS_PAST_3MTH,I_VOID_QTY_TRANS_RANDOM_1W,I_SUSP_QTY_TRANS_PAST_3MTH,I_SUSP_QTY_TRANS_RANDOM_1W,I_RETURN_QTY_TRANS_PAST_3MTH,I_RETURN_FREQ_SAME_ITEM_IN_1W,I_RET_THRESHOLD_QTY_WEEK_IN_3M,I_RETURN_S2_QTY_TRANS_PAST_3M,I_RETURN_QTY_TRANS_RANDOM_1W,I_DEPOSIT_QTY_TRANS_PAST_3MTH,I_DEPOSIT_EAN_QTY_TRANS_PAST_3M,I_DEPOSIT_NOITM_QTY_TRANS_PAST_3M,I_DEPOSIT_NOITM_DAYS_QTY_PAST_3M,I_DEPOSIT_1ITM_QTY_TRANS_PAST_3M,I_DEPOSIT_1ITM_QTY_TRANS_RAND_1W,I_DEPOSIT_AMT_QTY_TRANS_PAST_3M,I_DEPOSIT_AMT_QTY_TRANS_RAND_1W,I_PRICE_SSQ_DAYS_QTY_PAST_3M,I_PRICE_SSQ_QTY_TRANS_PAST_3M,I_PRICE_SSQ_QTY_TRANS_RANDM_1W,I_SUSP_QTY_TRANS_PAST_3MTH_MC,I_SUSP_QTY_TRANS_RANDOM_1W_MC,I_DEPOSIT_QTY_TOTAL_PAST_3MTH,I_PRICE_SERIES_QTY_PAST_3M,I_RET_QTY_STORE_SAME_REC_PAST_3M,I_RET_QTY_NOT_AUTHORISED_PAST_3M,I_RETURN_FREQ_SAME_CHECKER,I_RETURN_NO_RECEIPT_QTY,I_RETURN_MANY_ITM_QTY,I_PLUS_DAYS,I_REQUESTING_USER,I_CLIENT_ID,I_VOID_QTY_TRANS_PAST_3MTH,I_VOID_QTY_TRANS_RANDOM_1W,I_SUSP_QTY_TRANS_PAST_3MTH,I_SUSP_QTY_TRANS_RANDOM_1W,I_RETURN_QTY_TRANS_PAST_3MTH,I_RETURN_FREQ_SAME_ITEM_IN_1W,I_RET_THRESHOLD_QTY_WEEK_IN_3M,I_RETURN_S2_QTY_TRANS_PAST_3M,I_RETURN_QTY_TRANS_RANDOM_1W,I_DEPOSIT_QTY_TRANS_PAST_3MTH,I_DEPOSIT_EAN_QTY_TRANS_PAST_3M,I_DEPOSIT_NOITM_QTY_TRANS_PAST_3M,I_DEPOSIT_NOITM_DAYS_QTY_PAST_3M,I_DEPOSIT_1ITM_QTY_TRANS_PAST_3M,I_DEPOSIT_1ITM_QTY_TRANS_RAND_1W,I_DEPOSIT_AMT_QTY_TRANS_PAST_3M,I_DEPOSIT_AMT_QTY_TRANS_RAND_1W,I_PRICE_SSQ_DAYS_QTY_PAST_3M,I_PRICE_SSQ_QTY_TRANS_PAST_3M,I_PRICE_SSQ_QTY_TRANS_RANDM_1W,I_SUSP_QTY_TRANS_PAST_3MTH_MC,I_SUSP_QTY_TRANS_RANDOM_1W_MC,I_DEPOSIT_QTY_TOTAL_PAST_3MTH,I_PRICE_SERIES_QTY_PAST_3M,I_RET_QTY_STORE_SAME_REC_PAST_3M,I_RET_QTY_NOT_AUTHORISED_PAST_3M,I_RETURN_FREQ_SAME_CHECKER,I_RETURN_NO_RECEIPT_QTY,I_RETURN_MANY_ITM_QTY,I_PLUS_DAYS]
);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;