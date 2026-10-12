CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_user_it_projekt_zu_cross (it_projekt_id, user_id, sec_fg) AS
SELECT V01.it_projekt_id,
 LOWER(v02.user_id) AS user_id,
  CASE
  WHEN V03.user_id IS NULL
  THEN 0
  ELSE 1
  END AS sec_fg
FROM kfl_production_dbp_view.v_it_projekt AS V01
 INNER JOIN (SELECT user_id
  FROM kfl_production_dbp_security.l_msi_user
  WHERE msi_produkt_bez = 'IMS') AS v02 ON TRUE
 LEFT JOIN kfl_production_dbp_security.l_ims_user_it_projekt AS V03 ON V01.it_projekt_id = V03.it_projekt_id AND v02.user_id
    = V03.user_id;