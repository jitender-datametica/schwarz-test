CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_frage_spr_zu AS SELECT teku_frage_id,
 spr_id,
 teku_frage_bez,
 teku_frage_bez_lang
FROM kfl_production_dbp_data.teku_frage_spr_zu;