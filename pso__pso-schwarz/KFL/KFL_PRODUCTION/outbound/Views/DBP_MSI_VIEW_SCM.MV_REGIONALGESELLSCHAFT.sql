CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_regionalgesellschaft (mandant_id, vs_id, vs_bez, vsvt_bez) AS
SELECT V01.mandant_id,
 V01.vs_id,
 V02.vs_bez,
 V02.vsvt_bez
FROM kfl_production_dbp_view.v_wup AS V01
 INNER JOIN kfl_production_dbp_view.v_vs AS V02 ON V01.mandant_id = V02.mandant_id AND V01.vs_id = V02.vs_id AND (V02.vk_id
       = 0 AND V01.mandant_id <> 1 OR V01.mandant_id = 1 AND V02.vk_id = 1)
GROUP BY V01.mandant_id,
 V01.vs_id,
 V02.vs_bez,
 V02.vsvt_bez
UNION ALL
SELECT mandant_id,
 - 1 AS vs_id,
 'Alle (DIF)' AS vs_bez,
 'Alle Regionen (DIF)' AS vsvt_bez
FROM kfl_production_dbp_view.v_mandant AS V11
WHERE mandant_id = 1;