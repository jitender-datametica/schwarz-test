CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_KOSTENART_SPR_ZU_1
(
	KOSTENART_ID,
	KRK_ID,
	KOSTENART_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Sprachzuordung für Kostenarten
-- 20.08.2013 twie: mandant_id nicht mit ausgeben

   SELECT
   LTRIM(collate(kostenart_id,''),'0') AS kostenart_id,
   krk_id,
   kostenart_bez

   FROM  dbp_view.v_kostenart_spr_zu_1

   WHERE mandant_id = 1
   AND krk_id='XX01'
   AND spr_id=22
;