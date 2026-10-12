CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IN_L_WG_1
(
	IN_WG_ID,
	MANDANT_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 31.05.2013 twie Erstellung Lookup für Warengruppe

   SELECT
   v01.in_wg_id,
   v01.mandant_id

  FROM dbp_view.v_in_l_wg_1 v01
;