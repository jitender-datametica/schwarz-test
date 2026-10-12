CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_AUFTRAG_PPS
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,auftrag_id
,in_art_id
,dat_ende
,dat_start

)
AS
   SELECT mandant_id, auftrag_id, flw_art_id AS in_art_id, dat_ende, dat_start

   FROM dbp_view.v_flw_auftrag_pps;