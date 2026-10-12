-- 2025-03-06,AP0205147, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_qa_deklarationsfehler_2 (mandant_id,
qa_deklarationsfehler_id, aktiv_fg, pflanzen_fg) AS SELECT mandant_id,
 qa_deklarationsfehler_id,
 aktiv_fg,
 pflanzen_fg
FROM kfl_production_dbp_view.v_l_qa_deklarationsfehler_2
UNION DISTINCT
SELECT mandant_id,
 '-1',
 -1,
 -1
FROM kfl_production_dbp_view.v_mandant_2 AS V01;