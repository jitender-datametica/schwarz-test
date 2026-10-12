CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_rueckfuehrung_lt_grund (mandant_id, tour_id, wup_id
, rueckfuehrung_wup_id, ruckfuhrung_fg) AS SELECT v1.mandant_id,
 v1.tour_id,
 v1.wup_id,
 v2.wup_id AS rueckfuehrung_wup_id,
  CASE
  WHEN v2.tour_id IS NOT NULL
  THEN '1'
  ELSE '0'
  END AS ruckfuhrung_fg
FROM (SELECT mandant_id,
   wup_id,
   tour_id,
   dat_tour
  FROM kfl_production_dbp_view.v_tour
  GROUP BY mandant_id,
   wup_id,
   tour_id,
   dat_tour) AS v1
 LEFT JOIN (SELECT mandant_id,
   tour_id,
   wup_id_lager,
   wup_id
  FROM kfl_production_dbp_view.v_rueckfuehrung_lt
  GROUP BY mandant_id,
   tour_id,
   wup_id,
   wup_id_lager) AS v2 ON v1.tour_id = v2.tour_id AND v1.mandant_id = v2.mandant_id AND v1.wup_id = v2.wup_id_lager;