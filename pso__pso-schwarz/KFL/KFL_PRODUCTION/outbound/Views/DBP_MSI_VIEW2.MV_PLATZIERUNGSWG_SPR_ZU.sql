CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_platzierungswg_spr_zu (mandant_id, platzierungswg_id,
platzierungswg_nr, spr_id, platzierungswg_bez) AS SELECT A10.mandant_id,
 A10.platzierungswg_id,
 A11.platzierungswg_nr,
 A10.spr_id,
 A10.platzierungswg_bez
FROM kfl_production_dbp_view.v_platzierungswg_spr_zu AS A10
 INNER JOIN kfl_production_dbp_view.v_l_platzierungswg AS A11 ON A10.mandant_id = A11.mandant_id AND A10.platzierungswg_id
    = A11.platzierungswg_id
WHERE A10.mandant_id = 1
 AND A10.spr_id = 22;