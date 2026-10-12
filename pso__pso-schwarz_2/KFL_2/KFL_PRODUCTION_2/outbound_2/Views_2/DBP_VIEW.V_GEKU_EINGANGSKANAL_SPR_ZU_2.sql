CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_eingangskanal_spr_zu_2 AS SELECT geku_eingangskanal_id,
 spr_id,
 geku_eingangskanal_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_eingangskanal_spr_zu_2;