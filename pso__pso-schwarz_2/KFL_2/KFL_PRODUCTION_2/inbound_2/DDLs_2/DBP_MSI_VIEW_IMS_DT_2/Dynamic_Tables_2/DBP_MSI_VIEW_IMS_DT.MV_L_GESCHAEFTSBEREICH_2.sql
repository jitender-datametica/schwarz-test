CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_GESCHAEFTSBEREICH_2
(
	GESCHAEFTSBEREICH_ID,
	MANDANT_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 17.05.2013 twie: Lookup für Geschäftsbereich

   SELECT
   geschaeftsbereich_id,
   mandant_id

   FROM dbp_view.v_l_geschaeftsbereich_2
;