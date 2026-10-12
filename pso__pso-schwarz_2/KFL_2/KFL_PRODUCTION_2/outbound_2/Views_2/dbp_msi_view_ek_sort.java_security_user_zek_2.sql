CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_security_user_zek_2 (mandant_id, user_id, zek_id) AS
SELECT t9.mandant_id,
 t9.b1 AS user_id,
 t9.zek_id
FROM (SELECT SU.mandant_id,
   TRIM(SU.user_id) AS b1,
   a.zek_id
  FROM kfl_production_dbp_security.sortiment_user_wg_zu_2 AS SU
   INNER JOIN (SELECT mandant_id,
     zek_id
    FROM kfl_production_dbp_view.v_art_2
    WHERE dat_bis = DATE '9999-12-31'
    GROUP BY mandant_id,
     zek_id) AS a ON SU.mandant_id = a.mandant_id
  WHERE SU.wg_id = - 999
   AND a.zek_id <> ''
   AND (a.zek_id, a.mandant_id) IN (SELECT (zek_id, mandant_id)
     FROM kfl_production_dbp_view.v_art_2
     WHERE dat_bis = DATE '9999-12-31')
   AND (SU.mandant_id, SU.user_id) NOT IN (SELECT (mandant_id, user_id)
     FROM (SELECT DISTINCT mandant_id,
        user_id
       FROM kfl_production_dbp_security.user_zek_zu_2) AS t5)
  GROUP BY SU.mandant_id,
   b1,
   a.zek_id) AS t9
UNION DISTINCT
SELECT mandant_id,
 b1,
 zek_id
FROM (SELECT mandant_id,
   TRIM(user_id) AS b1,
   zek_id
  FROM kfl_production_dbp_security.user_zek_zu_2
  WHERE zek_id <> ''
   AND (zek_id, mandant_id) IN (SELECT (zek_id, CAST(mandant_id AS BIGNUMERIC))
     FROM kfl_production_dbp_view.v_art_2
     WHERE dat_bis = DATE '9999-12-31')
  GROUP BY mandant_id,
   b1,
   zek_id) AS t15;