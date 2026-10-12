CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ginfo_flaeche_per_1 (mandant_id, dat_von, techn_platz_id,
ginfo_flaeche_id, ginfo_flaeche_typ_id, dat_bis, ginfo_flaeche_netto, ginfo_flaeche_brutto, ginfo_achse_wert,
ginfo_achse_typ_id) AS SELECT mandant_id,
 dat_von,
 techn_platz_id,
 ginfo_flaeche_id,
 ginfo_flaeche_typ_id,
 dat_bis,
 ginfo_flaeche_netto,
 ginfo_flaeche_brutto,
 ginfo_achse_wert,
 ginfo_achse_typ_id
FROM kfl_production_dbp_data.ginfo_flaeche_per_1;