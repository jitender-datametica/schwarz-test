CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kundenkarte_art_spr_zu_1 (crm_kundenkarte_art_id
OPTIONS(description='Art_1 der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.'),
spr_id OPTIONS(description='ID der Sprache'), crm_kundenkarte_art_bez
OPTIONS(description='Bezeichnung des Kundenkartentyps.'))
OPTIONS(DESCRIPTION = `EK-KUN - COSMOSDB CRM - SPRACHZUORDNUNGSTABELLE ZU ART_1 DER KUNDENKARTE.`) AS SELECT
 crm_kundenkarte_art_id,
 spr_id,
 crm_kundenkarte_art_bez
FROM kfl_production_dbp_data.crm_kundenkarte_art_spr_zu_1;