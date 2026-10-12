CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_ANLAGE_KLASSE_SPR_ZU_HR_2
(
	MANDANT_ID,
	ANLAGE_KLASSE_ID,
	ANLAGE_KLASSE_BEZ_KURZ,
	ANLAGE_KLASSE_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Sprachzuordung für Anlageklassen
-- 19.08.2013 twie: in en und KMO kein Fallback auf de, BED stellt sicher, dass Landessprache immer vorhanden
-- 20.08.2013/Gia

   SELECT
   mandant_id,
   anlage_klasse_id,
   anlage_klasse_bez_kurz,
   anlage_klasse_bez

   FROM dbp_view.v_anlage_klasse_spr_zu_2

   WHERE  spr_id=65
   AND anlage_klasse_bez_kurz <> 'inaktiv'
   ;