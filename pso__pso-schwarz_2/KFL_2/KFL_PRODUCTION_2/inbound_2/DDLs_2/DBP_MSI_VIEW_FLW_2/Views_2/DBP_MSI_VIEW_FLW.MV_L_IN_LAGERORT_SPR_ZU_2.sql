CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LAGERORT_SPR_ZU_2
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,werk_id
,lagerort_id
,lagerort_bez
)
AS
   SELECT mandant_id, werk_id, lagerort_id, lagerort_bez
   FROM dbp_view.v_flw_lagerort_spr_zu_2;