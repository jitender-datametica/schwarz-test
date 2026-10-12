CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_lief (mandant_id, lief_beleg_id, wup_id, nb_id,
versandstelle_id, verkaufsorganisation_id, lief_typ_id, dat_lief_soll, vertr_beleg_typ_id, lief_pal_typ_id,
lagerhierarchie_id, kunde_id, auftraggeber_id, anzahl_packstueck, werbeware_id, dat_lagerbew_ist, system_id) AS SELECT
 mandant_id,
 lief_beleg_id,
 wup_id,
 nb_id,
 versandstelle_id,
 verkaufsorganisation_id,
 lief_typ_id,
 dat_lief_soll,
 vertr_beleg_typ_id,
 lief_pal_typ_id,
 lagernummer_id AS lagerhierarchie_id,
 kunde_id,
 auftraggeber_id,
 anzahl_packstueck,
 werbeware_id,
 dat_lagerbew_ist,
 7 AS system_id
FROM kfl_production_dbp_view.v_besch_lief
WHERE mandant_id = 1;