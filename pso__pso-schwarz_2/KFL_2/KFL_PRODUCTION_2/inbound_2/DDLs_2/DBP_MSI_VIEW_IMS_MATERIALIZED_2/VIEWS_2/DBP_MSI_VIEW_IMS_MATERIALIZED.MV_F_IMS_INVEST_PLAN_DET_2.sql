create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_F_IMS_INVEST_PLAN_DET_2(
	MANDANT_ID,
	GJ,
	HOCHRECHNUNG_FG,
	BERICHTS_POS_INVEST_GRP_ID,
	PLAN_BETRAG,
	PSP_ID,
	SPARTE_ID
) as














   SELECT

   v01.mandant_id,
   v01.gj,
   v01.hr_plan_gesamt_kz AS hochrechnung_fg,
   v01.berichts_pos_invest_grp_id,
   CASE WHEN v100.wrg_typ_id = 1
   THEN v01.plan_betrag
   ELSE v01.plan_betrag * v300.umrechnungskurs
   END AS plan_betrag,
   v01.psp_id,
   
   CASE WHEN v01.sparte_id IN (4,6,8) THEN 5 ELSE v01.sparte_id END AS sparte_id


   FROM dbp_view.v_ims_invest_plan_det_2 v01
   
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v100
   
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v200

   
   JOIN
   dbp_view.v_kurs_2 v300
   ON    v01.wrg_id = v300.von_wrg_id
   AND CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
   AND v200.kurstyp_id = v300.kurstyp_id
   AND v300.nach_wrg_id = 'EUR'

   
   JOIN
   dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v100.wrg_typ_id = v400.wrg_typ_id;