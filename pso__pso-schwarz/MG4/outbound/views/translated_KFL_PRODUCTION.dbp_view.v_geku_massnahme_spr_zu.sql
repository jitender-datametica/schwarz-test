CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_massnahme_spr_zu (geku_massnahme_uid, spr_id, geku_massnahme_bez,
quelle_spr_id, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.geku_massnahme_spr_zu;