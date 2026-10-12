CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_L_LAGERORT_2
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,werk_id
,lagerort_id
)
AS
   SELECT mandant_id, werk_id, lagerort_id
   FROM dbp_view.v_flw_l_lagerort_2;