CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_REL_EXCHANGE_RATE_TYPE_BUS_YEAR_1(
exchange_rate_type_cd COMMENT 'The code identifying the way in which one currency can be converted into another.'
,exchange_bus_year COMMENT 'Some exchange rates are considered valid for an entire business year. If this is the case, this is the business year.'
,exchange_rate_type_descr COMMENT 'A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.'
,exchange_rate_type_descr_de COMMENT 'A textual description for the way in which one currency can be converted into another expressed in German.'
,exchange_rate_type_descr_en COMMENT 'A textual description for the way in which one currency can be converted into another expressed in English.'
,rel_exchange_rate_type_descr COMMENT 'A textual description combined with bus. year for the way in which one currency can be converted into another expressed in group language, i.e. in German.'
,rel_exchange_rate_type_descr_de COMMENT 'A textual description combined with bus. year for the way in which one currency can be converted into another expressed in German.'
,rel_exchange_rate_type_descr_en COMMENT 'A textual description combined with bus. yearfor the way in which one currency can be converted into another expressed in English.'
) COMMENT='Currency exchange rates. For a given pair of currencies there might be several exchange rate types. Some of them might be valid for an entire business year.' AS SELECT  
 main.exchange_rate_type_cd AS exchange_rate_type_cd
,main.bus_year AS exchange_bus_year
,rate.exchange_rate_type_descr AS exchange_rate_type_descr 
,rate.exchange_rate_type_descr_de AS exchange_rate_type_descr_de
,rate.exchange_rate_type_descr_en AS exchange_rate_type_descr_en
,main.bus_year::VARCHAR(4)||' '|| rate.exchange_rate_type_descr AS rel_exchange_rate_type_descr
,main.bus_year::VARCHAR(4)||' '|| rate.exchange_rate_type_descr_de AS rel_exchange_rate_type_descr_de
,main.bus_year::VARCHAR(4)||' '|| rate.exchange_rate_type_descr_en AS rel_exchange_rate_type_descr_en
FROM CORE_DIM.T_FACT_EXCHANGE_RATE_1 main 
INNER JOIN CORE_DIM.T_DIM_EXCHANGE_RATE_TYPE_1 rate
ON main.exchange_rate_type_cd = rate.exchange_rate_type_cd
GROUP BY
main.exchange_rate_type_cd
,main.bus_year
,rate.exchange_rate_type_descr
,rate.exchange_rate_type_descr_de
,rate.exchange_rate_type_descr_en;