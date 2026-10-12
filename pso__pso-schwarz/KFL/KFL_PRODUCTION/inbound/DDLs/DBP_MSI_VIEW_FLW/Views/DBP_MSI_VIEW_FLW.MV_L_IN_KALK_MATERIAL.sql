CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_KALK_MATERIAL
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,kalk_id
,kalkulationsart_id
,dat_kalk
,kalk_version_id
,bewertung_variante_id
,in_art_id
,werk_id
,dat_kalk_ab
,dat_kalk_bis


)
AS
   SELECT mandant_id, kalk_id, kalkulationsart_id, dat_kalk, kalk_version_id, bewertung_variante_id, flw_art_id AS in_art_id, werk_id, dat_kalk_ab, dat_kalk_bis
   FROM dbp_view.v_flw_kalk_erzeugnis;