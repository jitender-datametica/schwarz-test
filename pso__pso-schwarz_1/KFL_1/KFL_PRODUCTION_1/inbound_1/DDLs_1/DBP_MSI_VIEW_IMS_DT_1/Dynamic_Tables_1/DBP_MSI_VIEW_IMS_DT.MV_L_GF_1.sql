CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_GF_1
(
	GF_ID,
	MANDANT_ID,
	GF_NAME
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 14.06.2013 twie: Erstellung Lookup für GF_1

   SELECT

   gf_id,
   mandant_id,
   CASE WHEN gf_id IN (0,-1) THEN ''
   ELSE gf_name
   END AS gf_name

   FROM dbp_view.v_gf_1

   WHERE ek_fg = 0
;