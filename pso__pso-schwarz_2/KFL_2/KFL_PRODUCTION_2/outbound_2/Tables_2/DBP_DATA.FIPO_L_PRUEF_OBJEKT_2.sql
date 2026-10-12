--==============================================================
-- Table: fipo_l_pruef_objekt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_pruef_objekt_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_pruef_objekt_2 (
fipo_pruef_objekt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID eines Prüfobjekts aus dem Quellfeld pob_id'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
fipo_objekt_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des FIPO-Opbjekttyps aus dem Quellfeld obt_id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_pruef_objekt_id) NOT ENFORCED
) OPTIONS(description='FIPO - Tabelle der FIPO Pruefobjekte aus Quelle pruefobjekte');