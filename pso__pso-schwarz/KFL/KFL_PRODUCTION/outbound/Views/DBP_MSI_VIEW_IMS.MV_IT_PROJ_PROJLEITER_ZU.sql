CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_it_proj_projleiter_zu AS SELECT it_projekt_id,
 ma_id AS it_pl_id
FROM kfl_production_dbp_view.v_it_projekt_ma_zu AS V01
WHERE mandant_id = 1
 AND ma_funktion_id = 'CLPL';