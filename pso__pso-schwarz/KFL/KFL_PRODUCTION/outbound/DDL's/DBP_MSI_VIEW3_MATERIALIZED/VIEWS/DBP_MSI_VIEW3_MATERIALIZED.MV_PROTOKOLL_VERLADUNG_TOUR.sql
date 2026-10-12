-- AP0119377_SPEC0152763, dknop, removing lagernummer_id
 -- AP0119377_SPEC0152763, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_protokoll_verladung_tour (mandant_id, wup_id, nb_id
, tour_id, zeitstempel_scan_erste_palette_tour, zeitstempel_scan_letzte_palette_tour, anz_sort) AS SELECT PV.mandant_id
 ,
 PV.wup_id,
 PV.nb_id,
 PV.tour_id -- ,pv.lagernummer_id
 -- ,pv.lagernummer_id
,
 pv_agg.zeitstempel_scan_erste_palette_tour,
 pv_agg.zeitstempel_scan_letzte_palette_tour,
 pv_agg.anz_sort
FROM kfl_production_dbp_view.v_protokoll_verladung AS PV
 INNER JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   tour_id,
   COUNT(DISTINCT lagernummer_id) AS anz_sort,
   MIN(DATETIME(DATE(dat_scan), CAST(zeit_scan AS TIME))) AS zeitstempel_scan_erste_palette_tour,
   MAX(DATETIME(DATE(dat_scan), CAST(zeit_scan AS TIME))) AS zeitstempel_scan_letzte_palette_tour
  FROM kfl_production_dbp_view.v_protokoll_verladung
  WHERE pruef_id = '334'
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   tour_id) AS pv_agg ON PV.mandant_id = pv_agg.mandant_id AND PV.wup_id = pv_agg.wup_id AND PV.nb_id = pv_agg.nb_id AND
   PV.tour_id = pv_agg.tour_id -- where pv.tour_id=26400292

GROUP BY PV.mandant_id,
 PV.wup_id,
 PV.nb_id,
 PV.tour_id -- ,pv.lagernummer_id
 -- ,pv.lagernummer_id
,
 pv_agg.zeitstempel_scan_erste_palette_tour,
 pv_agg.zeitstempel_scan_letzte_palette_tour,
 pv_agg.anz_sort;