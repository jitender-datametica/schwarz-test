CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_nachschubzeiten_2 AS WITH T0 AS (SELECT WHO.mandant_id,
   WHO.lagerauftrag_id,
   DATE(WHO.datzeit_erstellung) AS dat_erstellung,
   WHO.datzeit_erstellung,
   WHO.lagerauftrag_status_id,
   ORDIM_C.lagerprozessart_id,
   WHO.lagerprozessart_id_belegkopf,
   ORDIM_C.lagertyp_id_von,
   ORDIM_C.lagerplatz_id_von,
   ORDIM_C.lagertyp_id_nach,
   ORDIM_C.lagerplatz_id_nach,
   WHO.nachschub_option_id,
   WHO.lsd_berechnungsart_id,
   WHO.aktivitaetsbereich_id,
   WHO.queue_id,
    CASE
    WHEN WHO.mandant_id IN (4, 7, 8) AND DATETIME_DIFF(WHO.datzeit_erstellung, WHO.datzeit_lsd_berechnung, MINUTE) >= 30
      
    THEN DATETIME_ADD(WHO.datzeit_lsd_berechnung, INTERVAL 1 HOUR)
    ELSE WHO.datzeit_lsd_berechnung
    END AS datzeit_lsd_berechnung,
   WHO.datzeit_start_max,
    CASE
    WHEN (ORDIM_C.lagertyp_id_von LIKE '%R03' OR ORDIM_C.lagertyp_id_von LIKE '%R13' OR ORDIM_C.lagertyp_id_von LIKE
             '%FAP' OR ORDIM_C.lagertyp_id_von LIKE '%EHP' OR ORDIM_C.lagertyp_id_von LIKE '%FHP' OR ORDIM_C.lagertyp_id_von
          LIKE '%B0%' OR ORDIM_C.lagertyp_id_von LIKE '%B1%' OR ORDIM_C.lagertyp_id_von LIKE '%2R53%') AND TRIM(COALESCE(ORDIM_C
        .lagertyp_id_nach, '')) = ''
    THEN 1
    WHEN ORDIM_C.lagertyp_id_nach LIKE '%G%'
    THEN 2
    WHEN ORDIM_C.lagertyp_id_nach LIKE '%R%'
    THEN 3
    ELSE NULL
    END AS nachschub_prozessschritt_id,
   ORDIM_C.datzeit_quittierung,
   ORDIM_C.datzeit_start,
   ROW_NUMBER() OVER (PARTITION BY CAST(ORDIM_C.mandant_id AS STRING), CAST(ORDIM_C.lageraufgabe_id AS STRING), CASE
       WHEN (ORDIM_C.lagertyp_id_von LIKE '%R03' OR ORDIM_C.lagertyp_id_von LIKE '%R13' OR ORDIM_C.lagertyp_id_von LIKE
                '%FAP' OR ORDIM_C.lagertyp_id_von LIKE '%EHP' OR ORDIM_C.lagertyp_id_von LIKE '%FHP' OR ORDIM_C.lagertyp_id_von
             LIKE '%B0%' OR ORDIM_C.lagertyp_id_von LIKE '%B1%' OR ORDIM_C.lagertyp_id_von LIKE '%2R53%') AND TRIM(COALESCE(ORDIM_C
           .lagertyp_id_nach, '')) = ''
       THEN 1
       WHEN ORDIM_C.lagertyp_id_nach LIKE '%G%'
       THEN 2
       WHEN ORDIM_C.lagertyp_id_nach LIKE '%R%'
       THEN 3
       ELSE NULL
       END ORDER BY ORDIM_C.datzeit_quittierung IS NULL, ORDIM_C.datzeit_quittierung) AS relevant,
   ORDIM_C.lageraufgabe_id,
   ORDIM_C.lageraufgabe_pos_id,
   ORDIM_C.handling_unit_id_nach,
   ORDIM_C.art_guid,
   ORDIM_C.lagernummer_id,
   ORDIM_C.ewm_gv_id
  FROM kfl_production_dbp_view.v_lagerauftrag_2 AS WHO
   INNER JOIN kfl_production_dbp_view.v_lageraufgabe_2 AS ORDIM_C ON WHO.mandant_id = ORDIM_C.mandant_id AND WHO.lagerauftrag_id
       = ORDIM_C.lagerauftrag_id AND WHO.lagernummer_id = ORDIM_C.lagernummer_id
  WHERE ORDIM_C.status_id = 'C'
   AND ORDIM_C.lagerprozessart_id IN ('0N01', '0N02', '4N02')) (SELECT t1.mandant_id,
   t1.lagerauftrag_id,
   t1.datzeit_erstellung,
   t1.dat_erstellung,
   t1.lagerprozessart_id_belegkopf,
   t1.nachschub_option_id,
   t1.lsd_berechnungsart_id,
   t1.aktivitaetsbereich_id,
   t1.queue_id,
   t1.datzeit_lsd_berechnung,
   t1.datzeit_start_max,
    CASE
    WHEN t1.datzeit_start_max = CAST('9999-12-30 01:00:00' AS DATETIME)
    THEN NULL
    ELSE t1.datzeit_start_max
    END AS datzeit_lsd,
   t1.lagerauftrag_status_id,
   t01.lagertyp_id_nach,
   t01.lagerplatz_id_nach,
   LEFT(t01.lagertyp_id_nach, 1) AS lagersortiment_id,
   MARC.fremd_lagerort_id,
   A_SORT.artikelsortiment_id,
   t1.lagernummer_id,
   ART_GUID.art_id,
   t1.lagertyp_id_von,
   t1.lagerplatz_id_von,
   t1.lageraufgabe_id AS lageraufgabe_id_step1,
   t1.lageraufgabe_pos_id AS lageraufgabe_pos_id_step1,
   t1.datzeit_start AS datzeit_quittierung_step1,
   t01.lageraufgabe_id AS lageraufgabe_id_step2,
   t01.lageraufgabe_pos_id AS lageraufgabe_pos_id_step2,
   t01.datzeit_quittierung AS datzeit_quittierung_step2,
   t02.lageraufgabe_id AS lageraufgabe_id_step3,
   t02.lageraufgabe_pos_id AS lageraufgabe_pos_id_step3,
   t02.datzeit_quittierung AS datzeit_quittierung_step3,
   t1.ewm_gv_id
  FROM T0 AS t1_2
   INNER JOIN kfl_production_dbp_view.v_art_guid_zu_2 AS ART_GUID ON t1.mandant_id = ART_GUID.mandant_id AND t1.art_guid =
     ART_GUID.art_guid
   INNER JOIN kfl_production_dbp_view.v_l_lagernummer_2 AS T001L ON t1.mandant_id = T001L.mandant_id AND t1.lagernummer_id
      = T001L.lagernummer_id
   INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_2 AS MARC_2 ON t1.mandant_id = MARC.mandant_id AND ART_GUID.art_id
        = MARC.art_id AND T001L.wup_id = MARC.wup_id AND MARC.dat_bis = DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_view.v_fremd_lagerort_artikelsortiment_zu_2 AS A_SORT ON MARC.fremd_lagerort_id = A_SORT
     .fremd_lagerort_id AND MARC.mandant_id = A_SORT.mandant_id
   LEFT JOIN T0 AS t01 ON t1.mandant_id = t01.mandant_id AND t1.lagerauftrag_id = t01.lagerauftrag_id AND t1.lagernummer_id
         = t01.lagernummer_id AND (t1.handling_unit_id_nach = COALESCE(t01.handling_unit_id_nach, t1.handling_unit_id_nach
          ) OR t1.handling_unit_id_nach = CASE
          WHEN t1.handling_unit_id_nach = ''
          THEN t01.handling_unit_id_nach
          ELSE t1.handling_unit_id_nach
          END) AND t1.relevant = t01.relevant AND t01.nachschub_prozessschritt_id = 2
   LEFT JOIN T0 AS t02 ON t1.mandant_id = t02.mandant_id AND t1.lagerauftrag_id = t02.lagerauftrag_id AND t1.lagernummer_id
         = t02.lagernummer_id AND (t1.handling_unit_id_nach = COALESCE(t01.handling_unit_id_nach, t1.handling_unit_id_nach
          ) OR t1.handling_unit_id_nach = CASE
          WHEN t1.handling_unit_id_nach = ''
          THEN t01.handling_unit_id_nach
          ELSE t1.handling_unit_id_nach
          END) AND t1.relevant = t02.relevant AND t02.nachschub_prozessschritt_id = 3
  WHERE t1.relevant = 1
   AND t1.nachschub_prozessschritt_id = 1);