CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_ts_lin_kurs_spr_zu (mandant_id, lin_kurs_id,
mandant_lin_kurs_id, lin_kurs_bez_land) AS SELECT v1.mandant_id,
 v1.lin_kurs_id,
   SUBSTR(CAST(v1.mandant_id AS STRING), 1, 1) || ' ' || v2.lin_kurs_id AS mandant_lin_kurs_id,
   v2.lin_kurs_bez || ' ' || v3.mandant_kbez AS lin_kurs_bez_land
FROM kfl_production_dbp_view.v_l_lin_kurs AS v1
 INNER JOIN kfl_production_dbp_view.v_lin_kurs_spr_zu AS v2 ON v1.lin_kurs_id = v2.lin_kurs_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS v3 ON v1.mandant_id = v3.mandant_id
WHERE v2.spr_id = 22
 AND (v1.lin_bericht IN ('EWL', 'GSL') OR v1.lin_bericht IS NULL)
GROUP BY v1.mandant_id,
 v1.lin_kurs_id,
 mandant_lin_kurs_id,
 lin_kurs_bez_land;