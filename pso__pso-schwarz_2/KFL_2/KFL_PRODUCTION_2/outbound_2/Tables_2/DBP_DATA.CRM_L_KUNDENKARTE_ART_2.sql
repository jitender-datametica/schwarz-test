--==============================================================
-- Table: crm_l_kundenkarte_art_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_kundenkarte_art_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_kundenkarte_art_2 (
crm_kundenkarte_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Art_2 der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_kundenkarte_art_id) NOT ENFORCED
) OPTIONS(description='EK-KUN - MSDynamicsCRM - Lookup Art_2 der Kundenkarte (Entitaet "arvato_loyaltycard")');