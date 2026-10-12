CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_KOSTENART_1
(
	KOSTENART_ID,
	KRK_ID,
	KONTENPLAN_ID,
	KOSTENART_ALTNV_ID,
	KOSTENART_GRP_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Lookup für Kostenarten, mandantenunabhängig
-- 20.08.2013 twie: mandant_id nicht mit ausgeben
-- 20.08.2013/Gia
   SELECT LTRIM(COLLATE(kostenart_id,''),'0') AS kostenart_id,
          krk_id,
          kontenplan_id,
          kostenart_altnv_id,
          kostenart_grp_id
   FROM  dbp_view.v_kostenart_1
   WHERE mandant_id = 1
   AND  krk_id='XX01'
;