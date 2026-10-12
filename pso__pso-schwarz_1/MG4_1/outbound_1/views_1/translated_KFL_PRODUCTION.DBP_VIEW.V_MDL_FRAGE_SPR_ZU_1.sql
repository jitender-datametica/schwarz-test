CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_frage_spr_zu_1 (frage_id, spr_id, frage_bez) AS SELECT frage_id,
 spr_id,
 frage_bez
FROM kfl_production_dbp_data.mdl_frage_spr_zu_1;