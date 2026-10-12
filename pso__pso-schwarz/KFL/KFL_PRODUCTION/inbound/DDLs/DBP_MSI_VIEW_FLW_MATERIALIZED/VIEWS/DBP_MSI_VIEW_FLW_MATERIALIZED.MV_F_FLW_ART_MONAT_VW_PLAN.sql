create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_ART_MONAT_VW_PLAN(
	MANDANT_ID,
	IN_ART_ID,
	WERK_ID,
	GJMO,
	IN_VW_ID,
	WA_BETRAG_ORG,
	WA_MENGE_KG,
	WA_MENGE_BME,
	WA_BETRAG,
	WRG_ID_ORIG
) as
   SELECT

   v01.mandant_id, 
   v01.in_art_id AS in_art_id, 
   v01.werk_id, 
   v01.gjmo, 
   v01.in_vw_id AS in_vw_id, 
   v01.wa_menge_kg, 
   v01.wa_menge_bme, 
   v01.wa_betrag_org AS wa_betrag_org,  -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
   
   CAST(
   CASE
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN wa_betrag_org
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( wa_betrag_org / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN  wa_betrag_org * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN wa_betrag_org
   END
   AS DECIMAL(18,6))AS wa_betrag, 
   
   v01.wrg_id AS wrg_id_orig -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_ART_MONAT_VW_PLAN   v01


   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.max_dat BETWEEN v500.dat_von AND v500.dat_bis;