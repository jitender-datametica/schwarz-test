CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_SCHNITTLISTE_DET_2
-- 26.10.2011 system_id entfernt
-- 07.12.2011 AL Einschraenkung auf sek_schl_typ_id in ('M', 'P')
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,schnittliste_id
,schnitt_id
,sek_schl_typ_id
,sek_schl_id
,schnitt_verwendung_prozent
)
AS
   SELECT mandant_id, schnittliste_id, schnitt_id, sek_schl_typ_id, sek_schl_id, schnitt_verwendung_prozent
   FROM dbp_view.v_flw_schnittliste_det_2
   WHERE sek_schl_typ_id in ('M', 'P');