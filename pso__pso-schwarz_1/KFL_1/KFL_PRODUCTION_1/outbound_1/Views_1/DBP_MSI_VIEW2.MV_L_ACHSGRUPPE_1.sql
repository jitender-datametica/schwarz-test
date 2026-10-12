CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_achsgruppe_1 (mandant_id, achsgruppe_id, produktgruppe_id) AS
SELECT mandant_id,
 achsgruppe_id,
 produktgruppe_id
FROM kfl_production_dbp_view.v_l_achsgruppe_1
WHERE mandant_id = 1;