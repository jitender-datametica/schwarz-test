CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_sachkonto_2 AS SELECT sachkonto_id,
 mandant_id,
 sachkonto_bez,
 spr_id,
 sachkonto_gruppe_id,
 plandetail_id,
 plantyp_id
FROM kfl_production_dbp_view.v_ivs_l_sachkonto_2
WHERE spr_id = 22;