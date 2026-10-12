CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_ANLAGE_KLASSE_INT_1
(
	ANLAGE_KLASSE_ID,
	GESPERRT_FG
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 22.03.2013 twie: Lookup für Anlageklassen International (ALLE Klassen mandantenunabhängig)
-- 22.04.2013 twie: nur Anlagenklassen mit 8 Stellen (ohne führende Nullen)
-- 24.04.2013 twie: wenn gleiche ID unterschiedliches gesperrt_fg hat, wird das Flag der niedriegsten mandant_id genommen.

   SELECT
   anlage_klasse_id,
   gesperrt_fg
   FROM  dbp_view.v_l_anlage_klasse_1
   WHERE LENGTH (TRIM(COLLATE(anlage_klasse_id,''), '0')) = 8 
     AND TRY_TO_NUMERIC(anlage_klasse_id) IS NOT NULL
   QUALIFY ROW_NUMBER() OVER (PARTITION BY anlage_klasse_id ORDER BY mandant_id ASC) =1
;