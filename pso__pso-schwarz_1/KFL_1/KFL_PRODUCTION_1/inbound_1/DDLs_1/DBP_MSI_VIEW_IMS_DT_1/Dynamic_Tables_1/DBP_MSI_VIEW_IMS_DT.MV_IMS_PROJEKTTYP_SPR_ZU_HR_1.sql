CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IMS_PROJEKTTYP_SPR_ZU_HR_1
(
	MANDANT_ID,
	PROJEKT_TYP_ID,
	PROJEKT_TYP_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
   SELECT
   v01.mandant_id,
   v01.ims_projekt_typ_id AS projekt_typ_id,
   v01.ims_projekt_typ_bez AS projekt_typ_bez

  FROM dbp_view.v_ims_projekt_typ_spr_zu_1 v01
   WHERE v01.spr_id = 65
  ;