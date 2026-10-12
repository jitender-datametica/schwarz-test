CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_WUP_VK_PER
(
mandant_id
,art_id
,wup_id
,nb_id
,dat
,dat_von
,dat_bis
,dat_zeitraum
,vk_brutto
,wrg_id


)
AS
   SELECT
   v01.mandant_id, v01.art_id, v01.wup_id, 0, v02.dat, v01.dat_von, v01.dat_bis, CAST (v01.dat_von   AS VARCHAR ) || ' - ' || CAST( v01.dat_bis   AS VARCHAR), v01.vk_brutto, v01.wrg_id

   FROM dbp_view.v_art_wup_vk_per v01

   JOIN dbp_msi_view_wwc.mv_tag_listung v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis

   ;