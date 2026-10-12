CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_verpart_sk (mandant_id, verpart_id, spr_id, verpart_bez
) AS SELECT mandant_id,
 verpart_id,
 spr_id,
 verpart_bez
FROM kfl_production_dbp_view.v_artkz_verpart
WHERE spr_id = 108;