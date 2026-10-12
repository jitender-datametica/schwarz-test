CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VF_1
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
   FROM dbp_view.v_vf_1
   WHERE mandant_id = 1
 ;