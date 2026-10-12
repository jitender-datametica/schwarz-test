CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_qa_deklarationsfehler_1 (mandant_id, qa_deklarationsfehler_id
, aktiv_fg, pflanzen_fg) AS SELECT mandant_id,
 qa_deklarationsfehler_id,
 aktiv_fg,
 pflanzen_fg
FROM kfl_production_dbp_view.v_l_qa_deklarationsfehler_1
UNION DISTINCT
SELECT mandant_id,
 '-1',
 - 1,
 - 1
FROM kfl_production_dbp_view.v_mandant_1 AS V01;