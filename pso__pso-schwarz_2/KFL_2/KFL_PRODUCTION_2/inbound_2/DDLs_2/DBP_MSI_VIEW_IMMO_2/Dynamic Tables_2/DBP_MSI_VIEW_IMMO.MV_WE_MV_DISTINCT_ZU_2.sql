CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_WE_MV_DISTINCT_ZU_2(
	MANDANT_ID,
	MV_INTRENO,
	WE_INTRENO
) TARGET_LAG= '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT DISTINCT mandant_id, mv_intreno, we_intreno
   FROM (SELECT
   v2.mandant_id, v2.we_intreno, v1.mv_intreno
   FROM dbp_view.v_immo_mo_status_per_2 v1
   
   JOIN
   dbp_view.v_immo_mietobjekt_2 v2
   ON v1.mo_intreno = v2.mo_intreno
   WHERE CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis

   UNION ALL
   SELECT
   v2.mandant_id, v2.we_intreno, v1.mv_intreno
   FROM dbp_view.v_immo_mietvertrag_mo_zu_per_2 v1
   
   JOIN
   dbp_view.v_immo_mietobjekt_2 v2
   ON v1.mo_intreno = v2.mo_intreno
   WHERE (v1.mv_intreno) NOT IN (SELECT mv_intreno
   FROM dbp_view.v_immo_mo_status_per_2
   WHERE CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis )

   UNION ALL
   SELECT
   v1.mandant_id, v1.we_intreno, v1.mv_intreno
   FROM dbp_view.v_immo_mietvertrag_we_zu_per_2 v1
   
   WHERE
   CURRENT_DATE BETWEEN v1.dat_von
   AND v1.dat_bis
  ) tmp;