CREATE OR REPLACE VIEW kfl_production_dbp_view.v_temperatur_spr_zu (mandant_id OPTIONS(description='Mandant im DWH'),
temperatur_id OPTIONS(description='Kennzeichen für den Temperaturbereich, z.Bsp. 3'), spr_id
OPTIONS(description='ID der Sprache'), temperatur_bez
OPTIONS(description='Bezeichnung für den Temperaturbereich, z.Bsp. Gefrierware')) AS SELECT mandant_id,
 temperatur_id,
 spr_id,
 temperatur_bez
FROM kfl_production_dbp_data.temperatur_spr_zu;