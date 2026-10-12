CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_INTRENO_ZU_HILF(
	MANDANT_ID,
	WE_INTRENO,
	MO_INTRENO,
	MV_INTRENO,
	MIETVERTRAG_NR,
	PARTNER_ID,
	KONZESSIONAER_ID,
	DAT_VON,
	DAT_BIS,
	WE_INTRENO_AKT,
	MO_INTRENO_AKT,
	MV_INTRENO_AKT,
	KONZESSIONAER_ID_AKT
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT DISTINCT
   v1.mandant_id, v1.we_intreno, v1.mo_intreno, v15.mv_intreno AS mv_intreno, v3.mietvertrag_nr, v3.partner_id, v3.partner_id AS konzessionaer_id, v2.dat_von, v2.dat_bis, v6.we_intreno_akt, v6.mo_intreno_akt, v6.mv_intreno_akt, v6.konzessionaer_id AS konzessionaer_id_akt
   FROM dbp_view.v_immo_mietobjekt v1
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per v2
   ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
   LEFT JOIN dbp_view.v_immo_mietvertrag_per AS v3
   ON v3.mandant_id = v2.mandant_id AND v3.mv_intreno = v2.mv_intreno
   JOIN
   (
   SELECT DISTINCT
   v11.mandant_id, v13.mietvertrag_nr, MAX(v11.we_intreno) AS we_intreno_akt, MAX(v11.mo_intreno) AS mo_intreno_akt, MAX(v12.mv_intreno) AS mv_intreno_akt, MAX(v13.partner_id) AS konzessionaer_id


   FROM dbp_view.v_immo_mietobjekt v11
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per v12
   ON v11.mandant_id = v12.mandant_id AND v11.mo_intreno = v12.mo_intreno
   LEFT JOIN dbp_view.v_immo_mietvertrag_per AS v13
   ON v13.mandant_id = v12.mandant_id AND v13.mv_intreno = v12.mv_intreno
   GROUP BY
   1,2
   ) AS v6
   ON v3.mandant_id = v6.mandant_id AND v3.mietvertrag_nr = v6.mietvertrag_nr
   JOIN (
   SELECT DISTINCT v1.mandant_id, v1.mv_intreno, v2.mietvertrag_nr FROM dbp_view.v_immo_mietvertrag_per AS v1
   JOIN (
   SELECT DISTINCT mandant_id, mv_intreno, mietvertrag_nr, mietvertrag_nr_alt FROM dbp_view.v_immo_mietvertrag_per) AS v2
   ON v1.mietvertrag_nr=v2.mietvertrag_nr_alt AND v1.mandant_id=v2.mandant_id
   ) AS v15
   ON v3.mietvertrag_nr=v15.mietvertrag_nr AND v3.mandant_id=v15.mandant_id

   UNION

   SELECT DISTINCT
   v1.mandant_id, v1.we_intreno, v1.mo_intreno, v2.mv_intreno, v3.mietvertrag_nr, v3.partner_id, v3.partner_id AS konzessionaer_id, v2.dat_von, v2.dat_bis, v6.we_intreno_akt, v6.mo_intreno_akt, v6.mv_intreno_akt, v6.konzessionaer_id AS konzessionaer_id_akt
   FROM dbp_view.v_immo_mietobjekt v1
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per v2
   ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
   LEFT JOIN dbp_view.v_immo_mietvertrag_per AS v3
   ON v3.mandant_id = v2.mandant_id AND v3.mv_intreno = v2.mv_intreno
   JOIN
   (
   SELECT DISTINCT
   v11.mandant_id, v13.mietvertrag_nr, MAX(v11.we_intreno) AS we_intreno_akt, MAX(v11.mo_intreno) AS mo_intreno_akt, MAX(v12.mv_intreno) AS mv_intreno_akt, MAX(v13.partner_id) AS konzessionaer_id


   FROM dbp_view.v_immo_mietobjekt v11
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per v12
   ON v11.mandant_id = v12.mandant_id AND v11.mo_intreno = v12.mo_intreno
   LEFT JOIN dbp_view.v_immo_mietvertrag_per AS v13
   ON v13.mandant_id = v12.mandant_id AND v13.mv_intreno = v12.mv_intreno

   GROUP BY
   1,2
   ) AS v6
   ON v3.mandant_id = v6.mandant_id AND v3.mietvertrag_nr = v6.mietvertrag_nr;