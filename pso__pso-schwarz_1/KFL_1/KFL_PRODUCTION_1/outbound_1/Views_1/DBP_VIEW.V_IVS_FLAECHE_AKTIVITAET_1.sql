CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_flaeche_aktivitaet_1 AS SELECT flaeche_id,
 mandant_id,
 aktivitaet_typ_id,
 dat_aktivitaet,
 aktivitaet_status,
 aktivitaet_bez,
 aktivitaet_ergebnis
FROM kfl_production_dbp_data.ivs_flaeche_aktivitaet_1;