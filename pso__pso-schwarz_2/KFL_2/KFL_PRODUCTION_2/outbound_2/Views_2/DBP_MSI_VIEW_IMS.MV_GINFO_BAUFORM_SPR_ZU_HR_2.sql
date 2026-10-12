CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_ginfo_bauform_spr_zu_hr_2 AS SELECT DE.ginfo_bauform_id,
 COALESCE(ls.ginfo_bauform_bez, DE.ginfo_bauform_bez) AS ginfo_bauform_bez
FROM kfl_production_dbp_view.v_ginfo_bauform_spr_zu_2 AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_ginfo_bauform_spr_zu_2
  WHERE spr_id = 65) AS ls ON DE.ginfo_bauform_id = ls.ginfo_bauform_id
WHERE DE.spr_id = 22;