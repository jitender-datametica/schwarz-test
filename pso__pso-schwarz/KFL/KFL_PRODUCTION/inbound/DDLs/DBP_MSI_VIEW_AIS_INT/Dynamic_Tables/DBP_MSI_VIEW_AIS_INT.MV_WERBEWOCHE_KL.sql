CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_WERBEWOCHE_KL 
(
 	MANDANT_ID,
	DAT,
	AKT_KJWO_WW,
	AKT_KJWO_WW_KOMPLETT,
	KJWO_WW,
   ANGEPASSTE_KJWO_WW,
	WO_WW,
	WW_DAT_VON,
	WW_DAT_BIS,
	WW_MO,
	WW_TAG  
   
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT mandant_id,
   dat,
   akt_kjwo_ww,
   akt_kjwo_ww_komplett,
   kjwo_ww,
   -- Erweiterung um neue Spalte / sschuecke 13.06.2025
   angepasste_kjwo_ww,
   SUBSTR(TO_CHAR(kjwo_ww),5,2) AS wo_ww,
   MIN(dat) OVER (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_von,
   MAX(dat) OVER (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_bis,
   (EXTRACT(YEAR FROM MIN(dat) OVER (PARTITION BY mandant_id, kjwo_ww)) * 100) +
  EXTRACT(MONTH FROM MIN(dat) OVER (PARTITION BY mandant_id, kjwo_ww)) AS ww_mo,
   RANK() OVER (PARTITION BY mandant_id, kjwo_ww ORDER BY dat) AS ww_tag
  FROM dbp_data.werbewoche_kl;