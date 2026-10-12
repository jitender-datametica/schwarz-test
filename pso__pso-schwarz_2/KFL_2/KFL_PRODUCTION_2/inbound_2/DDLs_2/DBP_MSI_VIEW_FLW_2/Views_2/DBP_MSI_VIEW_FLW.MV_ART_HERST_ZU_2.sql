CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_ART_HERST_ZU_2
-- 10.01.2014 twie: Neue View fuer RLZ dz. (mhd_zeitraum_de) aus AIS_DE uebernommen
-- alle Materialien ausgeben, wenn vorhanden RLZ dz. sonst -1 als Dummy_2
-- 25.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
,in_art_id
,art_id
,herst_id
,gp_art_id
,mhd_zeitraum_dz
)
AS
   SELECT
    v01.mandant_id
  , v01.flw_art_id AS in_art_id
  , v01.art_id
  , COALESCE (v02.herst_id, '-1') AS herst_id
  , COALESCE(v02.gp_art_id,'-1') AS gp_art_id
  , COALESCE(v02.mhd_zeitraum_dz, '-1') AS mhd_zeitraum_dz
   FROM dbp_msi_view_flw.mv_l_in_art_2 v01
   LEFT OUTER JOIN dbp_view.v_art_gp_zu_per_2 v02
   ON v01.art_id  = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   AND v02.dat_bis = '9999-12-31';