-- 2013KW13 Update Eroeffnungswerbung (COALESCE)
 -- 2016KW04 Erweiterung Marktmodernisierung
 -- 2009-06-08 Initial

-- 2009KW27 : Anpassung cpr-Felder
 -- FAKT cProjects (IOS) denormalisiert

-- Verkn¸pfung Markt (wup) mit und cProjects-Daten (Projekt/Phase/Ma?nahmnen/Termine)

-- 2013KW09 Abloesung MDR-Reorga. Komplette Ueberarbeitung, Basis neue IOS Views,

-- 2015KW37 Finetuning IST/SOLL Felder fuer Pruefbericht ...

-- 2014KW46 Anpassung Logik (ohne Suchfeld CPR_REALISIERUNG; ohne phase cpr_systemstatus2_id=1)

-- 20160819 tuts : Angeglichen an IOS-Logik f¸r Datumsfelder
 -- 2015KW26 komplettes Redesign GJ2015 (Anfo 612890)

-- 2012KW46 Review
 -- 2013KW09 Einschraenkung auf Reorga/Standortoptimierung Massnahmen

-- 2009KW37 : Anpassung Gueltigkeit (+ abgeschlossene Projekte)
 -- 20130806 Update Massnahmen (+ ZPPM_xy)

-- 20160826 ssch0611 : Baubeginn auf MIN(DAT), SOLL Felder auf Prognose gemappt

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_cprojects AS -- BAUABSCHNITT (relevant fuer Bericht)

/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
-- KOPFZEILE (Berechnung in mv_view)

/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
/* Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed */
-- Marktstamm
 -- Techn Platz
 -- cProjects
 -- Reserve
 -- Projekt (Checkliste oder Aufgabe)

-- angeglichen an IOS-Logik
 -- entfaellt, da irrelevant in VIS
 -- entfaellt, da irrelevant in VIS

-- Projekt 1. Checkliste
 -- angeglichen an IOS-Logik
 -- angeglichen an IOS-Logik
 -- Projekt 2. Aufgaben

-- angeglichen an IOS-Logik
 -- angeglichen an IOS-Logik
 -- angeglichen an IOS-Logik
 -- Phase und Bauabschnitt

-- PROJEKT Status2 : OHNE 1 Gesperrt
 -- PHASE Status2 : OHNE 1 Gesperrt
 -- 

-- GROUP BY cp0.techn_platz_id, cp0.projekt_nr, SUBSTRING(cp0.projekt_nr, 14, 2)

-- , cp0.cpr_projekt_bez, cp0.cpr_projekt_langtext, cp0.massnahme_id, cp0.teil_massn_kz, cp0.bauabschnitt_id, cp0.bauabschnitt_bez, cp0.bauabschnitt_langtext, cp0.gj

-- Termin in Ordnung
 -- Termin offen in Zukunft
 SELECT wp.mandant_id,
 wp.nb_id,
 wp.wup_id,
 CAST(CASE
   WHEN cpro.massnahme_id IN ('ST', 'ZPPM_ST')
   THEN 3
   WHEN cpro.massnahme_id IN ('RE', 'RN', 'ZPPM_RE', 'ZPPM_RN')
   THEN 4
   WHEN cpro.massnahme_id IN ('ZPPM_MM')
   THEN 11
   ELSE 0
   END AS BIGNUMERIC) AS massnahme_typ_id,
 CAST(CASE
   WHEN cpro.massnahme_id IN ('ST', 'ZPPM_ST')
   THEN 'Standortoptimierung'
   WHEN cpro.massnahme_id IN ('RE', 'RN', 'ZPPM_RE', 'ZPPM_RN')
   THEN 'Reorga'
   WHEN cpro.massnahme_id IN ('ZPPM_MM')
   THEN 'Marktmodernisierung'
   ELSE 'nicht definiert'
   END AS STRING) AS massnahme_typ_bez,
 MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro
    .projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
 AS dat_projekt_ende,
 MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id
    IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS dat_werbung_bis,
 DATE_ADD(CASE
   WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr
        IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW)) > (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL,
        cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      CURRENT ROW))
   THEN MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr
      IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW)
   WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr
        IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW)) < (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL,
        cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND
      CURRENT ROW))
   THEN MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro
      .bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
   ELSE MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr
      IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW)
   END, INTERVAL 16 * 7 DAY) AS dat_bericht_bis,
 CAST(CASE
   WHEN cpro.teil_massn_kz > 0
   THEN CASE
    WHEN CURRENT_DATE > (MIN(COALESCE(cpro.dat_apl, snowconvert_public.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       ) AND CURRENT_DATE < DATE_SUB((MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)), INTERVAL 16 * 7 DAY)
    THEN 2 -- kuenftig

    WHEN CURRENT_DATE > (MIN(COALESCE(cpro.dat_apl, snowconvert_public.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       ) AND CURRENT_DATE BETWEEN DATE_SUB(MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), INTERVAL 16 * 7 DAY)
      AND (DATE_ADD(DATE_ADD(CASE
          WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
               ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
          THEN MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) < (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
               ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
          THEN MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          ELSE MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END, INTERVAL 16 * 7 DAY), INTERVAL 5 * 7 DAY))
    THEN 1 -- aktuell (5 Wochen Offset da Monatsreporting)

    WHEN CURRENT_DATE > (MIN(COALESCE(cpro.dat_apl, snowconvert_public.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       ) AND CURRENT_DATE > DATE_ADD(CASE
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) < (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        ELSE MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        END, INTERVAL 16 * 7 DAY)
    THEN 0 -- historisch

    WHEN CURRENT_DATE BETWEEN DATE_SUB(MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), INTERVAL 16 * 7 DAY)
     AND (DATE_ADD(CASE
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) < (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        ELSE MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        END, INTERVAL 16 * 7 DAY))
    THEN - 1 -- nicht freigegeben

    WHEN DATE_SUB((MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)), INTERVAL 16 * 7 DAY) > DATE('1900-01-01')
    THEN - 3 -- Daten vorhanden

    ELSE - 9
    END
   WHEN cpro.teil_massn_kz < 1
   THEN CASE
    WHEN CURRENT_DATE > (MIN(COALESCE(cpro.dat_apl, snowconvert_public.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       ) AND CURRENT_DATE < DATE_SUB((MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)), INTERVAL 16 * 7 DAY)
    THEN 12 -- kuenftig

    WHEN CURRENT_DATE > (MIN(COALESCE(cpro.dat_apl, snowconvert_public.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       ) AND CURRENT_DATE BETWEEN DATE_SUB(MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), INTERVAL 16 * 7 DAY)
      AND (DATE_ADD(DATE_ADD(CASE
          WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
               ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
          THEN MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) < (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
               ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
          THEN MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          ELSE MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          END, INTERVAL 16 * 7 DAY), INTERVAL 5 * 7 DAY))
    THEN 11 -- aktuell (5 Wochen Offset da Monatsreporting)

    WHEN CURRENT_DATE > (MIN(COALESCE(cpro.dat_apl, snowconvert_public.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
       ) AND CURRENT_DATE > DATE_ADD(CASE
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) < (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        ELSE MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        END, INTERVAL 16 * 7 DAY)
    THEN 10 -- historisch

    WHEN CURRENT_DATE BETWEEN DATE_SUB(MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), INTERVAL 16 * 7 DAY)
     AND (DATE_ADD(CASE
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        WHEN (MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) < (MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr
             ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
        THEN MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        ELSE MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        END, INTERVAL 16 * 7 DAY))
    THEN - 11 -- nicht freigegeben

    WHEN DATE_SUB((MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)), INTERVAL 16 * 7 DAY) > DATE('1900-01-01')
    THEN - 33 -- Daten vorhanden

    ELSE - 99
    END
   ELSE - 999
   END AS BIGNUMERIC) AS bericht_kz,
 cpro.projekt_nr,
 cpro.projekt_nr_endung,
 cpro.cpr_projekt_bez,
 cpro.cpr_projekt_langtext,
   CAST(MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS STRING)
   || ' - ' || CAST(MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS STRING)
   AS cpr_projekt_dauer,
    'EW: ' || CAST(MIN(cpro.dat_w_beginn) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS STRING)
     || ' - ' || CAST(MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS STRING)
   AS cpr_projekt_werbung,
 MIN(COALESCE(cpro.dat_apl, snowconvert_public.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr
    ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS dat_freigabe,
 DATE_SUB(MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr
     IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND
   CURRENT ROW), INTERVAL 16 * 7 DAY) AS dat_bericht_von,
 MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro
    .projekt_nr, cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
 AS dat_projekt_start,
 MAX(cpro.dat_werbung) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id
    IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS dat_werbung,
 MIN(cpro.dat_w_beginn) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id
    IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS dat_werbung_von,
 MAX(cpro.dat_abschluss) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.bauabschnitt_id
    IS NULL, cpro.bauabschnitt_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS dat_abschluss,
 cpro.bauabschnitt_id AS cpr_phase_nr,
   (RANK() OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr IS NULL, cpro.projekt_nr, cpro.teil_massn_kz
      IS NULL, cpro.teil_massn_kz, COALESCE(cpro.dat_beginn, snowconvert_public.teradata_numeric_date_to_date(1901231))
      IS NULL, COALESCE(cpro.dat_beginn, snowconvert_public.teradata_numeric_date_to_date(1901231)), COALESCE(cpro.dat_ende
       , snowconvert_public.teradata_numeric_date_to_date(1901231)) IS NULL, COALESCE(cpro.dat_ende,
       snowconvert_public.teradata_numeric_date_to_date(1901231)), cpro.bauabschnitt_id IS NULL, cpro.bauabschnitt_id))
  - 1 AS cpr_phase_lfd,
 cpro.teil_massn_kz,
 cpro.bauabschnitt_bez AS cpr_phase_bez,
 cpro.bauabschnitt_langtext AS cpr_phase_langtext,
 COALESCE(CAST(cpro.dat_beginn AS STRING) || ' - ' || CAST(cpro.dat_ende AS STRING), '' || CAST(cpro.dat_ende AS STRING)
   ) AS cpr_phase_dauer,
    'EW: ' || CAST(cpro.dat_w_beginn AS STRING) || ' - ' || CAST(cpro.dat_w_ende AS STRING) AS cpr_phase_werbung,
 cpro.dat_beginn AS dat_baubeginn,
 cpro.dat_soll_beginn AS dat_baubeginn_soll,
 cpro.dat_ist_beginn AS dat_baubeginn_ist,
 cpro.dat_einricht AS dat_einrichtung,
 cpro.dat_ende AS dat_stille_eroeffnung,
 cpro.dat_soll_ende AS dat_stille_eroeffnung_soll,
 cpro.dat_ist_ende AS dat_stille_eroeffnung_ist,
 cpro.dat_werbung AS dat_eroeffnung_werb,
 cpro.dat_soll_werbung AS dat_eroeffnung_werb_soll,
 cpro.dat_ist_werbung AS dat_eroeffnung_werb_ist,
 cpro.dat_w_beginn AS dat_von_werb,
 cpro.dat_soll_w_beginn AS dat_von_werb_soll,
 cpro.dat_ist_w_beginn AS dat_von_werb_ist,
 cpro.dat_w_ende AS dat_bis_werb,
 cpro.dat_soll_w_ende AS dat_bis_werb_soll,
 cpro.dat_ist_w_ende AS dat_bis_werb_ist,
 COALESCE(cpro.gj, 2090) AS gj,
 cpro.cpr_projekt_status1,
 cpro.cpr_projekt_status2,
 cpro.cpr_projekt_status3,
 cpro.cpr_phase_status1,
 cpro.cpr_phase_status2,
 cpro.cpr_phase_status3,
 cpro.cpr_cl_au_status1_id,
 cpro.cpr_cl_au_status2_id,
 cpro.cpr_cl_au_status3_id,
 0 AS bericht_fg,
 '' AS cpr_projekt_txt,
 '' AS cpr_phase_txt,
 '' AS cpr_werbung_txt,
 '' AS einzel_massnahme,
 '' AS teil_massnahme_id
FROM (SELECT mandant_id,
   nb_id,
   wup_id,
   land_id
  FROM kfl_production_dbp_view.v_wup
  WHERE nb_id = 0
   AND dat_von > DATE('1900-01-01')
   AND dat_eroeffnung > DATE('1900-01-01')) AS wp
 INNER JOIN (SELECT mandant_id,
   techn_platz_id,
   wup_id,
   land_id
  FROM kfl_production_dbp_view.v_techn_platz_per
  WHERE techn_platz_ebene_id = 2
   AND dat_bis = DATE('9999-12-31')) AS tpl ON wp.mandant_id = tpl.mandant_id AND wp.wup_id = tpl.wup_id
 INNER JOIN (SELECT techn_platz_id,
   projekt_nr,
   SUBSTR(projekt_nr, 14, 2) AS projekt_nr_endung,
   cpr_projekt_bez,
   cpr_projekt_langtext,
   massnahme_id,
   teil_massn_kz,
   bauabschnitt_id,
   bauabschnitt_bez,
   bauabschnitt_langtext,
   gj,
   MAX(cpr_projekt_status1) AS cpr_projekt_status1,
   MAX(cpr_projekt_status2) AS cpr_projekt_status2,
   MAX(cpr_projekt_status3) AS cpr_projekt_status3,
   MAX(cpr_phase_status1) AS cpr_phase_status1,
   MAX(cpr_phase_status2) AS cpr_phase_status2,
   MAX(cpr_phase_status3) AS cpr_phase_status3,
   MAX(cpr_cl_au_status1_id) AS cpr_cl_au_status1_id,
   MAX(cpr_cl_au_status2_id) AS cpr_cl_au_status2_id,
   MAX(cpr_cl_au_status3_id) AS cpr_cl_au_status3_id,
   MAX(CASE
     WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL')
     THEN dat_termin
     ELSE NULL
     END) AS dat_apl,
   MIN(CASE
     WHEN cpr_suchfeld IN ('BAUBEGINN')
     THEN dat_termin
     ELSE NULL
     END) AS dat_beginn,
   MAX(CASE
     WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL')
     THEN dat_termin
     ELSE NULL
     END) AS dat_einricht,
   MAX(CASE
     WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL')
     THEN dat_termin
     ELSE NULL
     END) AS dat_ende,
   MAX(CASE
     WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL')
     THEN dat_termin
     ELSE NULL
     END) AS dat_werbung,
   MAX(CASE
     WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL')
     THEN dat_termin
     ELSE NULL
     END) AS dat_w_beginn,
   MAX(CASE
     WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL')
     THEN dat_termin
     ELSE NULL
     END) AS dat_w_ende,
   MAX(CASE
     WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL')
     THEN dat_termin
     ELSE NULL
     END) AS dat_abschluss,
   MIN(CASE
     WHEN cpr_suchfeld IN ('BAUBEGINN')
     THEN dat_prognose_termin
     ELSE NULL
     END) AS dat_soll_beginn,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_prognose_termin
     ELSE NULL
     END) AS dat_soll_ende,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_prognose_termin
     ELSE NULL
     END) AS dat_soll_werbung,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_prognose_termin
     ELSE NULL
     END) AS dat_soll_w_beginn,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_prognose_termin
     ELSE NULL
     END) AS dat_soll_w_ende,
   MIN(CASE
     WHEN cpr_suchfeld IN ('BAUBEGINN')
     THEN dat_ist_termin
     ELSE NULL
     END) AS dat_ist_beginn,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_ist_termin
     ELSE NULL
     END) AS dat_ist_ende,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_ist_termin
     ELSE NULL
     END) AS dat_ist_werbung,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_ist_termin
     ELSE NULL
     END) AS dat_ist_w_beginn,
   MAX(CASE
     WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')
     THEN dat_ist_termin
     ELSE NULL
     END) AS dat_ist_w_ende
  FROM (SELECT ph.mandant_id,
     ph.projekt_nr,
     ph.techn_platz_id,
     ph.projekt_id,
     ph.bauabschnitt_id,
     ph.bauabschnitt_bez,
     ph.bauabschnitt_langtext,
     ph.gj,
     ph.cpr_projekt_bez,
     ph.cpr_projekt_langtext,
     ph.massnahme_id,
     ph.teil_massn_kz,
     cl_au.checkliste_punkt_id,
     cl_au.cpr_checkliste_id,
     cl_au.projekt_phase_id,
     CAST(CASE
       WHEN DATE(COALESCE(CASE
           WHEN CASE
              WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
              THEN cl_au.dat_ende_ist
              ELSE DATE(NULL)
              END <> DATE('1900-01-01') AND CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END IS NOT NULL
           THEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END
           ELSE NULL
           END, CASE
           WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
           THEN cl_au.dat_ende_vorhersage
           ELSE NULL
           END, CASE
           WHEN CASE
             WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
             THEN cl_au.dat_ende_einschraenkung
             ELSE DATE(NULL)
             END >= CURRENT_DATE
           THEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END
           ELSE NULL
           END)) <= CURRENT_DATE
       THEN 1
       WHEN DATE(COALESCE(CASE
           WHEN CASE
              WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
              THEN cl_au.dat_ende_ist
              ELSE DATE(NULL)
              END <> DATE('1900-01-01') AND CASE
             WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
             THEN cl_au.dat_ende_ist
             ELSE DATE(NULL)
             END IS NOT NULL
           THEN CASE
            WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
            THEN cl_au.dat_ende_ist
            ELSE DATE(NULL)
            END
           ELSE NULL
           END, CASE
           WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage >= CURRENT_DATE
           THEN cl_au.dat_ende_vorhersage
           ELSE NULL
           END, CASE
           WHEN CASE
             WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
             THEN cl_au.dat_ende_einschraenkung
             ELSE DATE(NULL)
             END >= CURRENT_DATE
           THEN CASE
            WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
            THEN cl_au.dat_ende_einschraenkung
            ELSE DATE(NULL)
            END
           ELSE NULL
           END)) > CURRENT_DATE
       THEN 0
       ELSE - 1
       END AS BIGNUMERIC) AS termin_fg,
      CASE
      WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
      THEN cl_au.dat_ende_ist
      ELSE DATE(NULL)
      END AS dat_ist_termin,
      CASE
      WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_ende_einschraenkung
      ELSE DATE(NULL)
      END AS dat_soll_termin,
      CASE
      WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
         >= CURRENT_DATE
      THEN cl_au.dat_ende_vorhersage
      ELSE NULL
      END AS dat_prognose_termin,
     DATE(COALESCE(CASE
        WHEN CASE
          WHEN cl_au.dat_start_ist <> DATE('1900-01-01')
          THEN cl_au.dat_start_ist
          ELSE DATE(NULL)
          END = DATE('1900-01-01')
        THEN NULL
        ELSE CASE
         WHEN cl_au.dat_start_ist <> DATE('1900-01-01')
         THEN cl_au.dat_start_ist
         ELSE DATE(NULL)
         END
        END, CASE
        WHEN CASE
          WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_start_einschraenkung
          ELSE DATE(NULL)
          END >= CURRENT_DATE
        THEN CASE
         WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_start_einschraenkung
         ELSE DATE(NULL)
         END
        ELSE NULL
        END)) AS dat_start_termin,
      CASE
      WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
      THEN cl_au.dat_start_einschraenkung
      ELSE DATE(NULL)
      END AS dat_start_soll,
     DATE(COALESCE(CASE
        WHEN CASE
           WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
           THEN cl_au.dat_ende_ist
           ELSE DATE(NULL)
           END <> DATE('1900-01-01') AND CASE
          WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
          THEN cl_au.dat_ende_ist
          ELSE DATE(NULL)
          END IS NOT NULL
        THEN CASE
         WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> DATE('1900-01-01')
         THEN cl_au.dat_ende_ist
         ELSE DATE(NULL)
         END
        ELSE NULL
        END, CASE
        WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> DATE('1900-01-01') AND cl_au.dat_ende_vorhersage
           >= CURRENT_DATE
        THEN cl_au.dat_ende_vorhersage
        ELSE NULL
        END, CASE
        WHEN CASE
          WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
          THEN cl_au.dat_ende_einschraenkung
          ELSE DATE(NULL)
          END >= CURRENT_DATE
        THEN CASE
         WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> DATE('1900-01-01')
         THEN cl_au.dat_ende_einschraenkung
         ELSE DATE(NULL)
         END
        ELSE NULL
        END)) AS dat_termin,
     '' AS text_termin,
     '' AS text2_termin,
      CASE
      WHEN cl_au.dat_ende_ist <> DATE('1900-01-01') AND CASE
          WHEN cl_au.dat_start_ist <> DATE('1900-01-01')
          THEN cl_au.dat_start_ist
          ELSE DATE(NULL)
          END <> DATE('1900-01-01') AND cl_au.dat_ende_ist >= CASE
         WHEN cl_au.dat_start_ist <> DATE('1900-01-01')
         THEN cl_au.dat_start_ist
         ELSE DATE(NULL)
         END
      THEN DATE_DIFF(cl_au.dat_ende_ist, CASE
        WHEN cl_au.dat_start_ist <> DATE('1900-01-01')
        THEN cl_au.dat_start_ist
        ELSE DATE(NULL)
        END, DAY)
      WHEN cl_au.dat_ende_einschraenkung <> DATE('1900-01-01') AND cl_au.dat_start_einschraenkung <> DATE('1900-01-01')
       AND cl_au.dat_ende_einschraenkung >= cl_au.dat_start_einschraenkung
      THEN DATE_DIFF(cl_au.dat_ende_einschraenkung, cl_au.dat_start_einschraenkung, DAY)
      ELSE 0
      END AS dauer_termin,
     cl_au.sortier_nummer,
     cl_au.ok_fg,
     cl_au.nicht_ok_fg,
     cl_au.nicht_relevant_fg,
     cl_au.obligatorisch_fg,
     cl_au.cpr_suchfeld,
     cl_au.cpr_suchfeld_id,
     cl_au.cpr_prozess,
     cl_au.terminart,
      CASE
      WHEN cl_au.dat_start_ist <> DATE('1900-01-01')
      THEN cl_au.dat_start_ist
      ELSE DATE(NULL)
      END AS dat_start_ist,
     cl_au.dat_ende_ist,
     cl_au.dat_start_max,
     cl_au.dat_ende_max,
     cl_au.dat_start_plan,
     cl_au.dat_ende_plan,
     cl_au.dat_start_einschraenkung,
     cl_au.dat_ende_einschraenkung,
     cl_au.gesamt_puffer,
     cl_au.dauer,
     cl_au.cpr_prio,
     cl_au.dat_erstellung,
     ph.cpr_projekt_status1,
     ph.cpr_projekt_status2,
     ph.cpr_projekt_status3,
     ph.cpr_phase_status1,
     ph.cpr_phase_status2,
     ph.cpr_phase_status3,
     cl_au.cpr_systemstatus1_id AS cpr_cl_au_status1_id,
     cl_au.cpr_systemstatus3_id AS cpr_cl_au_status3_id,
     cl_au.cpr_systemstatus2_id AS cpr_cl_au_status2_id,
     cl_au.sortier_nr_mhrwrtgkt
    FROM (SELECT CP.checkliste_punkt_id,
        CP.cpr_checkliste_id,
        CL.projekt_phase_id,
        MOD(CAST(CP.sortier_nummer AS BIGNUMERIC), 100) AS sortier_nummer,
        CP.ok_fg,
        CP.nicht_ok_fg,
        CP.nicht_relevant_fg,
        CP.obligatorisch_fg,
        SU.cpr_suchfeld,
        SUBSTR(NULL, 1, 40) AS cpr_prozess,
        SUBSTR(NULL, 1, 20) AS terminart,
        CP.dat_start_ist,
        CP.dat_ende_ist,
        CP.dat_start_max,
        CP.dat_ende_max,
        CP.dat_start_plan,
        CP.dat_ende_plan,
        CP.dat_start_einschraenkung,
        CP.dat_ende_einschraenkung,
        CP.gesamt_puffer,
        CAST(NULL AS NUMERIC) AS dauer,
        CP.cpr_prio,
        CP.dat_erstellung,
        CP.cpr_systemstatus1_id,
        CP.cpr_systemstatus3_id,
        CP.cpr_systemstatus2_id,
        CP.cpr_suchfeld_id,
        CP.sortier_nr_mhrwrtgkt,
         CASE
         WHEN CP.dat_ende_vorhersage IS NOT NULL AND CP.dat_ende_vorhersage <> DATE('1900-01-01')
         THEN CP.dat_ende_vorhersage
         ELSE DATE(NULL)
         END AS dat_ende_vorhersage,
         CASE
         WHEN CP.dat_start_vorhersage IS NOT NULL AND CP.dat_start_vorhersage <> DATE('1900-01-01')
         THEN CP.dat_start_vorhersage
         ELSE DATE(NULL)
         END AS dat_start_vorhersage
       FROM kfl_production_dbp_view.v_cpr_cl_punkt_per AS CP
        INNER JOIN kfl_production_dbp_view.v_cpr_checkliste_per AS CL ON CP.cpr_checkliste_id = CL.cpr_checkliste_id AND
          CL.dat_bis = DATE('9999-12-31')
        INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld AS SU ON CP.cpr_suchfeld_id = SU.cpr_suchfeld_id
       WHERE CP.dat_bis = DATE('9999-12-31')
        AND SU.cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL', 'BAUBEGINN', 'BEGINN_EINRICHTUNG',
          'STILLE_EROEFFNUNG', 'IST_AUFNAHME_TECHNIK', 'EROEFFNUNG_TIP_TOP', 'CPR_EOEWE_E', 'CPR_EOEWE_A',
          'CPR_REALISIERUNG') -- VIS Ausschnitt

       UNION DISTINCT
       SELECT SUBSTR(CAST(AU.cpr_aufgabe_id AS STRING), 1, 32) AS checkliste_punkt_id,
        SUBSTR(NULL, 1, 32) AS cpr_checkliste_id,
        AU.projekt_phase_id,
        AU.sortier_nummer,
         CASE
         WHEN AU.cpr_systemstatus1_id IN (2, 3, 6)
         THEN 1
         ELSE 0
         END AS ok_fg,
         CASE
         WHEN AU.cpr_systemstatus1_id IN (2, 3, 6)
         THEN 0
         ELSE 1
         END AS nicht_ok_fg,
         CASE
         WHEN AU.cpr_systemstatus1_id = 4
         THEN 1
         ELSE 0
         END AS nicht_relevant_fg,
        0 AS obligatorisch_fg,
         CASE
         WHEN SU.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN'
         THEN 'KBE_BAUANTRAG'
         WHEN SU.cpr_suchfeld = 'CPR_REALISIERUNG'
         THEN 'BAUBEGINN'
         ELSE SU.cpr_suchfeld
         END AS cpr_suchfeld,
        SUBSTR(NULL, 1, 40) AS cpr_prozess,
        SUBSTR(NULL, 1, 20) AS terminart,
        AU.dat_start_ist,
         CASE
         WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN')
         THEN AU.dat_start_ist
         ELSE AU.dat_ende_ist
         END AS dat_ende_ist,
        AU.dat_start_max,
         CASE
         WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
         THEN AU.dat_start_max
         ELSE AU.dat_ende_max
         END AS dat_ende_max,
        AU.dat_start_plan,
         CASE
         WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
         THEN AU.dat_start_plan
         ELSE AU.dat_ende_plan
         END AS dat_ende_plan,
        AU.dat_start_einschraenkung,
         CASE
         WHEN SU.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN', 'CPR_REALISIERUNG')
         THEN AU.dat_start_einschraenkung
         ELSE AU.dat_ende_einschraenkung
         END AS dat_ende_einschraenkung,
        AU.gesamt_puffer,
        AU.dauer,
        AU.cpr_prio,
        DATE(NULL) AS dat_erstellung,
        AU.cpr_systemstatus1_id,
        AU.cpr_systemstatus3_id,
        AU.cpr_systemstatus2_id,
        SU.cpr_suchfeld_id,
        1 AS sortier_nr_mhrwrtgkt,
         CASE
         WHEN AU.dat_ende_vorhersage IS NOT NULL AND AU.dat_ende_vorhersage <> DATE('1900-01-01')
         THEN AU.dat_ende_vorhersage
         ELSE DATE(NULL)
         END AS dat_ende_vorhersage,
         CASE
         WHEN AU.dat_start_vorhersage IS NOT NULL AND AU.dat_start_vorhersage <> DATE('1900-01-01')
         THEN AU.dat_start_vorhersage
         ELSE DATE(NULL)
         END AS dat_start_vorhersage
       FROM kfl_production_dbp_view.v_cpr_aufgabe_per AS AU
        INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld AS SU ON AU.cpr_suchfeld_id = SU.cpr_suchfeld_id
       WHERE AU.dat_bis = DATE('9999-12-31')
        AND SU.cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL', 'BAUBEGINN', 'BEGINN_EINRICHTUNG',
          'STILLE_EROEFFNUNG', 'IST_AUFNAHME_TECHNIK', 'EROEFFNUNG_TIP_TOP', 'CPR_EOEWE_E', 'CPR_EOEWE_A',
          'CPR_REALISIERUNG') -- VIS Ausschnitt
 -- UNION -- Projekt 3. Aufgaben entfaellt, da irrelevant in VIS
) AS
     cl_au
     INNER JOIN (SELECT PR.mandant_id,
       PR.techn_platz_id,
       PR.cpr_ext_id AS projekt_nr,
       PH.dat_freigabe,
       PR.gj,
       PR_S.cpr_projekt_bez,
       PR_S.cpr_projekt_langtext,
       PH.teil_massn_kz,
        CASE
        WHEN PH.teil_massn_kz > 1
        THEN PH_S.cpr_phase_bez
        ELSE PR_S.cpr_projekt_bez
        END AS bauabschnitt_bez,
        CASE
        WHEN PH.teil_massn_kz > 1
        THEN COALESCE(PH_S.cpr_phase_langtext, '')
        WHEN PH.teil_massn_kz = 1
        THEN COALESCE(PH_S.cpr_phase_langtext, PR_S.cpr_projekt_langtext, '')
        ELSE COALESCE(PR_S.cpr_projekt_langtext, '')
        END AS bauabschnitt_langtext,
       PR.massnahme_id,
        CASE
        WHEN PH.teil_massn_kz >= 1
        THEN PR.projekt_id || PH.projekt_phase_id
        ELSE PR.projekt_id || '0000'
        END AS bauabschnitt_id,
       PH.projekt_phase_id,
       PH.projekt_id,
       PH.phasenart_id,
       PR.cpr_systemstatus1_id AS cpr_projekt_status1,
       PR.cpr_systemstatus2_id AS cpr_projekt_status2,
       PR.cpr_systemstatus3_id AS cpr_projekt_status3,
       PH.cpr_systemstatus1_id AS cpr_phase_status1,
       PH.cpr_systemstatus2_id AS cpr_phase_status2,
       PH.cpr_systemstatus3_id AS cpr_phase_status3
      FROM kfl_production_dbp_view.v_cpr_phase_per AS PH
       INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per AS PR ON PH.projekt_id = PR.projekt_id AND PR.dat_bis =
           DATE '9999-12-31' AND PR.cpr_systemstatus1_id IN (2, 3, 6)
         -- PROJEKT Status1 : 2 Freigegeben, 3 Abgeschlossen, 4 Erledigt
 AND PR.cpr_systemstatus2_id NOT IN (1)
       INNER JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per AS PR_S ON PR.projekt_id = PR_S.projekt_id AND PR_S.dat_bis
           = DATE '9999-12-31' AND PR_S.spr_id = 22
       INNER JOIN kfl_production_dbp_view.v_cpr_phase_spr_zu_per AS PH_S ON PH.projekt_phase_id = PH_S.projekt_phase_id
         AND PH_S.dat_bis = DATE '9999-12-31' AND PH_S.spr_id = 22
       INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld AS SU0 ON PH.cpr_suchfeld_id = SU0.cpr_suchfeld_id
      WHERE PH.dat_bis = DATE '9999-12-31'
       AND PH.cpr_systemstatus1_id IN (2, 3, 6) -- PHASE Status1 : 2 Freigegeben, 3 Abgeschlossen, 4 Erledigt

       AND PR.massnahme_id IN ('RE', 'RN', 'ST', 'ZPPM_RE', 'ZPPM_RN', 'ZPPM_ST', 'ZPPM_MM')
       -- PROJEKT MASSNAHME: Reorga, SOA + Marktmodernisierung

       AND PH.cpr_systemstatus2_id NOT IN (1)) AS ph ON cl_au.projekt_phase_id = ph.projekt_phase_id) AS cp0
  WHERE ok_fg = 1
   OR ok_fg = 0 AND nicht_ok_fg = 0 AND nicht_relevant_fg = 0 AND dat_termin >= CURRENT_DATE
  GROUP BY techn_platz_id,
   projekt_nr,
   projekt_nr_endung,
   cpr_projekt_bez,
   cpr_projekt_langtext,
   massnahme_id,
   teil_massn_kz,
   bauabschnitt_id,
   bauabschnitt_bez,
   bauabschnitt_langtext,
   gj) AS cpro ON tpl.techn_platz_id = cpro.techn_platz_id;



