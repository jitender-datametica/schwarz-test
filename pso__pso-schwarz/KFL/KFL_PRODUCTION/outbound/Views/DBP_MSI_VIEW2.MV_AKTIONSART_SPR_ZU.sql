CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_aktionsart_spr_zu (aktionsart_id, mandant_id, spr_id,
aktionsart_bez) AS SELECT V01.aktionsart_id,
 V01.mandant_id,
 V02.spr_id,
 V02.aktionsart_bez
FROM kfl_production_dbp_view.v_l_aktionsart AS V01
 INNER JOIN kfl_production_dbp_view.v_aktionsart_spr_zu AS V02 ON V01.aktionsart_id = V02.aktionsart_id AND V01.mandant_id
    = V02.mandant_id
WHERE V01.mandant_id = 1
 AND V02.spr_id = 22;