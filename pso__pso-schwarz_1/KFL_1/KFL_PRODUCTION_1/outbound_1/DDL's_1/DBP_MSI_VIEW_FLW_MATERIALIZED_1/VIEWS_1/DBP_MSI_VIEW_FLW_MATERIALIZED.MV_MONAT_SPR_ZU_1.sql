CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_monat_spr_zu_1 (mo_gj, mo_bez) AS SELECT CASE
  WHEN V01.mo_id >= 3
  THEN V01.mo_id - 2
  ELSE V01.mo_id + 10
  END AS mo_gj,
 V01.mo_bez
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;