CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_DISPONENT_1
(
disponent_id
,mandant_id

)
AS
   SELECT
  disponent_id,
   mandant_id

   FROM dbp_view.v_l_disponent_1
   WHERE mandant_id <> 1;