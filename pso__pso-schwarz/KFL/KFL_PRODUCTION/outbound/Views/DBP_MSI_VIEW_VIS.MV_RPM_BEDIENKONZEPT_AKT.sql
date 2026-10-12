CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_rpm_bedienkonzept_akt (mandant_id, wup_id, bedienkonzept_id,
dat_bedienkonzept, bedienkonzept_auspr_id) AS SELECT V0.mandant_id,
 V0.wup_id,
 V01.bedienkonzept_id,
 V01.dat_bedienkonzept,
 V01.bedienkonzept_auspr_id
FROM kfl_production_dbp_view.v_rpm_immobilie_per AS V0
 INNER JOIN kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per AS V01 ON V0.rpm_hierarchie_id = V01.rpm_hierarchie_id
  
WHERE V0.dat_bis = DATE '9999-12-31'
 AND V01.dat_bis = DATE '9999-12-31'
 AND V01.rpm_tab_id = 3
UNION ALL
SELECT mandant_id,
 wup_id,
 11 AS bedienkonzept_id,
 bed_imbiss_dat,
 1 AS bedienkonzept_auspr_id
FROM kfl_production_dbp_msi_v_view.v_wup_denorm
WHERE mandant_id = 1
 AND bed_imbiss_fg = 1;