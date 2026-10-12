CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_transport_hu_zu (mandant_id, tour_id, handling_unit_id_ext
, verlade_lief_beleg_id) AS SELECT mandant_id,
 tour_id,
 handling_unit_id_ext,
 verlade_lief_beleg_id
FROM kfl_production_dbp_view.v_flw_transport_hu_zu;