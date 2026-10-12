CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_abschriftenart (abschriftenart_id, abschriftenart_bez,
mandant_id, spr_id) AS SELECT abschriftart_id AS abschriftenart_id,
 abschriftart_bez AS abschriftenart_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_abschriftart_spr_zu
WHERE mandant_id = 1
 AND abschriftart_id <> 90;