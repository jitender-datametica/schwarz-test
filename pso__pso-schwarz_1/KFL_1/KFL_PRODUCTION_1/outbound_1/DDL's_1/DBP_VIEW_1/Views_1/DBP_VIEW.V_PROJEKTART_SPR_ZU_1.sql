CREATE OR REPLACE VIEW kfl_production_dbp_view.v_projektart_spr_zu_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
spr_id OPTIONS(description='ID der Sprache'), projektart_cd
OPTIONS(description='Eindeutiger alphanumerischer Code der Projektart'), projektart_bez
OPTIONS(description='Sprachabhängige Bezeichnung der Projektart.'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Projektarten.`) AS SELECT mandant_id,
 spr_id,
 projektart_cd,
 projektart_bez
FROM kfl_production_dbp_data.projektart_spr_zu_1;