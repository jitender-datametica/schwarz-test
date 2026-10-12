--==============================================================
-- Table: crm_kundenkarte_art_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kundenkarte_art_spr_zu_1
   generated from Powerdesigner on Dienstag, 5. August 2025 17:32:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_kundenkarte_art_spr_zu_1 (
crm_kundenkarte_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Art_1 der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_kundenkarte_art_bez STRING(200) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Kundenkartentyps.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_kundenkarte_art_id, spr_id) NOT ENFORCED
) OPTIONS(description='EK-KUN - CosmosDB CRM - Sprachzuordnungstabelle zu Art_1 der Kundenkarte.');