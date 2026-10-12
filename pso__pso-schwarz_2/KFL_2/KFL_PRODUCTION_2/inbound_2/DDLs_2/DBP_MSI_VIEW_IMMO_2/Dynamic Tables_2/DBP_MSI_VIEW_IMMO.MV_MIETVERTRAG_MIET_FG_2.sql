CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MIETVERTRAG_MIET_FG_2(
	MANDANT_ID,
	MV_INTRENO,
	MIET_FG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.mv_intreno, CASE WHEN v2.dat_rueckgabe < Current_Date OR v2.dat_rueckgabe IS NULL THEN 0 ELSE 1 END AS miet_fg
   FROM dbp_view.v_immo_mietvertrag_per_2 v1
   LEFT JOIN (
   SELECT
   v3.mv_intreno, v3.mandant_id, Max(v3.dat_rueckgabe_am) dat_rueckgabe
   FROM dbp_view.v_immo_mietvertrag_sicherheit_2 AS v3
   GROUP BY 1,2) AS v2
   ON v1.mandant_id=v2.mandant_id AND v1.mv_intreno=v2.mv_intreno

   UNION ALL
   

   SELECT
   mandant_id, '' AS mv_intreno, 1 AS miet_fg
   FROM dbp_view.v_mandant_2;