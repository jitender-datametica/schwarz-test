CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_besch_lief_wa_wg_sum_2 (mandant_id, wup_id, nb_id,
lagernummer_id, versandstelle_id, lagerort_id, lagersortiment_id, artikelsortiment_id, transportsortiment_id, diff_id,
dat_lief_soll, lief_typ_id, vertr_beleg_typ_id, wg_id, arthiertyp_id, kunde_id, wg_verkett_lief, lief_pal_typ_id,
lief_pal_typ_dwh_id, mandant_id_kunde, werbeware_id, bestellart_id, hu_status_id, disponent_id, anzahl_position,
anzahl_position_charg_split, anzahl_packstueck_anzpk, anzahl_packstueck_hu, brtvol_ladung, brtvol_ladung_gedeckelt,
brtvol_hu_gedeckelt_oa, brtvol_hu_oa, menge_lief_soll_kolli, menge_lief_ist_kolli, menge_lief_soll_bme,
menge_lief_ist_bme, anzahl_stellplatz_ewm_ext_parent, anzahl_stellplatz_ewm, auslieferungsgruppe_id, wg_verkett_hier_id
, wg_verkett_fg) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagernummer_id,
 V01.versandstelle_id,
 V01.lagerort_id,
 V01.lagersortiment_id,
  CASE
  WHEN LEFT(RIGHT(V01.versandstelle_id, 2), 1) = '5'
  THEN '1'
  WHEN LEFT(RIGHT(V01.versandstelle_id, 2), 1) = '7'
  THEN '2'
  ELSE LEFT(RIGHT(V01.versandstelle_id, 2), 1)
  END AS artikelsortiment_id,
 COALESCE(V01.transportsortiment_id, '-1') AS transportsortiment_id,
 V01.diff_id,
 V01.dat_lief_soll,
 V01.lief_typ_id,
 V01.vertr_beleg_typ_id,
 V01.wg_id,
 V01.arthiertyp_id,
 COALESCE(V02.aktuell_wup_id, V01.kunde_id) AS kunde_id,
 V01.wg_verkett_lief,
 V01.lief_pal_typ_id,
 V01.lief_pal_typ_dwh_id,
 V01.mandant_id_kunde,
 V01.werbeware_id,
 V01.bestellart_id,
 V01.hu_status_id,
 V01.disponent_id,
 V01.anzahl_position,
 V01.anzahl_position_charg_split,
 V01.anzahl_packstueck_anzpk,
 V01.anzahl_packstueck_hu,
 V01.brtvol_ladung,
 V01.brtvol_ladung_gedeckelt,
 V01.brtvol_hu_gedeckelt_oa,
 V01.brtvol_hu_oa,
 V01.menge_lief_soll_kolli,
 V01.menge_lief_ist_kolli,
 V01.menge_lief_soll_bme,
 V01.menge_lief_ist_bme,
 V01.anzahl_stellplatz_ewm_ext_parent,
 V01.anzahl_stellplatz_ewm,
 V01.auslieferungsgruppe_id,
  CASE
  WHEN V01.wg_verkett_fg = 1
  THEN CAST(WGVER.wg_verkett_hier_id AS STRING)
  ELSE ''
  END AS wg_verkett_hier_id,
 V01.wg_verkett_fg
FROM kfl_production_dbp_view.v_besch_lief_wa_wg_sum_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V02.mandant_id = CASE
     WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
     THEN V01.mandant_id
     ELSE V01.mandant_id_kunde
     END AND V01.kunde_id = V02.wup_id AND V02.nb_id = 0
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per_2 AS WGVER ON V01.wup_id = WGVER.wup_id AND V01.mandant_id
      = WGVER.mandant_id AND V01.wg_verkett_lief = WGVER.wg_verkett_id AND V01.dat_lief_soll BETWEEN WGVER.dat_von AND
   WGVER.dat_bis
WHERE V01.lief_pal_typ_dwh_id <> 'J';