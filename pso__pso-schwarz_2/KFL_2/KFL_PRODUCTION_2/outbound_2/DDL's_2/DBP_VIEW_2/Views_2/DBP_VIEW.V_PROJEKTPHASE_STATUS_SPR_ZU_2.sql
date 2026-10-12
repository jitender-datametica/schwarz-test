CREATE OR REPLACE VIEW kfl_production_dbp_view.v_projektphase_status_spr_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), spr_id OPTIONS(description='ID der Sprache'), projektphase_status_id
OPTIONS(description='ID des Status_2 der Projektphase.'), projektphase_status_bez
OPTIONS(description='Sprachabhängige Bezeichnung des Status_2 der Projektphase'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Status_2 der Projektphasen.`) AS SELECT mandant_id,
 spr_id,
 projektphase_status_id,
 projektphase_status_bez
FROM kfl_production_dbp_data.projektphase_status_spr_zu_2;