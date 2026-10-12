CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_status_spr_zu_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
spr_id OPTIONS(description='ID der Sprache'), angebot_status_id OPTIONS(description='ID des Angebotsstatus'),
angebot_status_bez OPTIONS(description='Sprachabhängige Bezeichnung des Angebotsstatus.'))
OPTIONS(DESCRIPTION = `TABELLE FÜR SPRACHABHÄNGIGE BEZEICHNUNGEN DES ANGEBOTSSTATUS.`) AS SELECT mandant_id,
 spr_id,
 angebot_status_id,
 angebot_status_bez
FROM kfl_production_dbp_data.angebot_status_spr_zu_1;