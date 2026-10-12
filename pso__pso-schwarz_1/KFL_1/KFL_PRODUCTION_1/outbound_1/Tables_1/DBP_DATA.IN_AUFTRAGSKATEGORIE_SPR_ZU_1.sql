--==============================================================
-- Table: in_auftragskategorie_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftragskategorie_spr_zu_1
   generated from Powerdesigner on Freitag, 31. Mai 2024 08:59:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_auftragskategorie_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
auftragskategorie_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'),
auftragskategorie_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung für Equipment in Großbuchstaben'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, auftragskategorie_id, spr_id) NOT ENFORCED
)
OPTIONS(description='LIS - Auftragskategoriekennzeichen Instandhaltung - Translations table for types of service and maintenance orders for industrial equipment and plants.');