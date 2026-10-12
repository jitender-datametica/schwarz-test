-- 2025-03-06,AP0205147, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_qa_mangel (mandant_id, qa_mangel_id,
pflanzen_fg, qa_prio) AS SELECT mandant_id,
 qa_mangel_id,
 pflanzen_fg,
 qa_prio
FROM kfl_production_dbp_view.v_l_qa_mangel
UNION DISTINCT
SELECT mandant_id,
 '-1',
 -1,
 -1
FROM kfl_production_dbp_view.v_mandant;