--==============================================================
-- Table: immo_mo_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mo_status_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mo_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
mo_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Status_1 ID des Mietobjekt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mo_status_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung Status_1  Mietobjekt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mo_status_id, spr_id) NOT ENFORCED
)
OPTIONS(description='IMMO - Sprachabhängige Bezeichungen des Status_1 des Mietobjekts (z.B. Leerstand, vermietet, übergeben) - SAP REFX - ZRE_FL_STATUST');