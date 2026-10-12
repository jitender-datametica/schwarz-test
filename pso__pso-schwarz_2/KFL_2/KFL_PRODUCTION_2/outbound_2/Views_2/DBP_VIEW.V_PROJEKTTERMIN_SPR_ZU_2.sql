CREATE OR REPLACE VIEW kfl_production_dbp_view.v_projekttermin_spr_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
spr_id OPTIONS(description='ID der Sprache'), projekttermin_cd OPTIONS(description='Code des Projekttermins.'),
projekttermin_bez OPTIONS(description='Sprachabhängige Bezeichnung des Projekttermins.'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Projekttermine.`) AS SELECT mandant_id,
 spr_id,
 projekttermin_cd,
 projekttermin_bez
FROM kfl_production_dbp_data.projekttermin_spr_zu_2;