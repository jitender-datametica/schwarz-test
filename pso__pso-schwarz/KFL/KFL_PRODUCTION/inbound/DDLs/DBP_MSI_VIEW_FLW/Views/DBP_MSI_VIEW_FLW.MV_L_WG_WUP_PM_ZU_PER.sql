CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_WG_WUP_PM_ZU_PER
-- 26.10.2011 system_id entfernt
-- 22.10.2013 twie: Join zu in_kunde vereinfacht ueber wup_id
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
in_kunde_id
,nb_id
,arthiertyp_id
,wg_id
,pm_id
,dat_von
,dat_bis
,mandant_id
--,system_id
)

AS
   SELECT
  v02.flw_kunde_id AS in_kunde_id, v01.nb_id, v01.arthiertyp_id, v01.wg_id, v01.pm_id, v01.dat_von, v01.dat_bis, v01.mandant_id
   --,v02.system_id
   FROM
   dbp_view.v_pm_wup_wg_zu_per v01
   LEFT JOIN dbp_view.v_flw_kunde v02
   ON v02.wup_id = v01.wup_id
   AND v02.mandant_id = v01.mandant_id

   WHERE v01.mandant_id=1
   AND v01.arthiertyp_id=2
   AND v01.dat_bis > CURRENT_DATE
   AND v01.nb_id = 0;