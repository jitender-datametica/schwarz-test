CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_sortiment_user_wg_zu (mandant_id, user_id, wg_id,
fl_superuser) AS SELECT mandant_id,
 b1 AS user_id,
 wg_id,
 fl_superuser
FROM (SELECT t4.mandant_id,
    t4.b1,
    t4.wg_id,
    t4.fl_superuser
   FROM (SELECT SU.mandant_id,
      TRIM(SU.user_id) AS b1,
      O.owg_id AS wg_id,
      1 AS fl_superuser
     FROM kfl_production_dbp_security.sortiment_user_wg_zu AS SU
      INNER JOIN kfl_production_dbp_view.v_owg_per AS O ON SU.mandant_id = O.mandant_id
     WHERE SU.wg_id = - 999
      AND (SU.mandant_id, SU.user_id) NOT IN (SELECT (mandant_id, user_id)
        FROM (SELECT DISTINCT mandant_id,
           user_id
          FROM kfl_production_dbp_security.user_zek_zu) AS t0)
     GROUP BY SU.mandant_id,
      b1,
      wg_id,
      fl_superuser) AS t4
   UNION DISTINCT
   SELECT t10.mandant_id,
    t10.b1,
    t10.wg_id,
    0 AS fl_superuser
   FROM (SELECT A.mandant_id,
      TRIM(A.user_id) AS b1,
      b.owg_id AS wg_id
     FROM kfl_production_dbp_security.user_zek_zu AS A
      INNER JOIN (SELECT B.mandant_id,
        B.zek_id,
        C.wg_id,
        D.owg_id
       FROM kfl_production_dbp_view.v_art AS B
        INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS C ON B.mandant_id = C.mandant_id AND B.art_id = C.art_id
        INNER JOIN kfl_production_dbp_view.v_wg_per AS D ON C.mandant_id = D.mandant_id AND C.wg_id = D.wg_id
       WHERE C.arthiertyp_id = 2
        AND C.dat_bis = DATE '9999-12-31'
        AND B.zek_id <> ''
        AND D.dat_bis = DATE '9999-12-31'
        AND B.loesch_id NOT IN ('L')
       GROUP BY B.mandant_id,
        B.zek_id,
        C.wg_id,
        D.owg_id) AS b ON A.mandant_id = b.mandant_id AND A.zek_id = b.zek_id
     GROUP BY A.mandant_id,
      b1,
      wg_id) AS t10) AS t12;