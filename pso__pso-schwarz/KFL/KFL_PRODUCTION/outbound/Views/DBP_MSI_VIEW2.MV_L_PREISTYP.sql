CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_preistyp (preistyp_id, mandant_id, spr_id, preistyp_bez) AS
SELECT preistyp_id,
 mandant_id,
 spr_id,
 preistyp_bez
FROM kfl_production_dbp_view.v_l_preistyp
WHERE mandant_id = 1;