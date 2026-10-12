CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_produkt_schaufenster_spr_zu (mandant_id, psf_id, spr_id, psf_bez
) AS SELECT mandant_id,
 psf_id,
 spr_id,
 psf_bez
FROM kfl_production_dbp_view.v_produkt_schaufenster_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;