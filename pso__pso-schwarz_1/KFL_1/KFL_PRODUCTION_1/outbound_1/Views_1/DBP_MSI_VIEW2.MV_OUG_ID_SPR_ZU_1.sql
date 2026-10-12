CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_oug_id_spr_zu_1 AS SELECT oug_id,
 oug_id_bez
FROM kfl_production_dbp_view.v_oug_id_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22
UNION ALL
SELECT 0 AS dm__operand0,
 'nicht gepflegt' AS dm__operand1
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;