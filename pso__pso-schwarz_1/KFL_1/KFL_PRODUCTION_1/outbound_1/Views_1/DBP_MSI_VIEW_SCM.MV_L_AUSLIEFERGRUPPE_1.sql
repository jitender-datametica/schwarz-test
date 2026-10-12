CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_ausliefergruppe_1 (auslieferungsgruppe_id, mandant_id) AS
SELECT auslieferungsgruppe_id,
 mandant_id
FROM (SELECT mandant_id,
    auslieferungsgruppe_id
   FROM kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_1
   UNION DISTINCT
   SELECT mandant_id,
    ausliefergruppe_id
   FROM kfl_production_dbp_view.v_ts_wbs_ausliefergruppe_1) AS a;