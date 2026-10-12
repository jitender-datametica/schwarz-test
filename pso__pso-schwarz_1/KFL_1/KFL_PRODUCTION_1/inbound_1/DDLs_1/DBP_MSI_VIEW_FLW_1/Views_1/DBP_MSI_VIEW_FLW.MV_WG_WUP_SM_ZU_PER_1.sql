CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WG_WUP_SM_ZU_PER_1
-- 05.05.2014 twie: Zuordnung WUP_1, WG, Sortimentsstufe, View nicht historisiert sondern aktuelle Sicht
--                            Zu WUP_1 zusaetzlich den Kunde ermitteln, da die meisten Metriken nicht auf Ebene WUP_1 (Markt) vorliegen
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

(
mandant_id
,wup_id
,nb_id
,in_kunde_id
,wg_id
,arthiertyp_id
,sm_id
,dat_von
,dat_bis
)
AS
   SELECT
  v01.mandant_id, v01.wup_id, v01.nb_id, v02.flw_kunde_id AS in_kunde_id, v01.wg_id, v01.arthiertyp_id, v01.sm_id, v01.dat_von, v01.dat_bis

   FROM dbp_view.v_sm_wup_wg_zu_per_1 v01
   LEFT JOIN dbp_view.v_flw_kunde_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   WHERE v01.mandant_id IN (1,2)
   AND v01.arthiertyp_id = 2
   AND v01.dat_bis = '9999-12-31'

   -- 20100330 Filterung der IWT Betriebe
   AND v01.nb_id <> 99;