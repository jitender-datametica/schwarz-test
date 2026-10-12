CREATE OR REPLACE VIEW kfl_production_dbp_view.v_projekt_status_spr_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
spr_id OPTIONS(description='ID der Sprache'), projekt_status_id OPTIONS(description='ID des Projektstatus.'),
projekt_status_bez OPTIONS(description='Sprachabhängige Bezeichnung des Projektstatus.'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Projektstatus.`) AS SELECT mandant_id,
 spr_id,
 projekt_status_id,
 projekt_status_bez
FROM kfl_production_dbp_data.projekt_status_spr_zu_2;