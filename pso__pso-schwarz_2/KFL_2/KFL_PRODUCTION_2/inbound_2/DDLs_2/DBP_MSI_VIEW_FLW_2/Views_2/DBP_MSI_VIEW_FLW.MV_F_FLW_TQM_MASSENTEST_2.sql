CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_TQM_MASSENTEST_2
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
--system_id
mandant_id
,in_lief_id
,in_art_id
,dat_test
,pc_id
,krk_id
,anz_stck_geprueft
,anz_kf_fehler
,anz_vk_fehler
)
AS
   SELECT
   --v01.system_id
   v01.mandant_id, v01.flw_lief_id AS in_lief_id, v01.flw_art_id AS in_art_id, v01.dat_test, v01.pc_id, v01.krk_id, v01.anz_stck_geprueft, v01.anz_kf_fehler, v01.anz_vk_fehler
   FROM dbp_view.v_flw_tqm_massentest_2 v01;