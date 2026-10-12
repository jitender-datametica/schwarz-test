CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_user_it_projekt_zu (user_id, it_projekt_id) AS SELECT LOWER(user_id
  ) AS user_id,
 it_projekt_id
FROM kfl_production_dbp_security.l_ims_user_it_projekt AS V01;