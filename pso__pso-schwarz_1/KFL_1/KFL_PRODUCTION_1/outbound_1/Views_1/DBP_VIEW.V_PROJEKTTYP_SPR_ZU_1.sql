CREATE OR REPLACE VIEW kfl_production_dbp_view.v_projekttyp_spr_zu_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
spr_id OPTIONS(description='ID der Sprache'), projekttyp_id OPTIONS(description='ID des Projekttyps'), projekttyp_bez
OPTIONS(description='Sprachabhängige Bezeichnung des Projekttyps'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Projekttypen.`) AS SELECT mandant_id,
 spr_id,
 projekttyp_id,
 projekttyp_bez
FROM kfl_production_dbp_data.projekttyp_spr_zu_1;