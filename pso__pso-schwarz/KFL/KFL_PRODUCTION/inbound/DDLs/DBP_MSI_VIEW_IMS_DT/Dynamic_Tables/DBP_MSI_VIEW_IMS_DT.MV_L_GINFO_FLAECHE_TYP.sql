CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_GINFO_FLAECHE_TYP
(
	GINFO_FLAECHE_TYP_ID,
	MANDANT_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 12.04.2013 twie: Lookup für Flächentyp

   SELECT
   ginfo_flaeche_typ_id,
   mandant_id
   FROM dbp_view.v_l_ginfo_flaeche_typ
;