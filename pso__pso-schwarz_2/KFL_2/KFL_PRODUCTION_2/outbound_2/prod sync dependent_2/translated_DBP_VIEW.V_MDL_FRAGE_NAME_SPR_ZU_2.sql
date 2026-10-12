CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_frage_name_spr_zu_2 (frage_id, spr_id, frage_name_bez) AS SELECT
 frage_id,
 spr_id,
 frage_name_bez
FROM kfl_production_dbp_data.mdl_frage_name_spr_zu_2;