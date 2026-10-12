CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_VKL
-- 02.10.2013 twie: Erweitert um mandant_id 2
(
vkl_id
, gf_id
, vkl_name
, mandant_id
)
AS
   SELECT
  vkl_id, gf_id, vkl_name, mandant_id

   FROM dbp_view.v_vkl
   WHERE mandant_id IN (1,2);