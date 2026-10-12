CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_rpm_phase_spr_zu_pl_2 AS SELECT DE.rpm_phase_id,
 DE.rpm_projekt_typ_id,
  CASE
  WHEN DE.rpm_phase_id = '1'
  THEN ''
  ELSE COALESCE(ls.rpm_phase_bez, DE.rpm_phase_bez)
  END AS rpm_phase_bez
FROM kfl_production_dbp_view.v_rpm_phase_spr_zu_2 AS DE
 LEFT JOIN (SELECT rpm_phase_id,
   rpm_projekt_typ_id,
   rpm_phase_bez
  FROM kfl_production_dbp_view.v_rpm_phase_spr_zu_2
  WHERE spr_id = 90) AS ls ON DE.rpm_phase_id = ls.rpm_phase_id AND DE.rpm_projekt_typ_id = ls.rpm_projekt_typ_id
WHERE DE.spr_id = 22;