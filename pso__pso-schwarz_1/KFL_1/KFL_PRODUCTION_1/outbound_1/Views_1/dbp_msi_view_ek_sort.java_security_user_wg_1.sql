CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_security_user_wg_1 (mandant_id, user_id, wg_id) AS SELECT
 t4.mandant_id,
 t4.b1 AS user_id,
 t4.wg_id
FROM (SELECT SU.mandant_id,
   TRIM(SU.user_id) AS b1,
   O.wg_id
  FROM kfl_production_dbp_security.sortiment_user_wg_zu_1 AS SU
   INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS O ON SU.mandant_id = O.mandant_id
  WHERE SU.wg_id = - 999
   AND (SU.mandant_id, SU.user_id) NOT IN (SELECT (mandant_id, user_id)
     FROM (SELECT DISTINCT mandant_id,
        user_id
       FROM kfl_production_dbp_security.user_zek_zu_1) AS t0)
  GROUP BY SU.mandant_id,
   b1,
   O.wg_id) AS t4
UNION DISTINCT
SELECT t10.mandant_id,
 t10.b1,
 t10.wg_id
FROM (SELECT A.mandant_id,
   TRIM(A.user_id) AS b1,
   b.wg_id
  FROM kfl_production_dbp_security.user_zek_zu_1 AS A
   INNER JOIN (SELECT B.mandant_id,
     B.zek_id,
     C.wg_id
    FROM kfl_production_dbp_view.v_art_1 AS B
     INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS C ON B.mandant_id = C.mandant_id AND B.art_id = C.art_id
    WHERE C.arthiertyp_id = 2
     AND C.dat_bis = DATE '9999-12-31'
     AND B.zek_id <> ''
     AND B.loesch_id NOT IN ('L')
    GROUP BY B.mandant_id,
     B.zek_id,
     C.wg_id) AS b ON A.mandant_id = b.mandant_id AND A.zek_id = b.zek_id
  GROUP BY A.mandant_id,
   b1,
   b.wg_id) AS t10;