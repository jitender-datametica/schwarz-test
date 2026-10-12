CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_schwellwert_wtag_2 AS SELECT mandant_id,
 vertrieb_fg,
 wtag_id,
 sw_soll,
 0.00 AS sw_rot2_ab,
 sw_rot_bis AS sw_rot1_bis,
  CASE
  WHEN sw_rot_bis BETWEEN 0.01 AND 99.99
  THEN sw_rot_bis + 0.01
  ELSE sw_rot_bis
  END AS sw_gelb2_ab,
 sw_gelb_bis AS sw_gelb1_bis,
  CASE
  WHEN sw_gelb_bis BETWEEN 0.01 AND 99.99
  THEN sw_gelb_bis + 0.01
  ELSE sw_gelb_bis
  END AS sw_gruen_ab,
  CASE
  WHEN sw_gelb_ab BETWEEN 0.01 AND 99.99
  THEN sw_gelb_ab - 0.01
  ELSE sw_gelb_ab
  END AS sw_gruen_bis,
 sw_gelb_ab AS sw_gelb1_ab,
  CASE
  WHEN sw_rot_ab BETWEEN 0.01 AND 99.99
  THEN sw_rot_ab - 0.01
  ELSE sw_rot_ab
  END AS sw_gelb2_bis,
 sw_rot_ab AS sw_rot1_ab,
 100.00 AS sw_rot2_bis
FROM kfl_production_dbp_view.v_sb_schwellwert_wtag_2 AS V01;