CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_KONDIT_DET_NOTIERUNG AS
-- 20220317 SPEC0054764 richternic: Neuanlage
SELECT 
v01.mandant_id
,v01.werk_id
,v01.flw_lief_id AS in_lief_id
,v01.flw_art_id AS in_art_id
,v01.loesch_fg
,v01.konditionsart_id
,v01.dat_von
,v01.dat
,v01.kondition_id
--,v01.default_wrg
--,v01.KONDITION_EINH_ID 
--,v01.betrag_kondition
---
, CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.KONDITION_EINH_ID <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN v01.betrag_kondition
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.KONDITION_EINH_ID <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( v01.betrag_kondition / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.KONDITION_EINH_ID = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN v01.betrag_kondition * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.KONDITION_EINH_ID = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN v01.betrag_kondition
   END AS betrag_kondition 
---
---Fleisch_art
,v01.Fleisch_Kategorie_ID
--,v01.Fleisch_Kategorie
---Prüfen um was es sich handelt 
,v01.KPI_Kategorie_ID
--,v01.KPI_Kategorie
                             
-- Notierungen 
/*,v01.betrag_notierung_schwein
,v01.betrag_notierung_schwein_plan
,v01.betrag_notierung_rind
,v01.betrag_notierung_rind_plan
,v01.betrag_notierung_kuh
,v01.betrag_notierung_faerse
-- Preise 
,v01.betrag_preis_schwein
,v01.betrag_preis_rind
,v01.betrag_preis_verarbeitungsware
,v01.betrag_preis_faerse*/


FROM DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_KONDIT_DET_NOTIERUNG  v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON V300.kurstyp_id = v500.kurstyp_id
   AND v01.KONDITION_EINH_ID = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis;