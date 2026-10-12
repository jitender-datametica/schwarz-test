/* 2020-12-04  nwag2310 alte Version auf persitente Tabelle umgestellt
   SELECT
  --2020-04-30 bugfix switch artikelklasse/rohstoff_2
  t2.mandant_id,
   t2.art_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL001' THEN t0.art_attribut_id ELSE '-' END) AS art_gruppe_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL001' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_gruppe_bez,
   MAX(CASE WHEN t0.art_gruppe_id='FL003' THEN t0.art_attribut_id ELSE '-' END) AS art_klasse_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL003' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_klasse_bez,
   MAX(CASE WHEN t0.art_gruppe_id='FL002' THEN t0.art_attribut_id ELSE '-' END) AS art_rohstoff_id,
   MAX(CASE WHEN t0.art_gruppe_id='FL002' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_rohstoff_bez
   FROM dbp_view.v_art_2 t2
   LEFT JOIN dbp_view.v_art_gruppe_attribut_zu_2 t0
   ON t2.mandant_id=t0.mandant_id
   AND t2.art_id=t0.art_id
   LEFT JOIN dbp_view.v_art_attribut_spr_zu_2 t1_2
   ON t0.art_attribut_id=t1.art_attribut_id
   WHERE t2.loesch_id <> 'L'
   GROUP BY 1,2; */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_flw_artikelgr_2 (mandant_id, art_id, art_gruppe_id
, art_gruppe_bez, art_klasse_id, art_klasse_bez, art_rohstoff_id, art_rohstoff_bez) AS SELECT *
FROM kfl_production_dbp_view.v_art_art_gruppe_flw_2 AS V0;