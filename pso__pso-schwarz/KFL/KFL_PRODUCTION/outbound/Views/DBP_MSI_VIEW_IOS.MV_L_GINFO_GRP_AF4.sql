CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_ginfo_grp_af4 AS SELECT V01.grp_1_id,
 V01.grp_2_id,
 V01.grp_3_id,
 V01.grp_4_id,
 V02.grp_bez
FROM kfl_production_dbp_msi_v_view.v_ginfo_grp_aussen_flaechen AS V01
 INNER JOIN kfl_production_dbp_msi_v_view.v_l_ginfo_grp AS V02 ON V01.grp_4_id = V02.grp_id AND V02.ebene_id = 4
GROUP BY V01.grp_1_id,
 V01.grp_2_id,
 V01.grp_3_id,
 V01.grp_4_id,
 V02.grp_bez;