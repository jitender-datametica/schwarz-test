CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_EXCHANGE_RATE_TYPE_2 (
exchange_rate_type_cd COMMENT 'The code identifying the way in which one currency can be converted into another.'
,exchange_rate_type_descr COMMENT 'A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.'
,exchange_rate_type_descr_de COMMENT 'A textual description for the way in which one currency can be converted into another expressed in German.'
,exchange_rate_type_descr_en COMMENT 'A textual description for the way in which one currency can be converted into another expressed in English.'
,active_for_bus_year_fg COMMENT 'An indicator showing whether the related exchange rate is, in principle, active for an entire business year.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'This minor dimension defines the ways in which one currency can be converted into another. E.g. Lidls reporting exchange rate, ECB rate, ...' AS SELECT
main.exchange_rate_type_cd AS exchange_rate_type_cd
,main.exchange_rate_type_descr AS exchange_rate_type_descr
,main.exchange_rate_type_descr_de AS exchange_rate_type_descr_de
,main.exchange_rate_type_descr_en AS exchange_rate_type_descr_en
,main.active_for_bus_year_fg AS active_for_bus_year_fg
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_EXCHANGE_RATE_TYPE_2 main;