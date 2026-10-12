CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_abschriftart_spr_zu_1 (abschriftart_id, abschriftart_bez,
mandant_id, spr_id) AS SELECT abschriftart_id,
 abschriftart_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_abschriftart_spr_zu_1
WHERE mandant_id = 1;