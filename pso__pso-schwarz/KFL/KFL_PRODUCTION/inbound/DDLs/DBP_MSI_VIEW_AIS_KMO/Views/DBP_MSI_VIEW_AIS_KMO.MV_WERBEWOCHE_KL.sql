CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WERBEWOCHE_KL
(
	MANDANT_ID,
	DAT,
	AKT_KJWO_WW,
	AKT_KJWO_WW_KOMPLETT,
	KJWO_WW,
	WO_WW,
	WW_DAT_VON,
	WW_DAT_BIS,
	WW_MO,
	WW_TAG
) 
AS
   SELECT 
   mandant_id,
   dat,
   akt_kjwo_ww,
   akt_kjwo_ww_komplett,
   kjwo_ww,
   SUBSTR(TO_CHAR(kjwo_ww),5,2) AS wo_ww,
   MIN(dat) OVER (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_von,
   MAX(dat) OVER (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_bis,
   (EXTRACT(YEAR FROM MIN(dat) OVER (PARTITION BY mandant_id, kjwo_ww)) * 100) +
   EXTRACT(MONTH FROM MIN(dat) OVER (PARTITION BY mandant_id, kjwo_ww)) AS ww_mo,
   RANK() OVER (PARTITION BY mandant_id, kjwo_ww ORDER BY dat) AS ww_tag
  FROM dbp_data.werbewoche_kl
  WHERE mandant_id > 1;