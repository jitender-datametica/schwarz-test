-- 2022-05-12,AP0128635, SPEC0151986, removing mandant_id, dknop
 -- 2022-03-21,AP0101988, SPEC0121842, initial, dknop

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_l_auslieferungsgruppe (auslieferungsgruppe_id) AS
-- dummy record!
 SELECT auslieferungsgruppe_id
FROM (SELECT auslieferungsgruppe_id
   FROM kfl_production_dbp_view.v_wg_auslieferungsgruppe_per
   WHERE dat_bis = DATE '9999-12-31'
   GROUP BY auslieferungsgruppe_id
   UNION DISTINCT
   (SELECT auslieferungsgruppe_id
    FROM kfl_production_dbp_view.v_art_auslieferungsgruppe_per
    WHERE dat_bis = DATE '9999-12-31'
    GROUP BY auslieferungsgruppe_id
    UNION DISTINCT
    SELECT '-1' AS auslieferungsgruppe_id
    FROM kfl_production_dbp_view.v_art_auslieferungsgruppe_per)) AS t6;