CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_RECH_BELEG_STATUS_1
(
system_id
,mandant_id
,rech_beleg_status_id
)
AS
   SELECT
   7,
   mandant_id,
   rech_beleg_status_id
   FROM dbp_view.v_l_rech_beleg_status_1
   WHERE mandant_id = 1
 ;