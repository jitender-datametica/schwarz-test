CREATE OR REPLACE PROCEDURE p_lew_mart_analytics.p_pvt_selection (I_PROC STRING
    , I_PK_ID FLOAT
    , I_CLIENT_ID FLOAT
    , I_USER_ID STRING
    , I_WEEK_ID FLOAT
    , I_START_DT DATE
, I_END_DT DATE
, I_PRICE_RETAIL_NEW FLOAT
, I_PRICE_RETAIL_OLD FLOAT
, I_COUNTRYWIDE_FG FLOAT
, I_SND_PLACEMENT_FG FLOAT
, I_FLYER_ID FLOAT
, I_RADIO_FG FLOAT
, I_TV_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   // INSERT
   if (I_PROC == `insert`) {
      var sql_stmt = `DELETE FROM p_lew_mart_analytics.t_pvt_selection_1
WHERE pk_id = ?
AND client_id = ?
AND user_id = ?
AND week_id IS NULL`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [I_PK_ID,I_CLIENT_ID,I_USER_ID]
      }).execute();
      var sql_stmt = `INSERT INTO p_lew_mart_analytics.t_pvt_selection_1 (
pk_id
, client_id
, user_id) VALUES (
?
, ?
, ?)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [I_PK_ID,I_CLIENT_ID,I_USER_ID]
      }).execute();
   }
   // UPDATE cw
   if (I_PROC == `updateKW`) {
      var sql_stmt = `DELETE FROM p_lew_mart_analytics.t_pvt_selection_1
WHERE client_id = ?
AND user_id = ?
AND week_id IS NULL
AND pk_id IN
(SELECT
pk_id
FROM p_lew_mart_analytics.t_pvt_selection_1
           WHERE client_id = ?
           AND user_id = ?
           AND week_id = ?
       )`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [I_CLIENT_ID,I_USER_ID,I_CLIENT_ID,I_USER_ID,I_WEEK_ID]
      }).execute();
      var sql_stmt = `UPDATE p_lew_mart_analytics.t_pvt_selection_1 SET week_id = ?
WHERE client_id = ?
AND user_id = ?
AND week_id IS NULL`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [I_WEEK_ID,I_CLIENT_ID,I_USER_ID]
      }).execute();
   }
   // DELETE item_1
   if (I_PROC == `deleteItem`) {
      var sql_stmt = `DELETE FROM p_lew_mart_analytics.t_pvt_selection_1
WHERE pk_id = ?
AND user_id = ?
AND week_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [I_PK_ID,I_USER_ID,I_WEEK_ID]
      }).execute();
   }
   // DELETE plan
   if (I_PROC == `deletePlanKW`) {
      var sql_stmt = `DELETE FROM p_lew_mart_analytics.t_pvt_selection_1
WHERE client_id = ?
AND user_id = ?
AND week_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [I_CLIENT_ID,I_USER_ID,I_WEEK_ID]
      }).execute();
   }
   // UPDATE plan attributes
   if (I_PROC == `updatePlanAttr`) {
      var sql_stmt = `UPDATE p_lew_mart_analytics.t_pvt_selection_1 SET
start_dt = ?
, end_dt = ?
, price_retail_new = ?
, price_retail_old = ?
, countrywide_fg = ?
, snd_placement_fg = ?
, flyer_id = ?
, radio_fg = ?
, tv_fg = ?
WHERE pk_id = ?
AND client_id = ?
AND user_id = ?
AND week_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [I_START_DT.toISOString(),I_END_DT.toISOString(),I_PRICE_RETAIL_NEW,I_PRICE_RETAIL_OLD,I_COUNTRYWIDE_FG,I_SND_PLACEMENT_FG,I_FLYER_ID,I_RADIO_FG,I_TV_FG,I_PK_ID,I_CLIENT_ID,I_USER_ID,I_WEEK_ID]
      }).execute();
   }
}
 
$$;