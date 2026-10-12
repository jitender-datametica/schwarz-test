/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  01.08.2022    Bialek, Aleksander       Initial Version Part of Liefertreue Dashboard RPA Alternative solution. AD WI: 356666 (Main WI:350713)
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_LEAD.P_LFT_DASH_STOCK_DATA_PREP(PARAM1 TEXT, PARAM2 TEXT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
var param1=PARAM1
var param2=PARAM2
var stmnt0 = `
create or replace TEMPORARY TABLE P_LEW_MART_LEAD.V_STOCK_LOCATION_ITEM_TMP_CORE (
	CLIENT_ID NUMBER(38,0),
	LOC_SID NUMBER(38,0),
	ITEM_SID NUMBER(38,0),
	DWH_CAL_DT DATE,
	STOCK_CALC_QTY NUMBER(18,5),
	STOCK_INV_QTY NUMBER(18,5),
	STOCK_REAL_QTY NUMBER(18,5),
	STOCK_INV_DIFF_CALC NUMBER(18,5),
	PRICE NUMBER(18,5),
	PRICE_NET NUMBER(18,5),
	SRC_SPACE_SWITCH NUMBER(38,0),
	DWH_VALID_FROM DATE,
	DWH_VALID_TO DATE
);
`
var rs0 = snowflake.createStatement({sqlText : stmnt0}).execute();
var stmnt0 = `select COUNT(1) CNT
from p_lew_core_ac.v_cal_calendarday cal
where cal.cal_dt between ''param1'' and ''param2'';`
var stmnt0 = stmnt0.replace(/param1/g, param1 )
var stmnt0 = stmnt0.replace(/param2/g, param2 )
var rs0 = snowflake.createStatement({sqlText : stmnt0}).execute();
rs0.next();
var LOOP_END = rs0.getColumnValue(1);
var LOOP_ROW= 0
var stmnt = `WITH BASE_SQL AS(SELECT ''
INSERT INTO P_LEW_MART_LEAD.V_STOCK_LOCATION_ITEM_TMP_CORE
SELECT	
hist.client_id                                                                              AS client_id,	
hist.loc_sid                                                                                AS loc_sid,	
hist.item_sid                                                                               AS item_sid,	
Cast(x!xdat_paramx!x as date)                                                                  AS dwh_cal_dt,	
hist.calc_qty                                                                               AS stock_calc_qty,	
hist.inv_qty                                                                                AS stock_inv_qty,	
CASE WHEN ZeroIfNull(diff_qty_inv_calc) = 0	
THEN hist.calc_qty	
ELSE hist.inv_qty	
END                                                                                      AS stock_real_qty,	
hist.diff_qty_inv_calc                                                                      AS stock_inv_diff_calc,	
hist.price                                                                                  AS price,	
hist.price_net                                                                              AS price_net,	
src_space_switch,	
dwh_valid_from,	
dwh_valid_to	
FROM p_lew_core_ac.v_item_location_stock_hist AS hist	
WHERE Cast(x!xdat_paramx!x as date) BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to	;'' TXT),
DATES AS
(select cal.cal_dt from p_lew_core_ac.v_cal_calendarday cal
where cal.cal_dt between ''param1'' and ''param2''), t0
as (SELECT replace(txt,''x!x'','''''''') txt1 from base_sql)
select replace(txt1,''dat_param'',cal_dt)
FROM t0
CROSS JOIN dates
ORDER BY cal_dt;`
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
var rs = snowflake.createStatement({sqlText : stmnt}).execute();
while (LOOP_ROW<LOOP_END) {
rs.next();
stmnt1 = rs.getColumnValue(1);
var exec = snowflake.createStatement({sqlText : stmnt1}).execute();
var LOOP_ROW= LOOP_ROW+1
}
';