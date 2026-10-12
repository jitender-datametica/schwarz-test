create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_REL_EXCHANGE_RATE_TYPE_BUS_YEAR(
	EXCHANGE_RATE_TYPE_CD COMMENT 'The code identifying the way in which one currency can be converted into another.',
	EXCHANGE_BUS_YEAR COMMENT 'Some exchange rates are considered valid for an entire business year. If this is the case, this is the business year.',
	EXCHANGE_RATE_TYPE_DESCR COMMENT 'A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.',
	EXCHANGE_RATE_TYPE_DESCR_DE COMMENT 'A textual description for the way in which one currency can be converted into another expressed in German.',
	EXCHANGE_RATE_TYPE_DESCR_EN COMMENT 'A textual description for the way in which one currency can be converted into another expressed in English.',
	REL_EXCHANGE_RATE_TYPE_DESCR COMMENT 'A textual description combined with bus. year for the way in which one currency can be converted into another expressed in group language, i.e. in German.',
	REL_EXCHANGE_RATE_TYPE_DESCR_DE COMMENT 'A textual description combined with bus. year for the way in which one currency can be converted into another expressed in German.',
	REL_EXCHANGE_RATE_TYPE_DESCR_EN COMMENT 'A textual description combined with bus. yearfor the way in which one currency can be converted into another expressed in English.'
) COMMENT='Currency exchange rates. For a given pair of currencies there might be several exchange rate types. Some of them might be valid for an entire business year.'
 as SELECT  
 main.exchange_rate_type_cd AS exchange_rate_type_cd
,main.bus_year AS exchange_bus_year
,rate.exchange_rate_type_descr AS exchange_rate_type_descr 
,rate.exchange_rate_type_descr_de AS exchange_rate_type_descr_de
,rate.exchange_rate_type_descr_en AS exchange_rate_type_descr_en
,main.bus_year::VARCHAR(4)||' '|| rate.exchange_rate_type_descr AS rel_exchange_rate_type_descr
,main.bus_year::VARCHAR(4)||' '|| rate.exchange_rate_type_descr_de AS rel_exchange_rate_type_descr_de
,main.bus_year::VARCHAR(4)||' '|| rate.exchange_rate_type_descr_en AS rel_exchange_rate_type_descr_en
FROM CORE_DIM.T_FACT_EXCHANGE_RATE main 
INNER JOIN CORE_DIM.T_DIM_EXCHANGE_RATE_TYPE rate
ON main.exchange_rate_type_cd = rate.exchange_rate_type_cd
GROUP BY
main.exchange_rate_type_cd
,main.bus_year
,rate.exchange_rate_type_descr
,rate.exchange_rate_type_descr_de
,rate.exchange_rate_type_descr_en;