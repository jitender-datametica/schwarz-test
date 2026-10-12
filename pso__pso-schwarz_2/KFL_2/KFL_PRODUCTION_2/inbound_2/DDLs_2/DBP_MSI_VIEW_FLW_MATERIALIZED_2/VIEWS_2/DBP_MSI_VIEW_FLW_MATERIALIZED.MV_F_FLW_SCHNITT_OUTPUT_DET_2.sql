create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_SCHNITT_OUTPUT_DET_2(
	MANDANT_ID,
	IN_ART_ID,
	SCHNITT_ID,
	SEK_SCHL_TYP_ID,
	SEK_SCHL_ID,
	SCHNITT_POS_ID,
	WRG_ID,
	MENGE_SCHNITT,
	BETRAG_SCHNITT_OUTPUT
) as
   SELECT
   v01.mandant_id, 
   v01.in_art_id AS in_art_id, 
   v01.schnitt_id, 
   v01.sek_schl_typ_id, 
   v01.sek_schl_id, 
   v01.schnitt_pos_id, 
   v400.wrg_id, 
   v01.menge_schnitt, 
   CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.betrag_schnitt_output,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.betrag_schnitt_output,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.betrag_schnitt_output,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.betrag_schnitt_output,0)
   END
   AS DECIMAL(18,6))
   AS betrag_schnitt_output
  
   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_SCHNITT_OUTPUT_DET_2 v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND (CASE
   WHEN v01.sek_schl_typ_id = 'M' THEN v01.dat_kalk_ab_v02
   WHEN v01.sek_schl_typ_id = 'P' THEN v01.dat_kalk_ab_v03
   END)
   BETWEEN v500.dat_von AND v500.dat_bis;