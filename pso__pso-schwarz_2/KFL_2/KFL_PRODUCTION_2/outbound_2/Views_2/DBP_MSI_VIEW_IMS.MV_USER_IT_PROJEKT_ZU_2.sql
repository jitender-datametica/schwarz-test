CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_user_it_projekt_zu_2 (user_id, it_projekt_id) AS SELECT LOWER(user_id
  ) AS user_id,
 it_projekt_id
FROM kfl_production_dbp_security.l_ims_user_it_projekt_2 AS V01;