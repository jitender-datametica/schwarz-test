--==============================================================
-- Table: in_l_mass_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_mass_typ_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_mass_typ_1 (
in_massnahme_typ_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID eins Massnahmetyps'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='IMS - Lookup Tabelle der Massnahmentypen aus SAP Industrie zco_mass_type');