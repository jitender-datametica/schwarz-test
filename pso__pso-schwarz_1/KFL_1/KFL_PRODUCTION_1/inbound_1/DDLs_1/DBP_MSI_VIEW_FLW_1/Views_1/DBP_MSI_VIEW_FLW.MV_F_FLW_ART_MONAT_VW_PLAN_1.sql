CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_ART_MONAT_VW_PLAN_1  -- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
, in_art_id
, werk_id
, gjmo
, in_vw_id
, wa_betrag_org
, wa_menge_kg
, wa_menge_bme
, wa_betrag
, wrg_id_orig
)
AS
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

   FROM DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_ART_MONAT_VW_PLAN_1   v01


   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   LEFT OUTER JOIN dbp_view.v_kurs_1 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.max_dat BETWEEN v500.dat_von AND v500.dat_bis;