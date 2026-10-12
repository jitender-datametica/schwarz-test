--==============================================================
-- Table: immo_mo_nutzung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mo_nutzung_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mo_nutzung_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
mo_nutzung_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Code der Nutzungsart Mietobjekt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mo_nutzung_bez STRING(20) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Bezeichnung der Nutzungsart Mietobjekt (Handels-, Gewerbefläche oder Wohnungen)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mo_nutzung_id, spr_id) NOT ENFORCED
)
OPTIONS(description='IMMO - Lookup Tabelle Nutzung (Verwendung) Mitobjekt (Handesl-, Gewerbefläche, Wohnungen) - SAP REFX - TIV01');