CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_GINFO_BAUFORM_1
(
	GINFO_BAUFORM_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 11.04.2013 twie: Lookup für GINFO Bauform

   SELECT
   ginfo_bauform_id

   FROM dbp_view.v_l_ginfo_bauform_1
;