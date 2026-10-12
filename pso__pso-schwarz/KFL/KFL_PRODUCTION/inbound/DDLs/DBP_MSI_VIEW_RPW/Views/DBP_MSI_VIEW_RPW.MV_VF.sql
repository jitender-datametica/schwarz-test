CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VF
(
  vf_id
  ,vf_name
  ,mandant_id
  ,system_id
)
AS
   SELECT
      vf_id,
   vf_name,
   mandant_id,
   7
   FROM dbp_view.v_vf
   WHERE mandant_id = 1
 ;