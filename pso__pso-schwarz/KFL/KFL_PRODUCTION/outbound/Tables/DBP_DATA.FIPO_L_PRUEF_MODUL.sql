--==============================================================
-- Table: fipo_l_pruef_modul
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_pruef_modul
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_pruef_modul (
fipo_pruef_modul_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id'),
fipo_objekt_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des FIPO-Opbjekttyps aus dem Quellfeld obt_id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_pruef_modul_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookup Tabelle der Prüfmodule');