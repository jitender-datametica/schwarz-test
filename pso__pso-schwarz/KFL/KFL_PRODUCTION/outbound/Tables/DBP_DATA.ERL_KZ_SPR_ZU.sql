--==============================================================
-- Table: erl_kz_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: erl_kz_spr_zu
   generated from Powerdesigner on Freitag, 20. Januar 2023 16:50:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.erl_kz_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
erl_kz STRING(1) NOT NULL OPTIONS(description='Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
erl_kz_bez STRING(50) NOT NULL
OPTIONS(description='Bezeichnungen der Erledigtkennzeichen aus SAP; Quelle: Datenelement zrs_rv_erlkz'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, erl_kz, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprach-Zuordnung Tabelle für Erledigtkennzeichen AS Prozess aus SAP; Quelle: zrs_rvdata - Initialbeladung anhand Datei, keine Versorgung aus SAP.');