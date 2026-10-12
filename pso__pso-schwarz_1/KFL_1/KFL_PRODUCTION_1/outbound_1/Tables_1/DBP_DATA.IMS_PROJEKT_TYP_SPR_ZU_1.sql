--==============================================================
-- Table: ims_projekt_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_projekt_typ_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_projekt_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
ims_projekt_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Projekttyp wird aus dem ersten Zeichen der fachlichen Projektid gebildet, z.Bsp B für Bau'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
ims_projekt_typ_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Projekttyps, z.Bsp. Instandsetzung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMS - Sprachabhängige Bezeichnung der Projekttypen. Nur initial gefüllt, keine Versorgung');