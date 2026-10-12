CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_MONAT_SPR_ZU_PL_2
(
	MO_GJ,
	MO_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
--23.05.2013 AL Init
   SELECT
   CASE WHEN mo_id >= 3 THEN mo_id -2 ELSE mo_id + 10 END AS mo_gj,
   mo_bez

  FROM dbp_view.v_monat_spr_zu_2  v01
   WHERE spr_id=90
;