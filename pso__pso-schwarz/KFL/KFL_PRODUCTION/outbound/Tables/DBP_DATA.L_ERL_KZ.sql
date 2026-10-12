--==============================================================
-- Table: l_erl_kz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_erl_kz
   generated from Powerdesigner on Freitag, 20. Januar 2023 16:48:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_erl_kz (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
erl_kz STRING(1) NOT NULL OPTIONS(description='Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, erl_kz) NOT ENFORCED
)
OPTIONS(description='Lookuptabelle Erledigtkennzeichen AS-Prozess; SAP-Quelle: zrs_rvdata - Initialbeladung anhand Datei, Keine Versorgung aus SAP.');