-- 2022-04-27, AP0119377, SPEC0152763, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_plantour (mandant_id, wup_id, nb_id, plantour_id,
tour_id, trailer_fg, trailer_id, dat_trailer, zeit_trailer, ausfahrt_pforte_dt, zeitstempel_trailer) AS
-- TIMESTAMP_FROM_PARTS(tour.dat_ausfahrt_pforte,COALESCE(tour.zeit_ausfahrt_pforte,'00:00:00')) AS zeitstempel_ausfahrt_pforte

-- v02
 SELECT TOUR_PL.mandant_id,
 TOUR_PL.wup_id,
 TOUR_PL.nb_id,
 TOUR_PL.plantour_id,
 TOUR_PL.tour_id,
 TOUR_PL.trailer_fg,
 TOUR_PL.trailer_id,
 TOUR_PL.dat_trailer,
 TOUR_PL.zeit_trailer,
 tour_p_s.ausfahrt_pforte_dt,
  CASE
  WHEN TOUR_PL.zeit_trailer IS NULL
  THEN NULL
  ELSE DATETIME(TOUR_PL.dat_trailer, COALESCE(TOUR_PL.zeit_trailer, TIME '00:00:00'))
  END AS zeitstempel_trailer
FROM kfl_production_dbp_view.v_plantour AS TOUR_PL
 INNER JOIN kfl_production_dbp_view.v_tour AS TOUR ON TOUR_PL.mandant_id = TOUR.mandant_id AND TOUR_PL.tour_id = TOUR.tour_id
   
 LEFT JOIN (SELECT mandant_id,
   tour_id,
   MIN(CAST(REPLACE(CAST(dat_erfasst AS STRING) || ' ' || CAST(zeit_erfasst AS STRING), ',', ':') AS DATETIME)) AS
   ausfahrt_pforte_dt
  FROM kfl_production_dbp_view.v_tour_plombe_start
  WHERE plombe_vorgang_id = 'B'
   AND storno_fg = 0
   AND nb_id = -111
  GROUP BY mandant_id,
   tour_id) AS tour_p_s ON TOUR.mandant_id = tour_p_s.mandant_id AND TOUR.tour_id = tour_p_s.tour_id
WHERE TOUR.transportart_id IN ('Z001', 'ZF01', 'ZF02', 'ZF03') -- and  tour_pl.tour_id=26400292;