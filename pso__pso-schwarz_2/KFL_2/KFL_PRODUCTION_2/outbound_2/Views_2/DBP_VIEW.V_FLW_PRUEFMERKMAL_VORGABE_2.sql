CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_pruefmerkmal_vorgabe_2 AS SELECT prueflos_id,
 merkmal_lfd_nr,
 knoten_lfd_nr,
 mandant_id,
 stp_merkmal_id,
 werk_id,
 katalogart_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_pruefmerkmal_vorgabe_2;