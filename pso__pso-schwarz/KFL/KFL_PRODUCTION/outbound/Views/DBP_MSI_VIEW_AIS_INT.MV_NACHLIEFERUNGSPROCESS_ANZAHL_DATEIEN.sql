CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_nachlieferungsprocess_anzahl_dateien AS SELECT SEQ AS
 anzahl_dateien
FROM UNNEST(GENERATE_ARRAY(0, 80)) AS SEQ
WHERE SEQ > 0
ORDER BY anzahl_dateien NULLS LAST;