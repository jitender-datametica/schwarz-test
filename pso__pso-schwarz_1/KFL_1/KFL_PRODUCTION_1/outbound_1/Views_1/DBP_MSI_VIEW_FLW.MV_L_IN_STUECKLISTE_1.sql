CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_stueckliste_1 (mandant_id, stueckliste_id,
stueckliste_typ_id, in_art_id, werk_id, menge_basis) AS SELECT mandant_id,
 stueckliste_id,
 stueckliste_typ_id,
 flw_art_id AS in_art_id,
 werk_id,
 menge_basis
FROM kfl_production_dbp_view.v_flw_stueckliste_1;