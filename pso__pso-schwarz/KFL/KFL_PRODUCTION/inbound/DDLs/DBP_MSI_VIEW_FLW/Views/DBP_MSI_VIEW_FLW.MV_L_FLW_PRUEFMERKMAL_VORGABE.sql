CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_PRUEFMERKMAL_VORGABE
-- 26.10.2011 system_id entfernt
(
--  system_id
mandant_id
, prueflos_id
, knoten_lfd_nr
, merkmal_lfd_nr
, stp_merkmal_id
, werk_id
, katalogart_id
)
AS
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.prueflos_id, v01.knoten_lfd_nr, v01.merkmal_lfd_nr, v01.stp_merkmal_id, v01.werk_id, v01.katalogart_id

   FROM dbp_view.v_flw_pruefmerkmal_vorgabe v01;