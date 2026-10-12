CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lageraufgabe (mandant_id, lageraufgabe_id, lageraufgabe_pos_id
, lagerprozessart_id, status_id, lagerprozess_id, lagerprozesstyp_id, menge_kolli, menge_soll_bme, menge_ist_bme,
gv_menge_bewegt, lagerbereich_id_nach, lagertyp_id_nach, lagertyp_id_von, art_id, art_guid, lagernummer_id, le_typ_id,
gewicht_netto, gew_einh_id, volumen, vol_einh_id, dat_mhd, datzeit_we, dat_we, datzeit_erstellung, dat_erstellung,
zeit_erstellung, handling_unit_id_nach, handling_unit_guid_nach, handling_unit_id_von, handling_unit_guid_von,
bestandsart_id, charge_id, gefahrstoff_fg, aktivitaetsbereich_id, datzeit_quittierung, dat_quittierung, zeit_quittierung
, lagerprozess_extern_id, queue_id, ausnahme_code, dat_start, zeit_start, konsolidierungsgruppe_id, ewm_exc_kategorie_id
, bus_kontext, ausfuehr_schritt_id, zeugnis_nr, lief_pal_typ_id, werbeware_id, ewm_gv_id, welle_id, welle_pos_id,
lagerauftrag_id, ewm_gv_grp_id, artikelsortiment_id, lagersortiment_id, lagerplatz_id_nach, lagerplatz_id_von,
dat_lief_soll, wg_verkett_lief, mandant_id_kunde, bestellart_id) AS SELECT V01.mandant_id,
 V01.lageraufgabe_id,
 V01.lageraufgabe_pos_id,
 V01.lagerprozessart_id,
 V01.status_id,
 V01.lagerprozess_id,
 V01.lagerprozesstyp_id,
 V01.menge_kolli,
 V01.menge_soll_bme,
 V01.menge_ist_bme,
 V01.gv_menge_bewegt,
 V01.lagerbereich_id_nach,
 V01.lagertyp_id_nach,
 COALESCE(V01.lagertyp_id_von, '') AS lagertyp_id_von,
 IFNULL(V02.art_id, - 1) AS art_id,
 V01.art_guid,
 V01.lagernummer_id,
 V01.le_typ_id,
 V01.gewicht_netto,
 V01.gew_einh_id,
 V01.volumen,
 V01.vol_einh_id,
 V01.dat_mhd,
 V01.datzeit_we,
 DATE(V01.datzeit_we) AS dat_we,
 V01.datzeit_erstellung,
 DATE(V01.datzeit_erstellung) AS dat_erstellung,
 CAST(V01.datzeit_erstellung AS TIME) AS zeit_erstellung,
  CASE
  WHEN TRIM(V01.handling_unit_id_nach) = ''
  THEN NULL
  ELSE V01.handling_unit_id_nach
  END AS handling_unit_id_nach,
 V01.handling_unit_guid_nach,
 V01.handling_unit_id_von,
 V01.handling_unit_guid_von,
 V01.bestandsart_id,
 V01.charge_id,
 V01.gefahrstoff_fg,
 V01.aktivitaetsbereich_id,
 V01.datzeit_quittierung,
 DATE(V01.datzeit_quittierung) AS dat_quittierung,
 CAST(V01.datzeit_quittierung AS TIME) AS zeit_quittierung,
 V01.lagerprozess_extern_id,
 V01.queue_id,
 V01.ausnahme_code,
 DATE(V01.datzeit_start) AS dat_start,
 CAST(V01.datzeit_start AS TIME) AS zeit_start,
 IF(CAST(V01.konsolidierungsgruppe_id AS FLOAT64) = 0, NULL, CAST(V01.konsolidierungsgruppe_id AS FLOAT64)) AS
 konsolidierungsgruppe_id,
 V01.ewm_exc_kategorie_id,
 V01.bus_kontext,
 V01.ausfuehr_schritt_id,
 V01.zeugnis_nr,
 V01.lief_pal_typ_id,
 V01.werbeware_id,
 IF(V01.ewm_gv_id = 0, NULL, V01.ewm_gv_id) AS ewm_gv_id,
 IF(V01.welle_id = 0, NULL, V01.welle_id) AS welle_id,
 IF(V01.welle_pos_id = 0, NULL, V01.welle_pos_id) AS welle_pos_id,
 V01.lagerauftrag_id,
 V01.ewm_gv_grp_id,
 IFNULL(A_SORT.artikelsortiment_id, '0') AS artikelsortiment_id,
  CASE
  WHEN V01.lagertyp_id_nach <> ''
  THEN LEFT(V01.lagertyp_id_nach, 1)
  WHEN V01.lagertyp_id_von <> ''
  THEN LEFT(V01.lagertyp_id_von, 1)
  ELSE '0'
  END AS lagersortiment_id,
 V01.lagerplatz_id_nach,
 V01.lagerplatz_id_von,
 refdoc.dat_lief_soll,
 refdoc.wg_verkett_lief,
 refdoc.mandant_id_kunde,
 refdoc.bestellart_id
FROM kfl_production_dbp_view.v_lageraufgabe AS V01
 LEFT JOIN (SELECT REFDOC_I.mandant_id,
   REFDOC_I.beleg_guid,
   REFDOC_I.beleg_pos_guid,
   REFDOC_I.referenzbeleg_guid,
   REFDOC_I.referenzbeleg_pos_guid,
   REFDOC_I.referenzbeleg_id,
   REFDOC_I.referenzbeleg_pos_id,
   ROW_NUMBER() OVER (PARTITION BY CAST(REFDOC_I.mandant_id AS STRING), REFDOC_I.beleg_guid, REFDOC_I.beleg_pos_guid
    ORDER BY REFDOC_I.datzeit_termin_beginn IS NULL, REFDOC_I.datzeit_termin_beginn) AS relevant,
   LIKP.dat_lief_soll,
   LIKP.wg_verkett_lief,
   LIKP.mandant_id_kunde,
   COALESCE(LIPS.bestellart_id, '-1') AS bestellart_id
  FROM kfl_production_dbp_view.v_belegreferenz AS REFDOC_I
   INNER JOIN kfl_production_dbp_view.v_auslieferposition AS PROCI_O ON REFDOC_I.mandant_id = PROCI_O.mandant_id AND
        REFDOC_I.beleg_guid = PROCI_O.beleg_guid AND REFDOC_I.beleg_pos_guid = PROCI_O.beleg_pos_guid AND PROCI_O.beleg_id
       <= 999999999999999999 AND REFDOC_I.referenz_belegtyp_id = 'ERO'
   INNER JOIN kfl_production_dbp_view.v_besch_lief AS LIKP ON PROCI_O.mandant_id = LIKP.mandant_id AND LIKP.lief_beleg_id
       = ROUND(SAFE_CAST(REFDOC_I.referenzbeleg_id AS BIGNUMERIC), 0) AND LIKP.dat_lief_soll = COALESCE(PROCI_O.dat_lief_soll
      , LIKP.dat_lief_soll)
   LEFT JOIN kfl_production_dbp_view.v_besch_lief_det AS LIPS ON LIKP.mandant_id = LIPS.mandant_id AND LIKP.lief_beleg_id
        = LIPS.lief_beleg_id AND REFDOC_I.referenzbeleg_pos_id = LIPS.lief_beleg_pos_id AND LIKP.dat_lief_soll = LIPS.dat_lief_soll
     
   INNER JOIN kfl_production_dbp_view.v_tag AS T ON LIKP.dat_lief_soll = T.dat AND T.akt_kj BETWEEN - 2 AND 0
   INNER JOIN kfl_production_dbp_view.v_tag AS T_R ON COALESCE(DATE(REFDOC_I.datzeit_erstellung), CURRENT_DATE) = T_R.dat
      AND T_R.akt_kj BETWEEN - 2 AND 0) AS refdoc ON V01.mandant_id = refdoc.mandant_id AND V01.ref_beleg_guid = refdoc
     .beleg_guid AND V01.ref_beleg_pos_guid = refdoc.beleg_pos_guid AND refdoc.relevant = 1
 INNER JOIN kfl_production_dbp_view.v_l_lagernummer AS T001L ON V01.mandant_id = T001L.mandant_id AND V01.lagernummer_id
    = T001L.lagernummer_id
 INNER JOIN kfl_production_dbp_view.v_art_guid_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_guid = V02.art_guid
   
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS MARC ON T001L.mandant_id = MARC.mandant_id AND MARC.nb_id =
      - 111 AND MARC.dat_bis = DATE '9999-12-31' AND T001L.wup_id = MARC.wup_id AND V02.art_id = MARC.art_id
 INNER JOIN kfl_production_dbp_view.v_fremd_lagerort_artikelsortiment_zu AS A_SORT ON MARC.fremd_lagerort_id = A_SORT.fremd_lagerort_id
    AND MARC.mandant_id = A_SORT.mandant_id
 INNER JOIN kfl_production_dbp_view.v_tag AS T_Q ON DATE(V01.datzeit_quittierung) = T_Q.dat AND T_Q.akt_kj BETWEEN - 2
   AND 0;