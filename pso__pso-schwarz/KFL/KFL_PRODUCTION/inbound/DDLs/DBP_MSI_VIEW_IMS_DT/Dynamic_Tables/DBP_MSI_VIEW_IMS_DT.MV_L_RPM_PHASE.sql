CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_RPM_PHASE
(
	RPM_PHASE_ID,
	RPM_PROJEKT_TYP_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS

-- 12.06.2013 twie: Lookup für RPM Status

   SELECT
   rpm_phase_id,
   rpm_projekt_typ_id
   FROM dbp_view.v_l_rpm_phase
;