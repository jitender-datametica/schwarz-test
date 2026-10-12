CREATE OR REPLACE VIEW kfl_production_dbp_view.v_projektphase_spr_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'),
spr_id OPTIONS(description='ID der Sprache.'), projektphase_id OPTIONS(description='ID der Projektphase.'),
projektphase_bez OPTIONS(description='Sprachabhängige Bezeichnung der Projektphase.'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Projektphasen.`) AS SELECT mandant_id,
 spr_id,
 projektphase_id,
 projektphase_bez
FROM kfl_production_dbp_data.projektphase_spr_zu_2;