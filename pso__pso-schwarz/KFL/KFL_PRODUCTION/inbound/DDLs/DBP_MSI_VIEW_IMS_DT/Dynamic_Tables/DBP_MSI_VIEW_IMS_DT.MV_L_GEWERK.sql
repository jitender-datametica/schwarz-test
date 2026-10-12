CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_GEWERK
(
	GEWERK_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 08.04.2016 twie: AP0001938 Lookup für Gewerke mit Dummy -1

   SELECT
   gewerk_id

   FROM dbp_view.v_l_gewerk

   UNION

   SELECT
   -1
   FROM dbp_view.v_mandant
   WHERE mandant_id = 1
;