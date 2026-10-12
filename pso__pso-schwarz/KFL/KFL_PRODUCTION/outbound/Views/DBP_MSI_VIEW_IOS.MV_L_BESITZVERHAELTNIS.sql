CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_besitzverhaeltnis AS SELECT besitzverhaeltnis_id
FROM kfl_production_dbp_view.v_l_besitzverhaeltnis AS V01
WHERE besitzverhaeltnis_id <> '  -'
UNION ALL
SELECT ' -1' AS besitzverhaeltnis_id
FROM kfl_production_dbp_view.v_l_besitzverhaeltnis AS V01
GROUP BY V01.besitzverhaeltnis_id;