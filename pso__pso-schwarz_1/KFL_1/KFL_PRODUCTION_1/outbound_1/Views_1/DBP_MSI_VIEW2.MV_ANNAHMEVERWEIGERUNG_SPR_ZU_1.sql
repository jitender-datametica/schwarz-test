CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_annahmeverweigerung_spr_zu_1 (annahmeverweigerung_id,
annahmeverweigerung_bez, spr_id, mandant_id) AS SELECT annahmeverweigerung_id,
 annahmeverweigerung_bez,
 spr_id,
 mandant_id
FROM kfl_production_dbp_view.v_annahmeverweigerung_spr_zu_1
WHERE mandant_id = 1;