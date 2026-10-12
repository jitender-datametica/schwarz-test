CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_annahmeverweigerung_1 (mandant_id, annahmeverweigerung_id) AS
SELECT mandant_id,
 annahmeverweigerung_id
FROM kfl_production_dbp_view.v_l_annahmeverweigerung_1
WHERE mandant_id = 1;