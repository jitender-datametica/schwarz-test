CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_qa_mangel_2 AS SELECT mandant_id,
 qa_mangel_id,
 pflanzen_fg,
 qa_prio,
 frischemangel_fg
FROM kfl_production_dbp_data.l_qa_mangel_2;