CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_L_MASS_TYP_2
(
	IN_MASSNAHME_TYP_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 05.04.2013 twie: Lookup für Massnahmentyp

   SELECT
   in_massnahme_typ_id
   FROM dbp_view.v_in_l_mass_typ_2
;