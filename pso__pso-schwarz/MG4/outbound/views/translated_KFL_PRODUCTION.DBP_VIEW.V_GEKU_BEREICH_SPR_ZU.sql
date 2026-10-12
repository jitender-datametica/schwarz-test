CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_bereich_spr_zu (geku_bereich_uid, spr_id, geku_bereich_bez,
quelle_spr_id, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.geku_bereich_spr_zu;