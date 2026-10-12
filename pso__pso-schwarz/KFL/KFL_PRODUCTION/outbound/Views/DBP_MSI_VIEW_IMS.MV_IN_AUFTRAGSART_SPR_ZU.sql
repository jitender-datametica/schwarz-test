CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_auftragsart_spr_zu AS SELECT auftragsart_id,
 auftragsart_bez
FROM kfl_production_dbp_view.v_in_auftragsart_spr_zu
WHERE spr_id = 22
QUALIFY (RANK() OVER (PARTITION BY auftragsart_id ORDER BY mandant_id IS NULL, mandant_id)) = 1;