CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_antwortkanal_spr_zu AS SELECT geku_antwortkanal_id,
 spr_id,
 geku_antwortkanal_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_antwortkanal_spr_zu;