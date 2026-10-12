CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_rueckfuehrung_lt_grund_1 (mandant_id, transportation_unit_id,
kj_transportation_unit, tour_id, ruckfuhrung_fg) AS SELECT v01.mandant_id,
 v01.transportation_unit_id,
 v01.kj_transportation_unit,
 v02.tour_id,
  CASE
  WHEN v02.tour_id IS NOT NULL
  THEN '1'
  ELSE '0'
  END AS ruckfuhrung_fg
FROM (SELECT mandant_id,
   transportation_unit_id,
   kj_transportation_unit,
   dat_tour,
   SUM(menge_gefahrgut) AS menge_gefahrgut
  FROM kfl_production_dbp_view.v_transportation_unit_aktivitaet_1 AS V01
  WHERE aktivitaet_richtung_id = '2'
  GROUP BY mandant_id,
   transportation_unit_id,
   kj_transportation_unit,
   dat_tour) AS v01
 LEFT JOIN (SELECT mandant_id,
   tour_id,
   EXTRACT(YEAR FROM dat_buch) AS kj_transportation_unit
  FROM kfl_production_dbp_view.v_rueckfuehrung_lt_1
  GROUP BY mandant_id,
   tour_id,
   kj_transportation_unit) AS v02 ON v01.transportation_unit_id = v02.tour_id AND v01.mandant_id = v02.mandant_id AND
   v01.kj_transportation_unit = v02.kj_transportation_unit
WHERE v01.kj_transportation_unit >= EXTRACT(YEAR FROM CURRENT_DATE) - 2;