-- ,rpm_tab_id
 /* ,bedienkonzept_auspr_bez */ CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bedienkonzept_1 (rpm_immobilie_id
, dat_von, dat_bis, bedienkonzept_id, bedienkonzept_bez, dat_bedienkonzept, bedienkonzept_auspr_id) AS SELECT V01.rpm_hierarchie_id
  AS rpm_immobilie_id,
 V06.dat AS dat_von,
 V06.dat AS dat_bis,
 V01.bedienkonzept_id,
 V02.bedienkonzept_bez,
 V01.dat_bedienkonzept,
 V01.bedienkonzept_auspr_id /* ,v03.bedienkonzept_auspr_bez */
FROM kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_bedienkonzept_1 AS V02 ON V01.bedienkonzept_id = V02.bedienkonzept_id
 INNER JOIN kfl_production_dbp_view.v_l_bedienkonzept_auspr_1 AS V04 ON V02.bedienkonzept_id = V04.bedienkonzept_id AND
   V01.bedienkonzept_auspr_id = V04.bedienkonzept_auspr_id
 INNER JOIN kfl_production_dbp_view.v_l_rpm_tab_1 AS V05 ON V05.rpm_tab_bez = 'INM_INITIATIVE' AND V01.rpm_tab_id = V05.rpm_tab_id
   
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V06 ON V06.dat BETWEEN V01.dat_von AND V01.dat_bis AND V06.dat <=
   CURRENT_DATE /* WHERE  v03.spr_id = 22 */ -- AND v01.dat_bis = 80991231
;