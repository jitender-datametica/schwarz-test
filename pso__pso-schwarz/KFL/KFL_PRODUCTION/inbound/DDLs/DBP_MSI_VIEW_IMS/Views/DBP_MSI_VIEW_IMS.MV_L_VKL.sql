CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_VKL AS
-- 14.06.2013 twie: Erstellung Lookup für VKL

   SELECT
   vkl_id,
   mandant_id,
   CASE WHEN vkl_id IN (0, -1) THEN ''
   ELSE vkl_name
   END AS vkl_name,
   COALESCE(gf_id,-1) AS gf_id

   FROM dbp_view.v_vkl;