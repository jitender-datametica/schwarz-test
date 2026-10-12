CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_UMSATZ_U6(
	MANDANT_ID,
	MV_INTRENO,
	MIETVERTRAG_NR,
	WRG_ID,
	WRG_TYP_ID,
	KJMO,
	COUNT_MELDEREGEL,
	UMSATZ_NETTO_U6,
	HOCHGRCH_UMSATZ_U6,
	AVG_UMSATZ_U6
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, 
   v1.mv_intreno, 
   v1.mietvertrag_nr, 
   v1.wrg_id, 
   v1.wrg_typ_id, 
   Max(kjmo) AS kjmo, 
   Sum(interval_months) AS Count_melderegel, 
   CASE WHEN Count_melderegel > 5 THEN Sum(v1.umsatz_netto)  ELSE 0 END AS umsatz_netto_u6, 
   CASE WHEN Count_melderegel > 5 THEN Sum(v1.umsatz_netto)*12/Count_melderegel  ELSE 0 END AS Hochgrch_umsatz_u6, 
   CASE WHEN Count_melderegel <>0  THEN Sum(v1.umsatz_netto)/Count_melderegel ELSE 0 END AS Avg_umsatz_u6

   FROM dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_12 AS v1
   WHERE  akt_mo BETWEEN -12 AND -1 AND v1.umsatz_netto>0
   GROUP BY
   v1.mandant_id
   --,v1.we_intreno
   ,v1.mv_intreno
   ,v1.mietvertrag_nr
   ,v1.wrg_id
   , v1.wrg_typ_id;