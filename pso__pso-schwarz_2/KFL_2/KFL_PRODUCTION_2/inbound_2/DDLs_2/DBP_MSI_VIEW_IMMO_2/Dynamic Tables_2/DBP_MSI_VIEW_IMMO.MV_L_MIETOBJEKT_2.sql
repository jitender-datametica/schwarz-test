CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MIETOBJEKT_2(
	MANDANT_ID,
	MO_INTRENO,
	MO_SMENR,
	MO_OBJEKT_NR,
	DAT_LETZTE_UEBERGABE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   v0.mandant_id, v0.mo_intreno, v0.mo_smenr, v0.mo_objekt_nr, v1.dat_letzte_uebergabe

   FROM dbp_view.v_immo_mietobjekt_2 v0
   INNER JOIN
   (
   SELECT
   mandant_id,
   mo_intreno,
   MAX(mo_status_id) AS mo_status_id
   FROM dbp_view.v_immo_mo_status_per_2
   WHERE CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
   GROUP BY 1,2
   ) v5
   ON v5.mandant_id = v0.mandant_id
   AND v5.mo_intreno = v0.mo_intreno
   LEFT JOIN
   (
   SELECT mandant_id, mo_status_id, mo_intreno, MAX(dat_status_von) AS dat_letzte_uebergabe
   FROM dbp_view.v_immo_mo_status_per_2
   WHERE mo_status_id = 4 AND CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis GROUP BY 1,2,3
   ) v1
   ON v0.mandant_id = v1.mandant_id AND v0.mo_intreno = v1.mo_intreno;