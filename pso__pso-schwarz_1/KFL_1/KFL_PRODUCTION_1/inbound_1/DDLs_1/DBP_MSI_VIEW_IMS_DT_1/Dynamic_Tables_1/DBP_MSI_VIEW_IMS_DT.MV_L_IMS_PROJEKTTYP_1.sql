CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IMS_PROJEKTTYP_1
(
	MANDANT_ID,
	PROJEKT_TYP_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
   SELECT
   v01.mandant_id,
   v01.ims_projekt_typ_id AS projekt_typ_id

  FROM dbp_view.v_l_ims_projekt_typ_1 v01
;