create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_SCHNITT_INPUT(
	MANDANT_ID,
	SCHNITT_ID,
	SEK_SCHL_TYP_ID,
	SEK_SCHL_ID,
	IN_ART_ID,
	WERK_ID,
	DAT_VON,
	DAT_BIS,
	MATERIAL_EINZEL_KOSTEN,
	WRG_ID
) as
   SELECT
   mandant_id, 
   schnitt_id, 
   sek_schl_typ_id, 
   sek_schl_id, 
   in_art_id AS in_art_id, 
   werk_id, 
   dat_von, 
   dat_bis, 
   material_einzel_kosten, 
   wrg_id
   FROM
   (
   SELECT
   v01.mandant_id, 
   v01.schnitt_id, 
   v01.sek_schl_typ_id, 
   v01.sek_schl_id, 
   v01.in_art_id, 
   v01.werk_id, 
   v01.dat_von, 
   v01.dat_bis, 
      
   CAST(
   CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.wrg_id_v01 <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.material_einzel_kosten,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id_v01 <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.material_einzel_kosten,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id_v01 = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.material_einzel_kosten,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id_v01 = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.material_einzel_kosten,0)
   END
   AS DECIMAL(18,6)
   ) AS material_einzel_kosten, 
     v400.wrg_id AS wrg_id

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_SCHNITT_INPUT v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id_v01 = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_von BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.sek_schl_typ_id in ('M', 'P')
   ) dt1;