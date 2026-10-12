CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_l_frage AS SELECT frage_id,
 mdl_frage_id,
 hauptfrage_fg
FROM kfl_production_dbp_data.mdl_l_frage;