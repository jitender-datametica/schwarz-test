CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IMS_ANWENDERSTATUS_SPR_ZU_1
(
	ANWENDERSTATUS_ID,
	MANDANT_ID,
	ANWENDERSTATUS_BEZ_KURZ,
	ANWENDERSTATUS_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 20.08.2013 twie: Erstellung Sprachview Anwenderstatus
-- 20.08.2013 twie: nur deutsche View, keine Übersetzungen vorhanden, Attribut sprachunabhängig

   SELECT
   anwenderstatus_id,
   mandant_id,
   anwenderstatus_bez_kurz,
   anwenderstatus_bez

  FROM dbp_view.v_ims_anwenderstatus_spr_zu_1
  WHERE spr_id = 22
  ;