--==============================================================
-- Table: flw_charge_art_objekt_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_charge_art_objekt_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_charge_art_objekt_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
objekt_nummer_id STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Objektnummer aus SAP Quelle INOB.CUOBJ'),
objekt_schluessel_id STRING(50) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Schlüssel des zu klassifizierenden Objektes aus SAP Quelle INOB.OBJEK'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Zuordnung einer internen Nummer zu einem bel. Objekt aus SAP P21 INOB_2');