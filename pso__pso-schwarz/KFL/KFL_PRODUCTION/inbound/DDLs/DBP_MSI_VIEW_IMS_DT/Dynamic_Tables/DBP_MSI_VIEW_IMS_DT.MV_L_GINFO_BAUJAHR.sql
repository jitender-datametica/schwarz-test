CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_GINFO_BAUJAHR
(
	BAUJAHR,
	BAUJAHR_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 06.05.2013 twie: Lookup für GINFO Baujahr (aus Bewegungsdaten plus Dummywert)

   SELECT
   DISTINCT(baujahr) AS baujahr,
   CAST(baujahr AS CHAR(4)) AS baujahr_bez

   FROM dbp_view.v_techn_platz_ebene_2_per

   UNION

   SELECT
   9999 AS baujahr,
   '' AS baujahr_bez

   FROM dbp_view.v_jahr_kj
;