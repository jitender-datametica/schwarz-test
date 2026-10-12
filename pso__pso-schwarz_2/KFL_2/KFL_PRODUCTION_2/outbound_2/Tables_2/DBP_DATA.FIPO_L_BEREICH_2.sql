--==============================================================
-- Table: fipo_l_bereich_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_bereich_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_bereich_2 (
fipo_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id'),
fipo_pruef_modul_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id'),
fipo_bereich_nr BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Nummer eines FIPO-Bereichs aus dem Quellfeld ber_nr'),
fipo_bereich_gruppe_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID der FIPO-Bereichsgruppe aus dem Quellfeld bgr_id bzw. für Bereiche ohne Gruppe_2 im DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_bereich_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookuptabelle der FIPO-Bereiche');