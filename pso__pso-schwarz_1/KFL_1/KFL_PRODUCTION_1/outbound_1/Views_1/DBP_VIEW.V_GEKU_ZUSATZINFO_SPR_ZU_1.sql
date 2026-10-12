CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_1 AS SELECT zusatzinfo_id,
 spr_id,
 zusatzinfo_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_zusatzinfo_spr_zu_1;