CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gewerk_spr_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'), spr_id
OPTIONS(description='ID der Sprache'), gewerk_id OPTIONS(description='ID eines Gewerks , z.Bsp 3 = Baukosten'),
gewerk_bez OPTIONS(description='Sprachabhängige Bezeichnung der Gewerke'))
OPTIONS(DESCRIPTION = `Tabelle für sprachabhängige Bezeichnungen der Gewerke.`) AS SELECT mandant_id,
 spr_id,
 gewerk_id,
 gewerk_bez
FROM kfl_production_dbp_data.gewerk_spr_zu_2;