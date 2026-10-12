CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per_1 AS SELECT bedienkonzept_id,
 rpm_hierarchie_id,
 dat_von,
 rpm_tab_id,
 dat_bis,
 dat_bedienkonzept,
 bedienkonzept_auspr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_hier_bed_konzept_zu_per_1;