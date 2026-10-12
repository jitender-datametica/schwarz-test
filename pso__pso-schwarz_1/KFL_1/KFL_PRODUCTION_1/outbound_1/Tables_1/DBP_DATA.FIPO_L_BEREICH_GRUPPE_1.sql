--==============================================================
-- Table: fipo_l_bereich_gruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_bereich_gruppe_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_bereich_gruppe_1 (
fipo_bereich_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID der FIPO-Bereichsgruppe aus dem Quellfeld bgr_id bzw. für Bereiche ohne Gruppe_1 im DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_bereich_gruppe_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookuptabelle der FIPO-Bereichsgruppen');