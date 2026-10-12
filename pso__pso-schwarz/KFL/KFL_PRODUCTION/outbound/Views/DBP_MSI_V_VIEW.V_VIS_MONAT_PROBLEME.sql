CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_monat_probleme AS SELECT mandant_id,
 kjmo,
 problemcode_id,
 anz_fehler,
 anz_fehler_kum
FROM kfl_production_dbp_msi_data.vis_monat_probleme;