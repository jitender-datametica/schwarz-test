CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_lin_kurs_spr_zu_pl_2 (mandant_id, lin_kurs_id, lin_kurs_bez,
mandant_kbez) AS SELECT V1.mandant_id,
 V1.lin_kurs_id,
 V2.lin_kurs_bez,
 V3.mandant_kbez
FROM kfl_production_dbp_view.v_l_lin_kurs_2 AS V1
 INNER JOIN kfl_production_dbp_view.v_lin_kurs_spr_zu_2 AS V2 ON V1.lin_kurs_id = V2.lin_kurs_id AND V1.lin_bericht = V2.lin_bericht
   
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V3 ON V1.mandant_id = V3.mandant_id
WHERE V2.spr_id = 90
 AND (V1.lin_bericht IN ('EWL', 'GSL') OR V1.lin_bericht IS NULL)
GROUP BY V1.mandant_id,
 V1.lin_kurs_id,
 V2.lin_kurs_bez,
 V3.mandant_kbez;