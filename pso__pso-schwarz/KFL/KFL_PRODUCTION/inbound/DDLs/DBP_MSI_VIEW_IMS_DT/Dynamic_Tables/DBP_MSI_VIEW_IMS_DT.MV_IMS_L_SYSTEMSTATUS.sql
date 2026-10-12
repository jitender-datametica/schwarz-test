CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IMS_L_SYSTEMSTATUS
(
	SYSTEMSTATUS_ID,
	MANDANT_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 20.08.2013 twie: Erstellung Lookupview Systemstatus

   SELECT
   systemstatus_id,
   mandant_id

   FROM dbp_view.v_ims_l_systemstatus
   ;