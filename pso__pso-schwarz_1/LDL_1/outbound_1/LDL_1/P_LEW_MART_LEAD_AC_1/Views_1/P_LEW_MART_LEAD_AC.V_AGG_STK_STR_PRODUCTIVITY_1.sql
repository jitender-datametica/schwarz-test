/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view p_LEW_MART_LEAD_AC.V_AGG_STK_STR_PRODUCTIVITY_1
#----------------------------------------------------------------------------
# History:
#  1.0    2021-07-10         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_stk_str_productivity_1 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_store_move_to OPTIONS(description='enthält surrogate Key des Stores moved'), currency_iso_cd
OPTIONS(description='Währung ISO Code'), cy_week_partial_week_id
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'), cy_month OPTIONS(description='Geschäftsjahr'),
busyear OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), stk_str_prod_wday1
OPTIONS(description='Stueckleistung am ersten Tag_1 der Woche_1'), stk_str_prod_wday2
OPTIONS(description='Stueckleistung am zweiten Tag_1 der Woche_1'), stk_str_prod_wday3
OPTIONS(description='Stueckleistung am dritten Tag_1 der Woche_1'), stk_str_prod_wday4
OPTIONS(description='Stueckleistung am vierten Tag_1 der Woche_1'), stk_str_prod_wday5
OPTIONS(description='Stueckleistung am fünften Tag_1 der Woche_1'), stk_str_prod_wday6
OPTIONS(description='Stueckleistung am sechsten Tag_1 der Woche_1'), stk_str_prod_wday7
OPTIONS(description='Stueckleistung am siebten Tag_1 der Woche_1'), stk_str_prod_wktd
OPTIONS(description='Stueckleistung wöchentlich'), stk_str_prod_mtd
OPTIONS(description='Stueckleistung Monat_1 bis zum Datum'), stk_str_prod_bytd
OPTIONS(description='Stueckleistung Jahr bis Datum'), del_stk_plan_wktd OPTIONS(description='Delta plan wöchentlich'),
del_stk_plan_mtd OPTIONS(description='Delta plan Monat_1 bis zum Datum'), del_stk_plan_bytd
OPTIONS(description='Delta plan Jahr bis Datum'), del_stk_pep_wktd OPTIONS(description='Delta Pep wöchentlich'),
del_stk_pep_mtd OPTIONS(description='Delta Pep Monat_1 bis zum Datum'), del_stk_pep_bytd
OPTIONS(description='Delta Pep Jahr bis Datum'), prev1y_stk_str_prod_wktd
OPTIONS(description='vorheriges Jahr Stueckleistung wöchentlich'), prev1y_stk_str_prod_mtd
OPTIONS(description='vorheriges Jahr Stueckleistung Monat_1 bis zum Datum'), prev1y_stk_str_prod_bytd
OPTIONS(description='vorheriges Jahr Stueckleistung Jahr bis Datum'))
OPTIONS(DESCRIPTION = `STUECKLEISTUNG (PIECE PERFORMANCE) FOR FILIALE COCKPIT`) AS SELECT client_id,
 loc_sid_store_move_to,
 currency_iso_cd,
 cy_week_partial_week_id,
 cy_month,
 busyear,
 stk_str_prod_wday1,
 stk_str_prod_wday2,
 stk_str_prod_wday3,
 stk_str_prod_wday4,
 stk_str_prod_wday5,
 stk_str_prod_wday6,
 stk_str_prod_wday7,
 stk_str_prod_wktd,
 stk_str_prod_mtd,
 stk_str_prod_bytd,
 del_stk_plan_wktd,
 del_stk_plan_mtd,
 del_stk_plan_bytd,
 del_stk_pep_wktd,
 del_stk_pep_mtd,
 del_stk_pep_bytd,
 prev1y_stk_str_prod_wktd,
 prev1y_stk_str_prod_mtd,
 prev1y_stk_str_prod_bytd
FROM ldl_p_lew_mart_lead.t_agg_stk_str_productivity_1;