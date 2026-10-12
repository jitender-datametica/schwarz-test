CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IN_KOSTENSTELLE_2
(
	MANDANT_ID,
	KOSTENSTELLE_ID,
	KRK_ID,
	PC_ID,
	BUCHUNGSKREIS_ID,
	GESCHAEFTSBEREICH_ID,
	KOSTENSTELLENART_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 21.08.2013 twie: Lookup für Kostenstelle, immer den aktuellsten Eintrag aus der Historie
-- 23.08.2013 twie: wenn keine pc_id vorhanden, Dummy_2 -1 ausgeben

   SELECT
   mandant_id,
   kostenstelle_id,
   krk_id,
   COALESCE(pc_id, '-1' ) AS pc_id,
   buchungskreis_id,
   geschaeftsbereich_id,
   kostenstellenart_id

   FROM dbp_view.v_in_kostenstelle_per_2

   QUALIFY ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id  ORDER BY dat_bis DESC NULLS LAST) =1
;