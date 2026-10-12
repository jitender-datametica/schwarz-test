CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rohstoff_blend_1 (rohstoff_blend_kfl_cd
OPTIONS(description='Kaufland interne Code des Blends.'), rohstoff_blend_kfl_name
OPTIONS(description='Kaufland interne Name des Blends.'))
OPTIONS(DESCRIPTION = `LOOKUP TABELLE FÜR KAUFLAND DEFINIERTE BLEND : GEMISCHTES MINERALÖLPRODUKT, DAS AUS VERSCHIEDENE ROHSTOFFE ENTSTEHT.`)
AS SELECT rohstoff_blend_kfl_cd,
 rohstoff_blend_kfl_name
FROM kfl_production_dbp_data.l_rohstoff_blend_1;