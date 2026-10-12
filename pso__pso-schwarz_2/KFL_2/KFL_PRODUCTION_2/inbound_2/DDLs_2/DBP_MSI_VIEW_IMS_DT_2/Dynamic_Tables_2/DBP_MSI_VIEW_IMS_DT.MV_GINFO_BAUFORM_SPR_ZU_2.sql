CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_GINFO_BAUFORM_SPR_ZU_2
(
	GINFO_BAUFORM_ID,
	GINFO_BAUFORM_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 11.04.2013 twie: Sprachzuordung für GINFO Bauform

   SELECT
   ginfo_bauform_id,
   ginfo_bauform_bez

   FROM dbp_view.v_ginfo_bauform_spr_zu_2

   WHERE  spr_id = 22
   ;