CREATE OR REPLACE VIEW kfl_production_dbp_view.v_projektrolle_spr_zu (mandant_id OPTIONS(description='Mandant im DWH'),
spr_id OPTIONS(description='ID der Sprache'), projektrolle_cd OPTIONS(description='Eindeutiger Code der Projektrolle.'),
projektrolle_bez OPTIONS(description='Sprachabhängige Bezeichnung der Projektrolle.'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Projektrollen.`) AS SELECT mandant_id,
 spr_id,
 projektrolle_cd,
 projektrolle_bez
FROM kfl_production_dbp_data.projektrolle_spr_zu;