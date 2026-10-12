CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_transport_hu_zu_2 AS SELECT mandant_id,
 tour_id,
 handling_unit_id_ext,
 verlade_lief_beleg_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_transport_hu_zu_2;