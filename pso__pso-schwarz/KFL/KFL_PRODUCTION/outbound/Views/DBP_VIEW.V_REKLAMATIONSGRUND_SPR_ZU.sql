CREATE OR REPLACE VIEW kfl_production_dbp_view.v_reklamationsgrund_spr_zu AS SELECT mandant_id,
 reklamationsgrund_id,
 spr_id,
 reklamationsgrund_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.reklamationsgrund_spr_zu;