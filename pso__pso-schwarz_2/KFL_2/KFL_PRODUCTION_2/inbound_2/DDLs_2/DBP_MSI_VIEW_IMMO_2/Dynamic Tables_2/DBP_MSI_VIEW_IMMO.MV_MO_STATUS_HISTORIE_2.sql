CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MO_STATUS_HISTORIE_2(
	MANDANT_ID,
	MO_STATUS_ID,
	MO_INTRENO,
	MV_INTRENO,
	DAT_STATUS_VON,
	DAT_STATUS_BIS,
	MO_STATUS_VORMONAT_ID,
	MO_TYP_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v00.mandant_id, v00.mo_status_id, v00.mo_intreno, v00.mv_intreno, v00.dat_status_von, v00.dat_status_bis, COALESCE(CAST(v01.mo_status_id  AS CHAR (1)) , '-')  AS mo_status_vormonat_id, v16.mo_typ_id
   FROM dbp_view.v_immo_mo_status_per_2 v00
   
   JOIN
   (SELECT mo_intreno, mv_intreno, MAX(dat_status_von) AS max_dat_status_von
   FROM dbp_view.v_immo_mo_status_per_2
   WHERE "CURRENT_DATE" BETWEEN dat_status_von AND dat_status_bis
   GROUP BY mo_intreno, mv_intreno
   ) v02
   ON v00.mo_intreno=v02.mo_intreno
   AND v00.mv_intreno=v02.mv_intreno
   AND v00.dat_status_von=v02.max_dat_status_von
   LEFT OUTER JOIN
   (SELECT t2.mandant_id, t1.mo_intreno, t1.mv_intreno, t2.mo_status_id
   FROM
   (SELECT mo_intreno, mv_intreno, MAX(dat_status_von) AS max_dat_status_von
   FROM dbp_view.v_immo_mo_status_per_2
   WHERE ("CURRENT_DATE" -30) BETWEEN dat_status_von AND dat_status_bis
   GROUP BY mo_intreno, mv_intreno
   ) t1_2
   JOIN dbp_view.v_immo_mo_status_per_2 t2
   ON  t1.mo_intreno = t2.mo_intreno AND t1.mv_intreno = t2.mv_intreno AND t1.max_dat_status_von = t2.dat_status_von
   WHERE ("CURRENT_DATE" -30) BETWEEN t2.dat_status_von AND t2.dat_status_bis
   ) v01
   ON v00.mandant_id = v01.mandant_id AND v00.mo_intreno = v01.mo_intreno AND v00.mv_intreno = v01.mv_intreno
   LEFT JOIN dbp_view.v_immo_mietobjekt_2 AS v16
   ON v00.mandant_id=v16.mandant_id AND v00.mo_intreno=v16.mo_intreno

   WHERE ("CURRENT_DATE" BETWEEN v00.dat_status_von AND v00.dat_status_bis);