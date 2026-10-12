CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_EXCHANGE_RATE_1 (
src_curr_cd COMMENT 'The code according to ISO-4217, identifying the currency that is to be converted.'
,tgt_curr_cd COMMENT 'The code according to ISO-4217, identifying the currency into which the source currency is to be converted.'
,exchange_rate_type_cd COMMENT 'The code identifying the way in which one currency can be converted into another.'
,active_from_dt COMMENT 'The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).'
,active_to_dt COMMENT 'The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).'
,active_fg COMMENT 'An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt.'
,bus_year COMMENT 'Some exchange rates are considered valid for an entire business year. If this is the case, this is the business year.'
,exchange_rate COMMENT 'The factor by which the amount in the source currency (from_curr_cd) needs to be multiplied, so that the result is in the target currency (to_curr_cd).'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'Currency exchange rates. For a given pair of currencies there might be several exchange rate types. Some of them might be valid for an entire business year.' AS SELECT
main.src_curr_cd AS src_curr_cd
,main.tgt_curr_cd AS tgt_curr_cd
,main.exchange_rate_type_cd AS exchange_rate_type_cd
,main.active_from_dt AS active_from_dt
,main.active_to_dt AS active_to_dt
,main.active_fg AS active_fg
,main.bus_year AS bus_year
,main.exchange_rate AS exchange_rate
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_FACT_EXCHANGE_RATE_1 main;