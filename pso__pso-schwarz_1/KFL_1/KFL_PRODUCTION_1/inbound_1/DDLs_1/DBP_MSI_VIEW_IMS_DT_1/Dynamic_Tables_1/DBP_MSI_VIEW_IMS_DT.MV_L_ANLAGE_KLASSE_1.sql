CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_ANLAGE_KLASSE_1
(
	MANDANT_ID,
	ANLAGE_KLASSE_ID,
	GESPERRT_FG
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Lookup für Anlageklassen

   SELECT
   mandant_id,
   anlage_klasse_id,
   gesperrt_fg

   FROM dbp_view.v_l_anlage_klasse_1
;