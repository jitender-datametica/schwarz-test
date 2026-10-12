CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_herkunft_spr_zu_2 AS SELECT mandant_id,
 herkunft_id,
 spr_id,
 herkunft_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_herkunft_spr_zu_2;