create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_CURRENCY_2(
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_NAME COMMENT 'The name for the currency in group language, i.e. in German.',
	CURR_NAME_DE COMMENT 'The name for the currency in german.',
	CURR_NAME_EN COMMENT 'The name for the currency in english.',
	USED_IN_STORES_FG COMMENT 'An indicator showing, if this currency is used in a country_2 where the Schwarz Group operates any stores.',
	EURO_EXCH_RATE COMMENT 'The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)'
 as SELECT
main.curr_cd AS curr_cd
,main.curr_name AS curr_name
,main.curr_name_de AS curr_name_de
,main.curr_name_en AS curr_name_en
,main.used_in_stores_fg AS used_in_stores_fg
,main.euro_exch_rate AS euro_exch_rate
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_CURRENCY_2 main 
WHERE  main.used_in_stores_fg = TRUE;