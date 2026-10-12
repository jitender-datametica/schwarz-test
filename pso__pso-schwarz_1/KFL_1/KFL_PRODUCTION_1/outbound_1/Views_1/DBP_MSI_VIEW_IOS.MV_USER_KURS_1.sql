CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_user_kurs_1 AS SELECT DISTINCT mandant_id,
 wrg_typ_id,
 von_wrg_id,
 nach_wrg_id,
 umrechnungskurs,
 kurs_1,
 nach_wrg_id AS wrg_id,
 umrechnungskurs AS faktor
FROM (SELECT M.mandant_id,
    W.wrg_typ_id,
    K.von_wrg_id,
    K.nach_wrg_id,
    K.umrechnungskurs,
    ROUND(1 / K.umrechnungskurs, 5) AS kurs_1
   FROM kfl_production_dbp_view.v_kurs_1 AS K
    INNER JOIN kfl_production_dbp_msi_v_view.v_user_wrg_typ_zu_1 AS W ON W.wrg_typ_id = 0
    INNER JOIN kfl_production_dbp_view.v_mandant_1 AS M ON K.von_wrg_id = M.default_wrg
   WHERE K.kurstyp_id = 3
    AND K.dat_bis = DATE '9999-12-31'
   UNION ALL
   SELECT M.mandant_id,
    W.wrg_typ_id,
    K.von_wrg_id,
    K.von_wrg_id AS nach_wrg_id,
    1 AS umrechnungskurs,
    1 AS kurs_1
   FROM kfl_production_dbp_view.v_kurs_1 AS K
    INNER JOIN kfl_production_dbp_msi_v_view.v_user_wrg_typ_zu_1 AS W ON W.wrg_typ_id = 1
    INNER JOIN kfl_production_dbp_view.v_mandant_1 AS M ON K.von_wrg_id = M.default_wrg
   WHERE K.kurstyp_id = 3
    AND K.dat_bis = DATE '9999-12-31') AS sub01;