CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IN_L_BUCHUNGSKREIS_1
(
	MANDANT_ID,
	BUCHUNGSKREIS_ID,
	KONTENPLAN_ID,
	SAKO_FG
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 31.05.2013 twie: Erstellung Lookup Buchungskreis

   SELECT
   v01.mandant_id,
   v01.buchungskreis_id,
   v01.kontenplan_id,
   v01.sako_fg

  FROM dbp_view.v_in_l_buchungskreis_1 v01
;