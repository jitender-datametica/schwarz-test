CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_user_it_projekt_zu_1 (user_id, it_projekt_id) AS SELECT LOWER(user_id
  ) AS user_id,
 it_projekt_id
FROM kfl_production_dbp_security.l_ims_user_it_projekt_1 AS V01;