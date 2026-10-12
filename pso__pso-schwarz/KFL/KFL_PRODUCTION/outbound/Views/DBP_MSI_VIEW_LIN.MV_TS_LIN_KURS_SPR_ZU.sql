CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_ts_lin_kurs_spr_zu (mandant_id, lin_kurs_id,
mandant_lin_kurs_id, lin_kurs_bez_land) AS SELECT V1.mandant_id,
 V1.lin_kurs_id,
   SUBSTR(CAST(V1.mandant_id AS STRING), 1, 1) || ' ' || V2.lin_kurs_id AS mandant_lin_kurs_id,
   V2.lin_kurs_bez || ' ' || V3.mandant_kbez AS lin_kurs_bez_land
FROM kfl_production_dbp_view.v_l_lin_kurs AS V1
 INNER JOIN kfl_production_dbp_view.v_lin_kurs_spr_zu AS V2 ON V1.lin_kurs_id = V2.lin_kurs_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS V3 ON V1.mandant_id = V3.mandant_id
WHERE V2.spr_id = 22
 AND (V1.lin_bericht IN ('EWL', 'GSL') OR V1.lin_bericht IS NULL)
GROUP BY V1.mandant_id,
 V1.lin_kurs_id,
 mandant_lin_kurs_id,
 lin_kurs_bez_land;