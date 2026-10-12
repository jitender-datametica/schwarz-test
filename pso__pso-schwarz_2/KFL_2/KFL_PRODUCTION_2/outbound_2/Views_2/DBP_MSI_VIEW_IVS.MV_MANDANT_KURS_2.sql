CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_mandant_kurs_2 AS SELECT M.mandant_id,
 M.default_wrg AS land_wrg_id,
 K.nach_wrg_id AS von_wrg_id,
 K.von_wrg_id AS nach_wrg_id,
 TRUNC(CAST(1 / K.umrechnungskurs AS BIGNUMERIC)) AS umrechnungskurs,
 SUBSTR('LAND_2', 1, 4) AS wrg_typ_id
FROM kfl_production_dbp_view.v_mandant_2 AS M
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS K ON K.dat_bis = DATE '9999-12-31' AND K.kurstyp_id = 3 AND M.default_wrg
    = K.von_wrg_id AND K.von_wrg_id <> K.nach_wrg_id
UNION ALL
SELECT M.mandant_id,
 M.default_wrg AS land_wrg_id,
 K.nach_wrg_id AS von_wrg_id,
 K.nach_wrg_id,
 1 AS umrechnungskurs,
 SUBSTR('EURO', 1, 4) AS wrg_typ_id
FROM kfl_production_dbp_view.v_mandant_2 AS M
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS K ON K.dat_bis = DATE '9999-12-31' AND K.kurstyp_id = 3 AND M.default_wrg
   = K.von_wrg_id;