create 
or replace
procedure P_LEW_MART_ANALYTICS.P_PVT_FORECAST
(I_PROC STRING
    , I_START_DT DATE
, I_END_DT DATE
, I_PRICE_RETAIL_NEW FLOAT
, I_PRICE_RETAIL_OLD FLOAT
, I_TV_FG FLOAT
, I_FLYER_ID FLOAT
, I_SND_PLACEMENT_FG FLOAT
, I_COUNTRYWIDE_FG FLOAT
, I_RADIO_FG FLOAT
, I_PRICE_RETAIL_NEW_EDITED FLOAT
, I_PIECE_FORECAST_QTY FLOAT
, I_PIECE_FORECAST_QTY_EDITED FLOAT
, I_DISCOUNT_REL_PV FLOAT
, I_BASELINE_NET_VAL FLOAT
, I_PERIOD_FORECAST_DESC STRING
, I_CLIENT_ID FLOAT
, I_USER_ID STRING
, I_WEEK_ID FLOAT
, I_ORIG_ITEM_NR FLOAT
, I_PK_ID FLOAT
, I_NOTE STRING
, I_COMMENT_STRNG STRING
, I_REGION_ID FLOAT
)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS CALLER
   AS
   $$
 	{
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
   // Add predictive data to planed items
   if (I_PROC == `predictionToPlan`) {
      // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
      EXEC(`MERGE INTO P_LEW_MART_ANALYTICS.T_PVT_SELECTION AS SELECTION USING
(SELECT
pk_id
FROM P_LEW_MART_ANALYTICS.T_PVT_RETRO
           WHERE client_id = ?
           AND orig_item_nr = ?
       ) AS retro ON selection.client_id = ?
AND selection.pk_id = retro.pk_id
AND selection.week_id = ?
AND selection.user_id = ?
WHEN MATCHED THEN UPDATE
SET
      start_dt = ?
    , end_dt = ?
    , price_retail_new = ?
    , price_retail_old = ?
    , tv_fg = ?
    , flyer_id = ?
    , snd_placement_fg = ?
    , countrywide_fg = ?
    , radio_fg = ?
    , price_retail_new_edited = ?
    , piece_forecast_qty = ?
    , piece_forecast_qty_edited = ?
    , discount_rel_pv = ?
    , baseline_net_val = ?
    , period_forecast_desc = ?
    , note = ?
    , comment_strng = ?
    , region_id = ?`,[I_CLIENT_ID,I_ORIG_ITEM_NR,I_CLIENT_ID,I_WEEK_ID,I_USER_ID,I_START_DT.toISOString(),I_END_DT.toISOString(),I_PRICE_RETAIL_NEW,I_PRICE_RETAIL_OLD,I_TV_FG,I_FLYER_ID,I_SND_PLACEMENT_FG,I_COUNTRYWIDE_FG,I_RADIO_FG,I_PRICE_RETAIL_NEW_EDITED,I_PIECE_FORECAST_QTY,I_PIECE_FORECAST_QTY_EDITED,I_DISCOUNT_REL_PV,I_BASELINE_NET_VAL,I_PERIOD_FORECAST_DESC,I_NOTE,I_COMMENT_STRNG,I_REGION_ID]);
   }
   // Manual edit the forecast data
   if (I_PROC == `edtPredInPlan`) {
      // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
      EXEC(`UPDATE P_LEW_MART_ANALYTICS.T_PVT_SELECTION SET
start_dt = ?
, end_dt = ?
, price_retail_new = ?
, price_retail_old = ?
, tv_fg = ?
, flyer_id = ?
, snd_placement_fg = ?
, countrywide_fg = ?
, radio_fg = ?
, price_retail_new_edited = ?
, piece_forecast_qty = ?
, piece_forecast_qty_edited = ?
, discount_rel_pv = ?
, baseline_net_val = ?
, period_forecast_desc = ?
, note = ?
, comment_strng = ?
, region_id = ?
WHERE client_id = ?
AND pk_id = ?
AND week_id = ?
AND user_id = ?`,[I_START_DT.toISOString(),I_END_DT.toISOString(),I_PRICE_RETAIL_NEW,I_PRICE_RETAIL_OLD,I_TV_FG,I_FLYER_ID,I_SND_PLACEMENT_FG,I_COUNTRYWIDE_FG,I_RADIO_FG,I_PRICE_RETAIL_NEW_EDITED,I_PIECE_FORECAST_QTY,I_PIECE_FORECAST_QTY_EDITED,I_DISCOUNT_REL_PV,I_BASELINE_NET_VAL,I_PERIOD_FORECAST_DESC,I_NOTE,I_COMMENT_STRNG,I_REGION_ID,I_CLIENT_ID,I_PK_ID,I_WEEK_ID,I_USER_ID]);
   }
}
$$;