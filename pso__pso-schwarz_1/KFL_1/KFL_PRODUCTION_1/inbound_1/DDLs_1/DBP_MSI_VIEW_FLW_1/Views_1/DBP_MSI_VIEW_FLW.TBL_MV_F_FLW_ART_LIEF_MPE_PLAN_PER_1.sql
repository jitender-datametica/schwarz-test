  CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_ART_LIEF_MPE_PLAN_PER_1
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, in_art_id
, in_lief_id
, werk_id
, flw_version_id
, menge
, pjwo
, pjwo_vw
,dat_aenderung
,default_wrg
,wrg_id
,bruttopreis
,nettopreis
)
AS
   SELECT
   v01.mandant_id, 
   v01.flw_art_id AS in_art_id, 
   v01.flw_lief_id AS in_lief_id, 
   v01.werk_id, 
   v01.flw_version_id,    
   v01.menge,   
   v02.pjwo, 
   v02.pjwo_vw,
   v03.dat_aenderung,
   v100.default_wrg,
   v01.wrg_id,
   v01.bruttopreis,
   v01.nettopreis
   
   FROM dbp_view.v_flw_art_lief_mpe_plan_per_1 v01

   JOIN
   (
   SELECT
   v001.dat, v001.pjwo, v002.pjwo AS pjwo_vw
   FROM dbp_view.v_tag_1 v001

   JOIN dbp_view.v_tag_1 v002
   ON v001.dat - 7 = v002.dat
   AND v001.dat <= CURRENT_DATE + 7
   GROUP BY 1,2,3
   ) v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis

   JOIN dbp_view.v_flw_art_marktpreis_per_1 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.flw_art_id = v03.flw_art_id
   AND v01.werk_id = v03.werk_id
   AND v01.flw_version_id = v03.flw_version_id
   AND v01.dat_von = v03.dat_von

   -- Ermittlung der default Waehrung
   JOIN
   dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id
 ;