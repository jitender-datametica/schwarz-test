CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_pruefmerkmal_vorgabe_2 (mandant_id, prueflos_id,
knoten_lfd_nr, merkmal_lfd_nr, stp_merkmal_id, werk_id, katalogart_id) AS SELECT mandant_id,
 prueflos_id,
 knoten_lfd_nr,
 merkmal_lfd_nr,
 stp_merkmal_id,
 werk_id,
 katalogart_id
FROM kfl_production_dbp_view.v_flw_pruefmerkmal_vorgabe_2 AS V01;