create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_OBLIGO(
	MANDANT_ID,
	PSP_ID,
	PROJEKT_TYP_ID,
	GJ,
	DAT_BUCH,
	DAT_BELEG,
	REF_BELEG_ID,
	REF_BELEG_POS_ID,
	IN_LIEF_ID,
	BETRAG,
	AUFTRAG_ID,
	DAT_VON,
	DAT_BIS,
	BESTELL_TEXT,
	BETRAG_PLAN
) as
   SELECT
   v01.mandant_id, v01.psp_id, v03.ims_projekt_typ_id AS projekt_typ_id, v01.gj, v01.dat_buch, v01.dat_beleg, v01.ref_beleg_id, v01.ref_beleg_pos_id, COALESCE(v01.in_lief_id,-1) AS in_lief_id, CASE WHEN v400.wrg_typ_id = 1 THEN v01.betrag ELSE v01.betrag * umrechnungskurs END AS betrag, v01.auftrag_id, v01.dat_von, v01.dat_bis, v01.bestell_text, v01.betrag_plan

   FROM dbp_view.v_obligo_per v01

   JOIN dbp_view.v_in_psp_element v02
   ON v01.psp_id = v02.psp_id
   AND v01.mandant_id = v02.mandant_id

   JOIN dbp_view.v_in_projekt v03
   ON v02.in_projekt_id = v03.in_projekt_id
   AND v02.mandant_id = v03.mandant_id

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   
   JOIN
   dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   
   AND v500.dat_bis = '9999-12-31';