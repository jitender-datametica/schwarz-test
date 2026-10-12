CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ginfo_flaeche_areaattr_per AS SELECT techn_platz_id,
 flaeche_attribut_id,
 dat_von,
 dat_bis,
 flaeche_cad,
 flaeche_schaetzung,
 flaeche_beauftragung,
 quelle_beauftragung
FROM kfl_production_dbp_data.ginfo_flaeche_areaattr_per;