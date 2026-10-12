CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IN_ART
(
	IN_ART_ID,
	MANDANT_ID,
	IN_ART_NR,
	IN_WG_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 31.05.2013 twie: Erstellung Lookup für Material

   SELECT
   v01.in_art_id,
   v01.mandant_id,
   v01.in_art_nr,
   v01.in_wg_id

  FROM dbp_view.v_in_art v01
;