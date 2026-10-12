CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_qa_deklarationsfehler_2 AS SELECT mandant_id,
 qa_deklarationsfehler_id,
 aktiv_fg,
 pflanzen_fg
FROM kfl_production_dbp_data.l_qa_deklarationsfehler_2;