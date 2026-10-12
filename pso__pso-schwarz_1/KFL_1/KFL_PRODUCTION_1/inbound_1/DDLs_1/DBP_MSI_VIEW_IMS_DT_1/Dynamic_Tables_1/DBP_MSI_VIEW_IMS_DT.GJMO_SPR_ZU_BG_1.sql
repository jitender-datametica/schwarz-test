CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.GJMO_SPR_ZU_BG_1
(
	GJMO,
	GJMO_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 23.05.2013 A Lipkin erstellt

   SELECT gjmo,
   TRIM( mo_bez)  ||  ' GJ ' ||  CAST(gj AS CHAR(4))  AS gjmo_bez

   FROM dbp_view.v_monat_1 v01
   INNER JOIN dbp_view.v_monat_spr_zu_1 v02
   ON v01.mo_kj =v02.mo_id
   WHERE v02.spr_id=18
   ;