CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_ANZAHL_U6_1(
	MANDANT_ID,
	MV_INTRENO,
	MIETVERTRAG_NR,
	WRG_ID,
	WRG_TYP_ID,
	ANZAHL_UMSAETZE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.mv_intreno, v1.mietvertrag_nr, v1.wrg_id, v1.wrg_typ_id, COUNT (DISTINCT v1.kjmo) AS anzahl_umsaetze
   FROM dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_12_1 AS v1
   WHERE  akt_mo BETWEEN -12 AND -1 AND v1.umsatz_netto >0
   GROUP BY
   v1.mandant_id
   ,v1.mv_intreno
   ,v1.mietvertrag_nr
   ,v1.wrg_id
   , v1.wrg_typ_id;