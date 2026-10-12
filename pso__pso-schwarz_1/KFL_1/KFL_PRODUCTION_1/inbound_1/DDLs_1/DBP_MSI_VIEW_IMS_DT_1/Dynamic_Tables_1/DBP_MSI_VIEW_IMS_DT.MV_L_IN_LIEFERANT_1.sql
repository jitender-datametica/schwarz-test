CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IN_LIEFERANT_1
(
	IN_LIEF_ID,
	MANDANT_ID,
	IN_LIEF_NR,
	LIEF_NAME
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 14.06.2013 twie: Erstellung Lookup Lieferant
-- 27.06.2013 twie: Umstellung Tabelle von lief_name auf lief_name_1 und lief_name_2

   SELECT  in_lief_id,
           mandant_id,
           LTRIM( COLLATE(in_lief_nr,''), '0') AS in_lief_nr,
           lief_name_1 || ' ' ||  lief_name_2 AS lief_name
   FROM  dbp_view.v_in_lieferant_1
;