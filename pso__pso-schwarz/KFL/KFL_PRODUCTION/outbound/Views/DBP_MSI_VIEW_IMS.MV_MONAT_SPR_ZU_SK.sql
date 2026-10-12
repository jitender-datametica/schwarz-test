CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_monat_spr_zu_sk (mo_gj, mo_bez) AS SELECT CASE
  WHEN mo_id >= 3
  THEN mo_id - 2
  ELSE mo_id + 10
  END AS mo_gj,
 mo_bez
FROM kfl_production_dbp_view.v_monat_spr_zu AS V01
WHERE spr_id = 108;