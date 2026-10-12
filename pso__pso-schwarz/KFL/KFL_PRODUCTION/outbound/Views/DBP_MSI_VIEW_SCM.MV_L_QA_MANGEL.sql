CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_qa_mangel (mandant_id, qa_mangel_id, pflanzen_fg, qa_prio)
AS SELECT mandant_id,
 qa_mangel_id,
 pflanzen_fg,
 qa_prio
FROM kfl_production_dbp_view.v_l_qa_mangel
UNION DISTINCT
SELECT mandant_id,
 '-1',
 - 1,
 - 1
FROM kfl_production_dbp_view.v_mandant;