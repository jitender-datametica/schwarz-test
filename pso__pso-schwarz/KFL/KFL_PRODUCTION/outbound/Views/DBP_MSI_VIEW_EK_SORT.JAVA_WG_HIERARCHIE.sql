CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_wg_hierarchie AS SELECT OWG.mandant_id,
 OWG.owg_id,
 WG.wg_id,
 WUG.wug_id
FROM kfl_production_dbp_view.v_owg_per AS OWG
 INNER JOIN kfl_production_dbp_view.v_wg_per AS WG ON OWG.mandant_id = WG.mandant_id AND OWG.owg_id = WG.owg_id AND OWG
    .dat_bis = WG.dat_bis AND OWG.arthiertyp_id = WG.arthiertyp_id
 INNER JOIN kfl_production_dbp_view.v_wug AS WUG ON WG.mandant_id = WUG.mandant_id AND WG.wg_id = WUG.wg_id AND WG.arthiertyp_id
    = WUG.arthiertyp_id
 INNER JOIN kfl_production_dbp_view.v_wg_filter_zu AS WGF ON WG.mandant_id = WGF.mandant_id AND WG.wg_id = WGF.wg_id AND
   WGF.wg_filter_id = 11
WHERE OWG.arthiertyp_id = 2
 AND OWG.dat_bis = DATE '9999-12-31';