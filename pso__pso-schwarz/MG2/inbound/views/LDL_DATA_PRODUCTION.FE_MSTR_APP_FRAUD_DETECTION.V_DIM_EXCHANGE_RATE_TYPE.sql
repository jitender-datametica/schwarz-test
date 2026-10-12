create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_EXCHANGE_RATE_TYPE(
	EXCHANGE_RATE_TYPE_CD COMMENT 'The code identifying the way in which one currency can be converted into another.',
	EXCHANGE_RATE_TYPE_DESCR COMMENT 'A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.',
	EXCHANGE_RATE_TYPE_DESCR_DE COMMENT 'A textual description for the way in which one currency can be converted into another expressed in German.',
	EXCHANGE_RATE_TYPE_DESCR_EN COMMENT 'A textual description for the way in which one currency can be converted into another expressed in English.',
	ACTIVE_FOR_BUS_YEAR_FG COMMENT 'An indicator showing whether the related exchange rate is, in principle, active for an entire business year.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor dimension defines the ways in which one currency can be converted into another. E.g. Lidls reporting exchange rate, ECB rate, ...'
 as SELECT
main.exchange_rate_type_cd AS exchange_rate_type_cd
,main.exchange_rate_type_descr AS exchange_rate_type_descr
,main.exchange_rate_type_descr_de AS exchange_rate_type_descr_de
,main.exchange_rate_type_descr_en AS exchange_rate_type_descr_en
,main.active_for_bus_year_fg AS active_for_bus_year_fg
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_EXCHANGE_RATE_TYPE main;