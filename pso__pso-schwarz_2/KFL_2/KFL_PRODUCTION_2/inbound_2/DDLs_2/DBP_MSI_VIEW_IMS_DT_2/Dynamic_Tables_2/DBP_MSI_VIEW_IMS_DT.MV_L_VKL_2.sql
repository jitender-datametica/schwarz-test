CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_VKL_2
(
	VKL_ID,
	MANDANT_ID,
	VKL_NAME,
	GF_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 14.06.2013 twie: Erstellung Lookup für VKL_2

   SELECT
   vkl_id,
   mandant_id,
   CASE WHEN vkl_id IN (0, -1) THEN ''
   ELSE vkl_name
   END AS vkl_name,
   COALESCE(gf_id,-1) AS gf_id

   FROM dbp_view.v_vkl_2
;