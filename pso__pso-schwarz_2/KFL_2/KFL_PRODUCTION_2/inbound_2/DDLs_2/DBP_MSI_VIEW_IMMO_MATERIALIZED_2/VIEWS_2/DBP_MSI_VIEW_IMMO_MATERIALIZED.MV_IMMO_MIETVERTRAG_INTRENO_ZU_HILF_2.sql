create or replace view DBP_MSI_VIEW_IMMO_MATERIALIZED.MV_IMMO_MIETVERTRAG_INTRENO_ZU_HILF_2(
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
) as

   SELECT DISTINCT
   v1.mandant_id, v1.we_intreno, v1.mo_intreno, v15.mv_intreno as mv_intreno, v3.mietvertrag_nr, v3.partner_id, v3.partner_id as konzessionaer_id, v2.dat_von, v2.dat_bis, v6.we_intreno_akt, v6.mo_intreno_akt, v6.mv_intreno_akt, v6.konzessionaer_id as konzessionaer_id_akt
   FROM dbp_view.v_immo_mietobjekt_2 v1
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 v2
   ON v1.mandant_id = v2.mandant_id and v1.mo_intreno = v2.mo_intreno
   LEFT join dbp_view.v_immo_mietvertrag_per_2 as v3
   ON v3.mandant_id = v2.mandant_id and v3.mv_intreno = v2.mv_intreno
   join
   (
   SELECT DISTINCT
   v11.mandant_id, v13.mietvertrag_nr, max(v11.we_intreno) as we_intreno_akt, max(v11.mo_intreno) as mo_intreno_akt, max(v12.mv_intreno) as mv_intreno_akt, max(v13.partner_id) as konzessionaer_id


   FROM dbp_view.v_immo_mietobjekt_2 v11
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 v12
   ON v11.mandant_id = v12.mandant_id and v11.mo_intreno = v12.mo_intreno
   LEFT join dbp_view.v_immo_mietvertrag_per_2 as v13
   ON v13.mandant_id = v12.mandant_id and v13.mv_intreno = v12.mv_intreno
   group by
   1,2
   ) as v6
   ON v3.mandant_id = v6.mandant_id and v3.mietvertrag_nr = v6.mietvertrag_nr
   JOIN (
   select distinct v1.mandant_id, v1.mv_intreno, v2.mietvertrag_nr from dbp_view.v_immo_mietvertrag_per_2 as v1
   join (
   select distinct mandant_id, mv_intreno, mietvertrag_nr, mietvertrag_nr_alt from dbp_view.v_immo_mietvertrag_per_2) as v2
   ON v1.mietvertrag_nr=v2.mietvertrag_nr_alt and v1.mandant_id=v2.mandant_id
   ) as v15
   ON v3.mietvertrag_nr=v15.mietvertrag_nr and v3.mandant_id=v15.mandant_id

   UNION

   SELECT DISTINCT
   v1.mandant_id, v1.we_intreno, v1.mo_intreno, v2.mv_intreno, v3.mietvertrag_nr, v3.partner_id, v3.partner_id as konzessionaer_id, v2.dat_von, v2.dat_bis, v6.we_intreno_akt, v6.mo_intreno_akt, v6.mv_intreno_akt, v6.konzessionaer_id as konzessionaer_id_akt
   FROM dbp_view.v_immo_mietobjekt_2 v1
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 v2
   ON v1.mandant_id = v2.mandant_id and v1.mo_intreno = v2.mo_intreno
   LEFT join dbp_view.v_immo_mietvertrag_per_2 as v3
   ON v3.mandant_id = v2.mandant_id and v3.mv_intreno = v2.mv_intreno
   join
   (
   SELECT DISTINCT
   v11.mandant_id, v13.mietvertrag_nr, max(v11.we_intreno) as we_intreno_akt, max(v11.mo_intreno) as mo_intreno_akt, max(v12.mv_intreno) as mv_intreno_akt, max(v13.partner_id) as konzessionaer_id


   FROM dbp_view.v_immo_mietobjekt_2 v11
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 v12
   ON v11.mandant_id = v12.mandant_id and v11.mo_intreno = v12.mo_intreno
   LEFT join dbp_view.v_immo_mietvertrag_per_2 as v13
   ON v13.mandant_id = v12.mandant_id and v13.mv_intreno = v12.mv_intreno

   group by
   1,2
   ) as v6
   ON v3.mandant_id = v6.mandant_id and v3.mietvertrag_nr = v6.mietvertrag_nr;