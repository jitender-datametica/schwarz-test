CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_START_AUFTRAG_1
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--  ,system_id
,auftrag_id
,auftragsart_id
,dat_start
)
AS
   SELECT
   v01.mandant_id, v01.auftrag_id, v01.auftragsart_id, v02.dat_start
   FROM dbp_view.v_flw_auftrag_1 v01

   -- Ermittlung des Start-Datums (Eckstarttermin)
   JOIN
   dbp_view.v_flw_auftrag_pps_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.auftrag_id = v02.auftrag_id;