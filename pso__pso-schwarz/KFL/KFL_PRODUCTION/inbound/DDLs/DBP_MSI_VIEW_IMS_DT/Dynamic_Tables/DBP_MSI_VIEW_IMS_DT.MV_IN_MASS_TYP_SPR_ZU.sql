CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_MASS_TYP_SPR_ZU
(
	IN_MASSNAHME_TYP_ID,
	IN_MASSNAHME_TYP_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 05.04.2013 twie: Sprachzuordnung für Massnahmentyp

   SELECT
   in_massnahme_typ_id,
   in_massnahme_typ_bez
   FROM dbp_view.v_in_mass_typ_spr_zu
   WHERE  spr_id=22
;