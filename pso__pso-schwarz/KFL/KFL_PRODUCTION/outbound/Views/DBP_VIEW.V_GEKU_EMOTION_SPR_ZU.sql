CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_emotion_spr_zu AS SELECT geku_emotion_id,
 spr_id,
 geku_emotion_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_emotion_spr_zu;