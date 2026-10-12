CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_DISPONENT_2
(
disponent_id
,mandant_id

)
AS
   SELECT
  disponent_id,
   mandant_id

   FROM dbp_view.v_l_disponent_2
   WHERE mandant_id <> 1;