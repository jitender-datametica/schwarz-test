CREATE OR REPLACE VIEW kfl_production_dbp_view.v_psp_status_spr_zu (mandant_id OPTIONS(description='Mandant im DWH'),
spr_id OPTIONS(description='ID der Sprache.'), psp_status_id
OPTIONS(description='ID des Status der PSP_NR / des Buchungselementes.'), psp_status_bez
OPTIONS(description='Sprachabhängige Bezeichnung des PSP Status.'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen des Status der PSP_NR / des Buchungselementes.`) AS
SELECT mandant_id,
 spr_id,
 psp_status_id,
 psp_status_bez
FROM kfl_production_dbp_data.psp_status_spr_zu;