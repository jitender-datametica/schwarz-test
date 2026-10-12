CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_auslieferungsgruppe_2 (auslieferungsgruppe_id) AS SELECT
 auslieferungsgruppe_id
FROM ((SELECT auslieferungsgruppe_id
    FROM kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_2
    WHERE dat_bis = DATE '9999-12-31'
    GROUP BY auslieferungsgruppe_id
    UNION DISTINCT
    SELECT auslieferungsgruppe_id
    FROM kfl_production_dbp_view.v_art_auslieferungsgruppe_per_2
    WHERE dat_bis = DATE '9999-12-31'
    GROUP BY auslieferungsgruppe_id)
   UNION DISTINCT
   SELECT '-1' AS auslieferungsgruppe_id
   FROM kfl_production_dbp_view.v_art_auslieferungsgruppe_per_2) AS t6;