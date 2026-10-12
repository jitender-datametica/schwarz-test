/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_agg_stk_str_productivity
#----------------------------------------------------------------------------
# History:
#  1.0    2021-07-10         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_stk_str_productivity (
client_id BIGNUMERIC OPTIONS(description='MIS Client ID'),
loc_sid_store_move_to BIGNUMERIC OPTIONS(description='enthält surrogate Key des Stores moved'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='Währung ISO Code'),
cy_week_partial_week_id BIGNUMERIC OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'),
cy_month BIGNUMERIC OPTIONS(description='Geschäftsjahr'),
busyear BIGNUMERIC OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'),
stk_str_prod_wday1 BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung am ersten Tag der Woche'),
stk_str_prod_wday2 BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung am zweiten Tag der Woche'),
stk_str_prod_wday3 BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung am dritten Tag der Woche'),
stk_str_prod_wday4 BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung am vierten Tag der Woche'),
stk_str_prod_wday5 BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung am fünften Tag der Woche'),
stk_str_prod_wday6 BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung am sechsten Tag der Woche'),
stk_str_prod_wday7 BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung am siebten Tag der Woche'),
stk_str_prod_wktd BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung wöchentlich'),
stk_str_prod_mtd BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung Monat bis zum Datum'),
stk_str_prod_bytd BIGNUMERIC(38,8) OPTIONS(description='Stueckleistung Jahr bis Datum'),
del_stk_plan_wktd BIGNUMERIC(38,8) OPTIONS(description='Delta plan wöchentlich'),
del_stk_plan_mtd BIGNUMERIC(38,8) OPTIONS(description='Delta plan Monat bis zum Datum'),
del_stk_plan_bytd BIGNUMERIC(38,8) OPTIONS(description='Delta plan Jahr bis Datum'),
del_stk_pep_wktd BIGNUMERIC(38,8) OPTIONS(description='Delta Pep wöchentlich'),
del_stk_pep_mtd BIGNUMERIC(38,8) OPTIONS(description='Delta Pep Monat bis zum Datum'),
del_stk_pep_bytd BIGNUMERIC(38,8) OPTIONS(description='Delta Pep Jahr bis Datum'),
prev1y_stk_str_prod_wktd BIGNUMERIC(38,8) OPTIONS(description='vorheriges Jahr Stueckleistung wöchentlich'),
prev1y_stk_str_prod_mtd BIGNUMERIC(38,8) OPTIONS(description='vorheriges Jahr Stueckleistung Monat bis zum Datum'),
prev1y_stk_str_prod_bytd BIGNUMERIC(38,8) OPTIONS(description='vorheriges Jahr Stueckleistung Jahr bis Datum')
) CLUSTER BY client_id, cy_month
OPTIONS(description='Stueckleistung (Piece Performance) for Filiale Cockpit');