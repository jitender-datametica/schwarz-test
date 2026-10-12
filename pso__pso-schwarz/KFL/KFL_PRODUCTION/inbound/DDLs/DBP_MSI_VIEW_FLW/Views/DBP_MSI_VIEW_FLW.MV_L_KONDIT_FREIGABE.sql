CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_KONDIT_FREIGABE
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,kondition_id
,in_verkaufsorganisation_id
,in_vw_id
,in_art_id
,konditionsart_id
,applikation_id
,preisliste_typ_id
,wrg_id
,freigabe_status_id
,dat_von
,dat_bis
,bearbeitung_status_id
)
AS
   SELECT mandant_id, kondition_id, flw_verkaufsorganisation_id AS in_verkaufsorganisation_id, flw_vw_id AS in_vw_id, flw_art_id AS in_art_id, konditionsart_id, applikation_id, preisliste_typ_id, wrg_id, freigabe_status_id, dat_von, dat_bis, bearbeitung_status_id
   FROM dbp_view.v_flw_kondit_freigabe;