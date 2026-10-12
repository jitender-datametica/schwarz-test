create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_KALK_PREISE_2(
	UMRECHNUNGSFAKTOR,
	MANDANT_ID,
	SCHNITTLISTE_ID,
	SEK_SCHL_TYP_ID,
	SEK_SCHL_ID,
	IN_ART_ID,
	INPUT_MATERIAL_TYP_ID,
	MENGE,
	GESAMT_WERT,
	MENGE_DME,
	DME_EINH_ID,
	WRG_ID,
	PREIS_KG
) as
   SELECT

   CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN 1
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( 1 / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN  v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN 1
   END AS umrechnungsfaktor, 
	v01.mandant_id, 
	v01.schnittliste_id, 
	v01.sek_schl_typ_id, 
	v01.sek_schl_id, 
	v01.in_art_id AS in_art_id, 
	v01.input_material_typ_id, 
	v01.menge, 
	CAST(v01.gesamt_wert * umrechnungsfaktor AS DECIMAL(18,6)) AS gesamt_wert, 
	v01.menge_dme, 
	v01.dme_einh_id, 
	v01.wrg_id, 
	CAST(COALESCE(v01.preis_kg,0) * umrechnungsfaktor AS DECIMAL(18,6)) AS preis_kg

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_KALK_PREISE_2 v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND (
   CASE
   WHEN v01.sek_schl_typ_id = 'M' THEN v01.dat_kalk_ab_v02
   WHEN v01.sek_schl_typ_id = 'P' THEN v01.dat_kalk_ab_v03
   END)
   BETWEEN v500.dat_von AND v500.dat_bis;