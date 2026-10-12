CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_ANLAGE_1
(
	ANLAGE_ID,
	ANLAGE_SUB_ID,
	MANDANT_ID,
	ANLAGE_BUCHUNGSKREIS_ID,
	ANLAGE_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 13.06.2013 twie: Erstellung Lookup Anlage_1
-- 02.09.2013 twie: Dummyanlage entfernt, ist jetzt in Tabelle

   SELECT
   anlage_id,
   anlage_sub_id,
   mandant_id,
   buchungskreis_id AS anlage_buchungskreis_id,
   anlage_bez

   FROM dbp_view.v_anlage_1
;