CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_R_MV_NACHMIETVERTRAG(
	MANDANT_ID,
	MV_INTRENO,
	NACH_MV_INTRENO,
	NACH_MV_DAT_MIET_BEGINN,
	NACH_MV_DAT_MIET_ENDE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.mv_intreno, COALESCE(v2.nach_mv_intreno,'') AS nach_mv_intreno, MAX(v2.nach_mv_dat_miet_beginn), MAX(v2.nach_mv_dat_miet_ende)
   FROM
   (
   SELECT
   a.mandant_id, b.mo_intreno, b.mv_intreno, a.dat_miet_beginn AS mv_dat_miet_beginn, a.dat_miet_ende AS  mv_dat_miet_ende
   FROM dbp_view.v_immo_mietvertrag_per a
   JOIN dbp_view.v_immo_mietvertrag_mo_zu_per b
   ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno AND CURRENT_DATE BETWEEN a.dat_miet_beginn AND a.dat_miet_ende
   ) v1
   LEFT OUTER JOIN
   (
   SELECT
   a.mandant_id, b.mo_intreno, b.mv_intreno AS nach_mv_intreno, a.dat_miet_beginn AS nach_mv_dat_miet_beginn, a.dat_miet_ende AS nach_mv_dat_miet_ende
   FROM dbp_view.v_immo_mietvertrag_per a
   JOIN dbp_view.v_immo_mietvertrag_mo_zu_per b
   ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno AND CURRENT_DATE < a.dat_miet_beginn
   ) v2
   ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
   GROUP BY 1,2,3;