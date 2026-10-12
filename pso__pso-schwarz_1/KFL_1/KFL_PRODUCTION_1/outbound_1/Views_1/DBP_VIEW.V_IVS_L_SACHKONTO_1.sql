CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_sachkonto_1 AS SELECT sachkonto_id,
 mandant_id,
 sachkonto_bez,
 spr_id,
 sachkonto_gruppe_id,
 plantyp_id,
 plandetail_id
FROM kfl_production_dbp_data.ivs_l_sachkonto_1;