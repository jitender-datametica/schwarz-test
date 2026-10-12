CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_produkt_schaufenster_2 (mandant_id, psf_id) AS SELECT mandant_id
 ,
 psf_id
FROM kfl_production_dbp_view.v_l_produkt_schaufenster_2
WHERE mandant_id = 1;