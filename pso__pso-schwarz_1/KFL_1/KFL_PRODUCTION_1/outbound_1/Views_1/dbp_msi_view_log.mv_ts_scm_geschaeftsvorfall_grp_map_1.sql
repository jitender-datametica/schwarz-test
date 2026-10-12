CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ts_scm_geschaeftsvorfall_grp_map_1 (geschaeftsvorfall_id, ewm_fg
, scm_gv_grp_id, scm_gv_prozess_id) AS SELECT geschaeftsvorfall_id,
 ewm_fg,
 scm_gv_grp_id,
 ROUND(CAST(scm_gv_prozess_id AS BIGNUMERIC), 0) AS scm_gv_prozess_id
FROM kfl_production_dbp_view.v_ts_scm_geschaeftsvorfall_grp_map_1
UNION ALL
SELECT '-1',
 ewm_fg,
 '-1',
 - 1
FROM kfl_production_dbp_view.v_ts_scm_geschaeftsvorfall_grp_map_1
GROUP BY ewm_fg
UNION ALL
SELECT DISTINCT CAST(ewm_gv_id AS STRING) AS v01_ewm_gv_id,
 1 AS ewm_fg,
 '-1',
 - 1
FROM kfl_production_dbp_view.v_ewm_geschaeftsvorfall_spr_zu_1 AS V01
WHERE ewm_gv_id NOT IN (SELECT ROUND(CAST(geschaeftsvorfall_id AS BIGNUMERIC), 0) AS geschaeftsvorfall_id
   FROM kfl_production_dbp_view.v_ts_scm_geschaeftsvorfall_grp_map_1
   WHERE ewm_fg = 1);