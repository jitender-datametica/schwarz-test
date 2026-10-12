CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_GINFO_MARKT_TYP_1
(
	GINFO_MARKT_TYP,
	GINFO_MARKT_TYP_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 11.04.2013 twie: Lookup für Markttyp, keine Sprachtabelle vorhanden

   SELECT
   ginfo_markt_typ,
   CASE WHEN ginfo_markt_typ = '' THEN ''
ELSE ginfo_markt_typ_bez
END AS ginfo_markt_typ_bez

FROM dbp_view.v_l_ginfo_markt_typ_1
;