CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ginfo_flaeche_det_per_1 AS SELECT mandant_id,
 dat_von,
 techn_platz_id,
 ginfo_flaeche_id,
 ginfo_flaeche_typ_id,
 kaufland_typ_id,
 dat_bis,
 ginfo_flaeche_brutto
FROM kfl_production_dbp_data.ginfo_flaeche_det_per_1;