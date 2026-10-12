CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_ROHERTRAG_PLAN_IST_2
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
, in_art_id
, gjmo
, plan_fg
, werk_id
, rohertrag_betrag_org
, rohertrag_betrag
,  wrg_id_org
)
AS
   SELECT
   v01.mandant_id, 
   v01.in_art_id AS in_art_id, 
   gjmo, 
   plan_fg, 
   werk_id, 
   v01.rohertrag_betrag_org AS rohertrag_betrag_org, -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
   
   CAST(
   CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN rohertrag_betrag_org
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( rohertrag_betrag_org / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN rohertrag_betrag_org * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN rohertrag_betrag_org
   END AS DECIMAL(18,6))
   AS rohertrag_betrag, 
   
	v01.wrg_id  AS wrg_id_org

   FROM DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_ROHERTRAG_PLAN_IST_2 v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
  
   LEFT OUTER JOIN dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.max_dat BETWEEN v500.dat_von AND v500.dat_bis;