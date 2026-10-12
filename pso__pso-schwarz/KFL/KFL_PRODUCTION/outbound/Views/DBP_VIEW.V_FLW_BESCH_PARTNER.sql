CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_besch_partner AS SELECT mandant_id,
 faktura_beleg_id,
 partner_verwendung_id,
 faktura_beleg_pos_id,
 flw_kunde_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_besch_partner;