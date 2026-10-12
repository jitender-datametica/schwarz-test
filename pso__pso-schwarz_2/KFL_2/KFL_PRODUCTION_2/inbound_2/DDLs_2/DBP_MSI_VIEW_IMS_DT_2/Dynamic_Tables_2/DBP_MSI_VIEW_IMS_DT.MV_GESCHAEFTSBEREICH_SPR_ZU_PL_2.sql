CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_GESCHAEFTSBEREICH_SPR_ZU_PL_2
(
	MANDANT_ID,
	GESCHAEFTSBEREICH_ID,
	GESCHAEFTSBEREICH_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 17.05.2013 twie: Sprachzuordung für Geschäftsbereich
-- 20.08.2013 twie: in en und KMO kein Fallback auf de, BED stellt sicher, dass Landessprache immer vorhanden

   SELECT
   mandant_id,
   geschaeftsbereich_id,
   geschaeftsbereich_bez

   FROM dbp_view.v_geschaeftsbereich_spr_zu_2

   WHERE  spr_id=90
   ;