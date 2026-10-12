CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_protokoll_verladung_ewm_transportation_unit_1 (mandant_id,
transportation_unit_id, kj_transportation_unit, zeitstempel_scan_erste_palette_tour,
zeitstempel_scan_letzte_palette_tour, lagernummer_id, anz_sort) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 MIN(DATETIME(dat_scan, zeit_scan)) AS zeitstempel_scan_erste_palette_tour,
 MAX(DATETIME(dat_scan, zeit_scan)) AS zeitstempel_scan_letzte_palette_tour,
 lagernummer_id,
 COUNT(DISTINCT CASE
   WHEN lagersortiment_id = '5'
   THEN '1'
   WHEN lagersortiment_id = '7'
   THEN '2'
   ELSE lagersortiment_id
   END) AS anz_sort
FROM kfl_production_dbp_view.v_protokoll_verladung_ewm_1 AS PV_EWM
WHERE pruef_id = 133
GROUP BY mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 lagernummer_id;