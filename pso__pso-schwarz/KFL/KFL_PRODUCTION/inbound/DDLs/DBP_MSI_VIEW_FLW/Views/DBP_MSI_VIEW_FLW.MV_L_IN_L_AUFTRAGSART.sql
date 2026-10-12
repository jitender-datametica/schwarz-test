CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_L_AUFTRAGSART
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,auftragsart_id

)
AS
   SELECT mandant_id, auftragsart_id
   FROM dbp_view.v_flw_l_auftragsart;