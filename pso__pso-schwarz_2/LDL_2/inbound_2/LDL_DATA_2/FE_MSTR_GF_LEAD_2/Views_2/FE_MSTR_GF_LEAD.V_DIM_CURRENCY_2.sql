CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_CURRENCY_2 (
curr_cd COMMENT 'The code identifying the currency according to ISO-4217.'
,curr_name COMMENT 'The name for the currency in group language, i.e. in German.'
,curr_name_de COMMENT 'The name for the currency in german.'
,curr_name_en COMMENT 'The name for the currency in english.'
,used_in_stores_fg COMMENT 'An indicator showing, if this currency is used in a country_2 where the Schwarz Group operates any stores.'
,euro_exch_rate COMMENT 'The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)' AS SELECT
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