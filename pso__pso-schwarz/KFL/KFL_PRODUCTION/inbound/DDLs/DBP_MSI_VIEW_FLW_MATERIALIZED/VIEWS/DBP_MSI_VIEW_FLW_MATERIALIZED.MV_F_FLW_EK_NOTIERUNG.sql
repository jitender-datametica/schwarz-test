create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_EK_NOTIERUNG(
	MANDANT_ID,
	EK_NOTIERUNG_ID,
	DAT,
	PLAN_FG,
	PJWO,
	BETRAG,
	WRG_ID
) as
   SELECT
   v01.mandant_id, 
   v01.ek_notierung_id, 
   v01.dat, 
   v01.plan_fg, 
   v01.pjwo, 
   
   CASE
   
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN v01.betrag
   
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( v01.betrag / v500.umrechnungskurs)
   
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN v01.betrag * v500.umrechnungskurs
   
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN v01.betrag
   END AS betrag, 
	v400.wrg_id

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_EK_NOTIERUNG v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON V300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis;