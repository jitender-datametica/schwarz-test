CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_CPROJECTS_2
AS
   -- FAKT cProjects (IOS) denormalisiert
   -- Verkn¸pfung Markt (wup_2) mit und cProjects-Daten (Projekt/Phase/Ma?nahmnen/Termine)
   -- 2009-06-08 Initial
   -- 2009KW27 : Anpassung cpr-Felder
   -- 2009KW37 : Anpassung Gueltigkeit (+ abgeschlossene Projekte)
   -- 2012KW46 Review
   -- 2013KW09 Abloesung MDR-Reorga. Komplette Ueberarbeitung, Basis neue IOS Views,
   -- 2013KW09 Einschraenkung auf Reorga/Standortoptimierung Massnahmen
   -- 2013KW13 Update Eroeffnungswerbung (COALESCE)
   -- 20130806 Update Massnahmen (+ ZPPM_xy)
   -- 2014KW46 Anpassung Logik (ohne Suchfeld CPR_REALISIERUNG; ohne phase cpr_systemstatus2_id=1)
   -- 2015KW26 komplettes Redesign GJ2015 (Anfo 612890)
   -- 2015KW37 Finetuning IST/SOLL Felder fuer Pruefbericht ...
   -- 2016KW04 Erweiterung Marktmodernisierung
   -- 20160819 tuts : Angeglichen an IOS-Logik f¸r Datumsfelder
   -- 20160826 ssch0611 : Baubeginn auf MIN(DAT), SOLL Felder auf Prognose gemappt



   SELECT
   wp.mandant_id,
   wp.nb_id,
   wp.wup_id,
   CASE
  WHEN cpro.massnahme_id IN ('ST','ZPPM_ST') THEN 3
  WHEN cpro.massnahme_id IN ('RE_2','RN','ZPPM_RE','ZPPM_RN') THEN 4
  WHEN cpro.massnahme_id IN ('ZPPM_MM') THEN 11
  ELSE 0
  END::BYTEINT AS massnahme_typ_id,
   CASE
  WHEN cpro.massnahme_id IN ('ST','ZPPM_ST') THEN 'Standortoptimierung'
  WHEN cpro.massnahme_id IN ('RE_2','RN','ZPPM_RE','ZPPM_RN') THEN 'Reorga'
  WHEN cpro.massnahme_id IN ('ZPPM_MM') THEN 'Marktmodernisierung'
  ELSE 'nicht definiert'
  END::VARCHAR(40) AS massnahme_typ_bez,
  MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id)                    AS DAT_PROJEKT_ENDE,
  MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id)                                             AS DAT_WERBUNG_BIS,
     CASE
  WHEN DAT_PROJEKT_ENDE > DAT_WERBUNG_BIS THEN DAT_PROJEKT_ENDE
  WHEN DAT_PROJEKT_ENDE < DAT_WERBUNG_BIS THEN DAT_WERBUNG_BIS
  ELSE DAT_PROJEKT_ENDE
  END + (16 * 7)                                                                                                                              AS DAT_BERICHT_BIS,
   CASE
  WHEN cpro.teil_massn_kz > 0 THEN CASE                                                               -- BAUABSCHNITT (relevant fuer Bericht)
  WHEN CURRENT_DATE > MIN(COALESCE(cpro.dat_apl, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AND CURRENT_DATE < MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) THEN 2                                        -- kuenftig
   WHEN CURRENT_DATE > MIN(COALESCE(cpro.dat_apl, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AND CURRENT_DATE BETWEEN MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) AND (/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
DAT_BERICHT_BIS + (5 * 7)) THEN 1  -- aktuell (5 Wochen Offset da Monatsreporting)
   WHEN CURRENT_DATE > MIN(COALESCE(cpro.dat_apl, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AND CURRENT_DATE > /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 DAT_BERICHT_BIS THEN 0                                        -- historisch
   WHEN CURRENT_DATE BETWEEN MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) AND /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 DAT_BERICHT_BIS THEN -1                                     -- nicht freigegeben
   WHEN MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) > to_date('1900-01-01') THEN -3                                                                -- Daten vorhanden
   ELSE -9 END
   WHEN cpro.teil_massn_kz < 1 THEN CASE                                                               -- KOPFZEILE (Berechnung in mv_view)
   WHEN CURRENT_DATE > MIN(COALESCE(cpro.dat_apl, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AND CURRENT_DATE < MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) THEN 12                                       -- kuenftig
   WHEN CURRENT_DATE > MIN(COALESCE(cpro.dat_apl, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AND CURRENT_DATE BETWEEN MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) AND (/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
/*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
DAT_BERICHT_BIS + (5 * 7)) THEN 11 -- aktuell (5 Wochen Offset da Monatsreporting)
   WHEN CURRENT_DATE > MIN(COALESCE(cpro.dat_apl, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AND CURRENT_DATE > /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 DAT_BERICHT_BIS THEN 10                                       -- historisch
   WHEN CURRENT_DATE BETWEEN MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) AND /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 /*Conversion issue - Severity Medium - 'DAT_BERICHT_BIS' has recursive references. Forward alias conversion could not be completed*/
 DAT_BERICHT_BIS THEN -11                                    -- nicht freigegeben
   WHEN MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7) > to_date('1900-01-01') THEN -33                                                               -- Daten vorhanden
   ELSE -99 END
   ELSE -999
   END::BYTEINT                                                                                                                               AS BERICHT_KZ,
   cpro.projekt_nr                                                                                                                             AS projekt_nr,
   cpro.projekt_nr_endung                                                                                                                      AS projekt_nr_endung,
   cpro.cpr_projekt_bez                                                                                                                        AS cpr_projekt_bez,
   cpro.cpr_projekt_langtext                                                                                                                   AS cpr_projekt_langtext,
   CAST( MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AS VARCHAR) || ' - ' || CAST( MAX(COALESCE(cpro.dat_ende, cpro.dat_beginn)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AS VARCHAR)::VARCHAR(40)            AS cpr_projekt_dauer,
   'EW: ' || CAST( MIN(cpro.dat_w_beginn) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AS VARCHAR) || ' - ' || CAST( MAX(cpro.dat_w_ende) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) AS VARCHAR)::VARCHAR(40)     AS cpr_projekt_werbung,
   MIN(COALESCE(cpro.dat_apl, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231))) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id)               AS DAT_FREIGABE,
   MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id) - (16 * 7)                                                                                                                AS DAT_BERICHT_VON,
   MIN(COALESCE(cpro.dat_beginn, cpro.dat_ende)) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id)                    AS DAT_PROJEKT_START,
   
   MAX(cpro.dat_werbung) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id)                                            AS DAT_WERBUNG,
   MIN(cpro.dat_w_beginn) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id)                                           AS DAT_WERBUNG_VON,
   

   MAX(cpro.dat_abschluss) OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.bauabschnitt_id)                                          AS DAT_ABSCHLUSS,
   cpro.bauabschnitt_id                                                                                                                        AS cpr_phase_nr,
   (RANK() OVER (PARTITION BY cpro.projekt_nr ORDER BY cpro.projekt_nr, cpro.teil_massn_kz, COALESCE( cpro.dat_beginn, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231)), COALESCE( cpro.dat_ende, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date(1901231)), cpr_phase_nr) - 1)  AS cpr_phase_lfd,
   cpro.teil_massn_kz                                                                                                                          AS teil_massn_kz,
   cpro.bauabschnitt_bez                                                                                                                       AS cpr_phase_bez,
   cpro.bauabschnitt_langtext                                                                                                                  AS cpr_phase_langtext,
   COALESCE(CAST( cpro.dat_beginn AS VARCHAR) || ' - ' || CAST( cpro.dat_ende AS VARCHAR), '' || CAST( cpro.dat_ende AS VARCHAR))::VARCHAR(40)  AS cpr_phase_dauer,
   'EW: ' || CAST( cpro.dat_w_beginn AS VARCHAR) || ' - ' || CAST( cpro.dat_w_ende AS VARCHAR)::VARCHAR(40)           AS cpr_phase_werbung,
   cpro.dat_beginn                                                                                                                             AS DAT_BAUBEGINN,
   cpro.dat_soll_beginn                                                                                                                        AS DAT_BAUBEGINN_SOLL,
   cpro.dat_ist_beginn                                                                                                                         AS DAT_BAUBEGINN_IST,
   cpro.dat_einricht                                                                                                                           AS DAT_EINRICHTUNG,
   cpro.dat_ende                                                                                                                               AS DAT_STILLE_EROEFFNUNG,
   cpro.dat_soll_ende                                                                                                                          AS DAT_STILLE_EROEFFNUNG_SOLL,
   cpro.dat_ist_ende                                                                                                                           AS DAT_STILLE_EROEFFNUNG_IST,
   cpro.dat_werbung                                                                                                                            AS DAT_EROEFFNUNG_WERB,
   cpro.dat_soll_werbung                                                                                                                       AS DAT_EROEFFNUNG_WERB_SOLL,
   cpro.dat_ist_werbung                                                                                                                        AS DAT_EROEFFNUNG_WERB_IST,
   cpro.dat_w_beginn                                                                                                                           AS DAT_VON_WERB,
   cpro.dat_soll_w_beginn                                                                                                                      AS DAT_VON_WERB_SOLL,
   cpro.dat_ist_w_beginn                                                                                                                       AS DAT_VON_WERB_IST,
   cpro.dat_w_ende                                                                                                                             AS DAT_BIS_WERB,
   cpro.dat_soll_w_ende                                                                                                                        AS DAT_BIS_WERB_SOLL,
   cpro.dat_ist_w_ende                                                                                                                         AS DAT_BIS_WERB_IST,
   COALESCE(cpro.gj,2090) AS GJ,
   cpro.cpr_projekt_status1,
   cpro.cpr_projekt_status2,
   cpro.cpr_projekt_status3,
   cpro.cpr_phase_status1,
   cpro.cpr_phase_status2,
   cpro.cpr_phase_status3,
   cpro.cpr_cl_au_status1_id,
   cpro.cpr_cl_au_status2_id,
   cpro.cpr_cl_au_status3_id,
   0 AS BERICHT_FG,
   ''::VARCHAR(40) AS cpr_projekt_txt,
   ''::VARCHAR(40) AS cpr_phase_txt,
   ''::VARCHAR(40) AS cpr_werbung_txt,
   '' AS einzel_massnahme,
   '' AS teil_massnahme_id
  FROM
  ( -- Marktstamm
  SELECT mandant_id,
   nb_id,
   wup_id,
   land_id
  FROM dbp_view.v_wup_2
  WHERE nb_id = 0
  AND dat_von > to_date('1900-01-01') AND dat_eroeffnung > to_date('1900-01-01')
  ) wp

  JOIN
  ( -- Techn Platz
  SELECT mandant_id,
   techn_platz_id,
   wup_id,
   land_id
  FROM dbp_view.v_techn_platz_per_2
  WHERE techn_platz_ebene_id = 2 AND dat_bis = to_date('9999-12-31')
  ) tpl
   ON tpl.mandant_id = wp.mandant_id AND tpl.wup_id = wp.wup_id

   JOIN
   ( -- cProjects
   SELECT
   cp0.techn_platz_id, cp0.projekt_nr, SUBSTRING(cp0.projekt_nr, 14, 2) AS projekt_nr_endung -- Reserve
   , cp0.cpr_projekt_bez, cp0.cpr_projekt_langtext, cp0.massnahme_id, cp0.teil_massn_kz, cp0.bauabschnitt_id, cp0.bauabschnitt_bez, cp0.bauabschnitt_langtext, cp0.gj, MAX(cp0.cpr_projekt_status1) cpr_projekt_status1, MAX(cp0.cpr_projekt_status2) cpr_projekt_status2, MAX(cp0.cpr_projekt_status3) cpr_projekt_status3, MAX(cp0.cpr_phase_status1) cpr_phase_status1, MAX(cp0.cpr_phase_status2) cpr_phase_status2, MAX(cp0.cpr_phase_status3) cpr_phase_status3, MAX(cp0.cpr_cl_au_status1_id) cpr_cl_au_status1_id, MAX(cp0.cpr_cl_au_status2_id) cpr_cl_au_status2_id, MAX(cp0.cpr_cl_au_status3_id) cpr_cl_au_status3_id, MAX(CASE WHEN cpr_suchfeld IN ('CPR_PRV_APLNAT','CPR_PRV_INTAPL') THEN dat_termin END) dat_apl, MIN(CASE WHEN cpr_suchfeld IN ('BAUBEGINN')                       THEN dat_termin END) dat_beginn, MAX(CASE WHEN cpr_suchfeld IN ('BEGINN_EINRICHTUNG')              THEN dat_termin END) dat_einricht, MAX(CASE WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')               THEN dat_termin END) dat_ende, MAX(CASE WHEN cpr_suchfeld IN ('EROEFFNUNG_TIP_TOP')              THEN dat_termin END) dat_werbung, MAX(CASE WHEN cpr_suchfeld IN ('CPR_EOEWE_A')                     THEN dat_termin END) dat_w_beginn, MAX(CASE WHEN cpr_suchfeld IN ('CPR_EOEWE_E')                     THEN dat_termin END) dat_w_ende, MAX(CASE WHEN cpr_suchfeld IN ('IST_AUFNAHME_TECHNIK')            THEN dat_termin END) dat_abschluss, MIN(CASE WHEN cpr_suchfeld IN ('BAUBEGINN')                       THEN dat_prognose_termin END) dat_soll_beginn, MAX(CASE WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')               THEN dat_prognose_termin END) dat_soll_ende, MAX(CASE WHEN cpr_suchfeld IN ('EROEFFNUNG_TIP_TOP')              THEN dat_prognose_termin END) dat_soll_werbung, MAX(CASE WHEN cpr_suchfeld IN ('CPR_EOEWE_A')                     THEN dat_prognose_termin END) dat_soll_w_beginn, MAX(CASE WHEN cpr_suchfeld IN ('CPR_EOEWE_E')                     THEN dat_prognose_termin END) dat_soll_w_ende, MIN(CASE WHEN cpr_suchfeld IN ('BAUBEGINN')                       THEN dat_ist_termin END) dat_ist_beginn, MAX(CASE WHEN cpr_suchfeld IN ('STILLE_EROEFFNUNG')               THEN dat_ist_termin END) dat_ist_ende, MAX(CASE WHEN cpr_suchfeld IN ('EROEFFNUNG_TIP_TOP')              THEN dat_ist_termin END) dat_ist_werbung, MAX(CASE WHEN cpr_suchfeld IN ('CPR_EOEWE_A')                     THEN dat_ist_termin END) dat_ist_w_beginn, MAX(CASE WHEN cpr_suchfeld IN ('CPR_EOEWE_E')                     THEN dat_ist_termin END) dat_ist_w_ende
   FROM
   ( -- Projekt (Checkliste oder Aufgabe)
   SELECT
   ph.mandant_id,
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
   cl_au.checkliste_punkt_id  AS checkliste_punkt_id,
   cl_au.cpr_checkliste_id    AS cpr_checkliste_id,
   cl_au.projekt_phase_id     AS projekt_phase_id,
   CASE WHEN COALESCE(CASE WHEN CASE WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> to_date('1900-01-01') THEN cl_au.dat_ende_ist ELSE CAST(NULL AS DATE) END <> to_date('1900-01-01') AND CASE WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> to_date('1900-01-01') THEN cl_au.dat_ende_ist ELSE CAST(NULL AS DATE) END IS NOT NULL THEN CASE WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> to_date('1900-01-01') THEN cl_au.dat_ende_ist ELSE CAST(NULL AS DATE) END END,
   CASE WHEN dat_ende_vorhersage IS NOT NULL AND dat_ende_vorhersage <> to_date('1900-01-01') AND dat_ende_vorhersage >= CURRENT_DATE THEN dat_ende_vorhersage END,
   CASE WHEN CASE WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_ende_einschraenkung ELSE CAST(NULL AS DATE) END >= CURRENT_DATE THEN CASE WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_ende_einschraenkung ELSE CAST(NULL AS DATE) END END)::DATE <= CURRENT_DATE THEN 1 WHEN COALESCE(CASE WHEN CASE WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> to_date('1900-01-01') THEN cl_au.dat_ende_ist ELSE CAST(NULL AS DATE) END <> to_date('1900-01-01') AND CASE WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> to_date('1900-01-01') THEN cl_au.dat_ende_ist ELSE CAST(NULL AS DATE) END IS NOT NULL THEN CASE WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> to_date('1900-01-01') THEN cl_au.dat_ende_ist ELSE CAST(NULL AS DATE) END END,
   CASE WHEN dat_ende_vorhersage IS NOT NULL AND dat_ende_vorhersage <> to_date('1900-01-01') AND dat_ende_vorhersage >= CURRENT_DATE THEN dat_ende_vorhersage END,
   CASE WHEN CASE WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_ende_einschraenkung ELSE CAST(NULL AS DATE) END >= CURRENT_DATE THEN CASE WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_ende_einschraenkung ELSE CAST(NULL AS DATE) END END)::DATE > CURRENT_DATE THEN 0 ELSE -1 END::BYTEINT                                                                        AS termin_fg,
   CASE WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> to_date('1900-01-01') THEN cl_au.dat_ende_ist ELSE CAST(NULL AS DATE) END                                     AS dat_ist_termin,
   CASE WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_ende_einschraenkung ELSE CAST(NULL AS DATE) END    AS dat_soll_termin,
   CASE WHEN dat_ende_vorhersage IS NOT NULL AND dat_ende_vorhersage <> to_date('1900-01-01') AND dat_ende_vorhersage >= CURRENT_DATE THEN dat_ende_vorhersage END                          AS dat_prognose_termin,
   COALESCE(CASE WHEN CASE WHEN cl_au.dat_start_ist <> to_date('1900-01-01') THEN cl_au.dat_start_ist ELSE CAST(NULL AS DATE) END = to_date('1900-01-01') THEN NULL ELSE CASE WHEN cl_au.dat_start_ist <> to_date('1900-01-01') THEN cl_au.dat_start_ist ELSE CAST(NULL AS DATE) END END, CASE WHEN CASE WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_start_einschraenkung ELSE CAST(NULL AS DATE) END >= CURRENT_DATE THEN CASE WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_start_einschraenkung ELSE CAST(NULL AS DATE) END ELSE NULL END)::DATE             AS dat_start_termin,
   CASE WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> to_date('1900-01-01') THEN cl_au.dat_start_einschraenkung ELSE CAST(NULL AS DATE) END AS dat_start_soll,
   COALESCE(CASE WHEN dat_ist_termin <> to_date('1900-01-01') AND dat_ist_termin IS NOT NULL THEN dat_ist_termin END,
  CASE WHEN dat_ende_vorhersage IS NOT NULL AND dat_ende_vorhersage <> to_date('1900-01-01') AND dat_ende_vorhersage >= CURRENT_DATE THEN dat_ende_vorhersage END,
  CASE WHEN dat_soll_termin >= CURRENT_DATE THEN dat_soll_termin END)::DATE AS dat_termin --angeglichen an IOS-Logik
   ,
   '' AS text_termin  -- entfaellt, da irrelevant in VIS
   ,
   '' AS text2_termin -- entfaellt, da irrelevant in VIS
   ,
   CASE
  WHEN cl_au.dat_ende_ist <> to_date('1900-01-01') AND CASE WHEN cl_au.dat_start_ist <> to_date('1900-01-01') THEN cl_au.dat_start_ist ELSE CAST(NULL AS DATE) END <> to_date('1900-01-01') AND cl_au.dat_ende_ist >= CASE WHEN cl_au.dat_start_ist <> to_date('1900-01-01') THEN cl_au.dat_start_ist ELSE CAST(NULL AS DATE) END THEN cl_au.dat_ende_ist - CASE WHEN cl_au.dat_start_ist <> to_date('1900-01-01') THEN cl_au.dat_start_ist ELSE CAST(NULL AS DATE) END WHEN cl_au.dat_ende_einschraenkung <> to_date('1900-01-01') AND cl_au.dat_start_einschraenkung <> to_date('1900-01-01')  AND cl_au.dat_ende_einschraenkung >= cl_au.dat_start_einschraenkung THEN cl_au.dat_ende_einschraenkung - cl_au.dat_start_einschraenkung ELSE 0
   END  AS dauer_termin,
   cl_au.sortier_nummer AS sortier_nummer,
   cl_au.ok_fg   AS ok_fg,
   cl_au.nicht_ok_fg  AS nicht_ok_fg,
   cl_au.nicht_relevant_fg AS nicht_relevant_fg,
   cl_au.obligatorisch_fg AS obligatorisch_fg,
   cl_au.cpr_suchfeld AS cpr_suchfeld,
   cl_au.cpr_suchfeld_id AS cpr_suchfeld_id,
   cl_au.cpr_prozess  AS cpr_prozess,
   cl_au.terminart  AS terminart,
   CASE WHEN cl_au.dat_start_ist <> to_date('1900-01-01') THEN cl_au.dat_start_ist ELSE CAST(NULL AS DATE) END AS dat_start_ist,
   cl_au.dat_ende_ist AS dat_ende_ist,
   cl_au.dat_start_max  AS dat_start_max,
   cl_au.dat_ende_max AS dat_ende_max,
   cl_au.dat_start_plan AS dat_start_plan,
   cl_au.dat_ende_plan  AS dat_ende_plan,
   cl_au.dat_start_einschraenkung AS dat_start_einschraenkung,
   cl_au.dat_ende_einschraenkung AS dat_ende_einschraenkung,
   cl_au.gesamt_puffer  AS gesamt_puffer,
   cl_au.dauer   AS dauer,
   cl_au.cpr_prio  AS cpr_prio,
   cl_au.dat_erstellung AS dat_erstellung,
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
  FROM
  ( -- Projekt 1. Checkliste
  SELECT
  cp.checkliste_punkt_id,
   cp.cpr_checkliste_id,
   cl.projekt_phase_id,
   MOD(cp.sortier_nummer, 100) AS sortier_nummer,
   cp.ok_fg,
   cp.nicht_ok_fg,
   cp.nicht_relevant_fg,
   cp.obligatorisch_fg,
   su.cpr_suchfeld,
   CAST(NULL AS CHAR(40)) AS cpr_prozess,
   CAST(NULL AS CHAR(20)) AS terminart,
   cp.dat_start_ist,
   cp.dat_ende_ist,
   cp.dat_start_max,
   cp.dat_ende_max,
   cp.dat_start_plan,
   cp.dat_ende_plan,
   cp.dat_start_einschraenkung,
   cp.dat_ende_einschraenkung,
   cp.gesamt_puffer,
   CAST(NULL AS DECIMAL(18,3)) AS dauer,
   cp.cpr_prio,
   cp.dat_erstellung,
   cp.cpr_systemstatus1_id,
   cp.cpr_systemstatus3_id,
   cp.cpr_systemstatus2_id,
   cp.cpr_suchfeld_id,
   cp.sortier_nr_mhrwrtgkt,
   CASE WHEN cp.dat_ende_vorhersage IS NOT NULL AND cp.dat_ende_vorhersage <> to_date('1900-01-01') THEN cp.dat_ende_vorhersage ELSE CAST(NULL AS DATE) END           AS dat_ende_vorhersage --angeglichen an IOS-Logik
   ,
   CASE WHEN cp.dat_start_vorhersage IS NOT NULL AND cp.dat_start_vorhersage <> to_date('1900-01-01') THEN cp.dat_start_vorhersage ELSE CAST(NULL AS DATE) END        AS dat_start_vorhersage --angeglichen an IOS-Logik
  FROM dbp_view.v_cpr_cl_punkt_per_2 cp
   INNER JOIN dbp_view.v_cpr_checkliste_per_2  cl
   ON cp.cpr_checkliste_id = cl.cpr_checkliste_id
   AND cl.dat_bis = to_date('9999-12-31')
   INNER JOIN dbp_view.v_l_cpr_suchfeld_2 su
   ON cp.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE cp.dat_bis = to_date('9999-12-31')
   AND su.cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL', 'BAUBEGINN', 'BEGINN_EINRICHTUNG', 'STILLE_EROEFFNUNG', 'IST_AUFNAHME_TECHNIK', 'EROEFFNUNG_TIP_TOP', 'CPR_EOEWE_E', 'CPR_EOEWE_A', 'CPR_REALISIERUNG') -- VIS Ausschnitt

   UNION -- Projekt 2. Aufgaben
   SELECT
   CAST(au.cpr_aufgabe_id AS CHAR(32)) AS checkliste_punkt_id,
   CAST(NULL AS CHAR(32)) AS cpr_checkliste_id,
   au.projekt_phase_id,
   au.sortier_nummer,
   CASE WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 1 ELSE 0 END AS ok_fg,
   CASE WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 0 ELSE 1 END AS nicht_ok_fg,
   CASE WHEN au.cpr_systemstatus1_id = 4        THEN 1 ELSE 0 END AS nicht_relevant_fg,
   0  AS obligatorisch_fg,
   CASE
  WHEN su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN' THEN 'KBE_BAUANTRAG'
  WHEN su.cpr_suchfeld = 'CPR_REALISIERUNG' THEN 'BAUBEGINN'
  ELSE su.cpr_suchfeld
  END  AS cpr_suchfeld,
   CAST(NULL AS CHAR(40)) AS cpr_prozess,
   CAST(NULL AS CHAR(20)) AS terminart,
   au.dat_start_ist,
   CASE WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN') THEN au.dat_start_ist ELSE au.dat_ende_ist END                        AS dat_ende_ist --angeglichen an IOS-Logik
   ,
   au.dat_start_max,
   CASE WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG') THEN au.dat_start_max ELSE au.dat_ende_max END                        AS dat_ende_max,
   au.dat_start_plan,
   CASE WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG') THEN au.dat_start_plan ELSE au.dat_ende_plan END                      AS dat_ende_plan,
   au.dat_start_einschraenkung,
   CASE WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG') THEN au.dat_start_einschraenkung ELSE au.dat_ende_einschraenkung END  AS dat_ende_einschraenkung,
   au.gesamt_puffer,
   au.dauer,
   au.cpr_prio,
   CAST(NULL AS DATE) AS dat_erstellung,
   au.cpr_systemstatus1_id,
   au.cpr_systemstatus3_id,
   au.cpr_systemstatus2_id,
   su.cpr_suchfeld_id,
   CAST(1 AS SMALLINT) AS sortier_nr_mhrwrtgkt,
   CASE WHEN au.dat_ende_vorhersage IS NOT NULL AND au.dat_ende_vorhersage <> to_date('1900-01-01') THEN au.dat_ende_vorhersage ELSE CAST(NULL AS DATE) END           AS dat_ende_vorhersage --angeglichen an IOS-Logik
   ,
   CASE WHEN au.dat_start_vorhersage IS NOT NULL AND au.dat_start_vorhersage <> to_date('1900-01-01') THEN au.dat_start_vorhersage ELSE CAST(NULL AS DATE) END        AS dat_start_vorhersage --angeglichen an IOS-Logik
  FROM dbp_view.v_cpr_aufgabe_per_2  au
   INNER JOIN dbp_view.v_l_cpr_suchfeld_2  su
   ON au.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE au.dat_bis = to_date('9999-12-31')
   AND su.cpr_suchfeld IN ('CPR_PRV_APLNAT', 'CPR_PRV_INTAPL', 'BAUBEGINN', 'BEGINN_EINRICHTUNG', 'STILLE_EROEFFNUNG', 'IST_AUFNAHME_TECHNIK', 'EROEFFNUNG_TIP_TOP', 'CPR_EOEWE_E', 'CPR_EOEWE_A', 'CPR_REALISIERUNG') -- VIS Ausschnitt
   -- UNION -- Projekt 3. Aufgaben entfaellt, da irrelevant in VIS
   ) cl_au

   JOIN
   ( -- Phase und Bauabschnitt
   SELECT
   pr.mandant_id,
   pr.techn_platz_id,
   pr.cpr_ext_id AS projekt_nr,
   ph.dat_freigabe,
   pr.gj,
   pr_s.cpr_projekt_bez,
   pr_s.cpr_projekt_langtext,
   ph.teil_massn_kz,
   CASE
  WHEN ph.teil_massn_kz > 1 THEN ph_s.cpr_phase_bez
  ELSE pr_s.cpr_projekt_bez
  END                                                                                                        AS bauabschnitt_bez,
   CASE
  WHEN ph.teil_massn_kz > 1 THEN COALESCE(ph_s.cpr_phase_langtext, '')
  WHEN ph.teil_massn_kz = 1 THEN COALESCE(ph_s.cpr_phase_langtext, pr_s.cpr_projekt_langtext, '')
  ELSE COALESCE(pr_s.cpr_projekt_langtext, '')
  END                                                                                                        AS bauabschnitt_langtext,
   pr.massnahme_id,
   CASE WHEN ph.teil_massn_kz >= 1 THEN pr.projekt_id || ph.projekt_phase_id ELSE pr.projekt_id || '0000' END  AS bauabschnitt_id,
   ph.projekt_phase_id,
   ph.projekt_id,
   ph.phasenart_id,
   pr.cpr_systemstatus1_id AS cpr_projekt_status1,
   pr.cpr_systemstatus2_id AS cpr_projekt_status2,
   pr.cpr_systemstatus3_id AS cpr_projekt_status3,
   ph.cpr_systemstatus1_id AS cpr_phase_status1,
   ph.cpr_systemstatus2_id AS cpr_phase_status2,
   ph.cpr_systemstatus3_id AS cpr_phase_status3
  FROM dbp_view.v_cpr_phase_per_2    ph

   JOIN dbp_view.v_cpr_projekt_per_2   pr
   ON   ph.projekt_id = pr.projekt_id
   AND pr.dat_bis = '9999-12-31'
   AND pr.cpr_systemstatus1_id IN (2, 3, 6)                                   -- PROJEKT Status1 : 2 Freigegeben, 3 Abgeschlossen, 4 Erledigt
   AND pr.cpr_systemstatus2_id NOT IN (1)                                     -- PROJEKT Status2 : OHNE 1 Gesperrt

   JOIN dbp_view.v_cpr_projekt_spr_zu_per_2 pr_s
   ON   pr.projekt_id = pr_s.projekt_id
   AND  pr_s.dat_bis = '9999-12-31' AND  pr_s.spr_id=22

   JOIN dbp_view.v_cpr_phase_spr_zu_per_2  ph_s
   ON   ph.projekt_phase_id=ph_s.projekt_phase_id
   AND  ph_s.dat_bis = '9999-12-31' AND  ph_s.spr_id=22

   JOIN dbp_view.v_l_cpr_suchfeld_2 su
   ON ph.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE ph.dat_bis = '9999-12-31'
   AND ph.cpr_systemstatus1_id IN (2, 3, 6)                                   -- PHASE Status1 : 2 Freigegeben, 3 Abgeschlossen, 4 Erledigt
   AND ph.cpr_systemstatus2_id NOT IN (1)                                     -- PHASE Status2 : OHNE 1 Gesperrt
   AND pr.massnahme_id IN ('RE_2', 'RN', 'ST', 'ZPPM_RE', 'ZPPM_RN', 'ZPPM_ST', 'ZPPM_MM') -- PROJEKT MASSNAHME: Reorga, SOA + Marktmodernisierung
   ) ph
   ON ph.projekt_phase_id = cl_au.projekt_phase_id
   ) cp0
--   
-- GROUP BY cp0.techn_platz_id, cp0.projekt_nr, SUBSTRING(cp0.projekt_nr, 14, 2)
--   , cp0.cpr_projekt_bez, cp0.cpr_projekt_langtext, cp0.massnahme_id, cp0.teil_massn_kz, cp0.bauabschnitt_id, cp0.bauabschnitt_bez, cp0.bauabschnitt_langtext, cp0.gj
   WHERE (cp0.ok_fg = 1) -- Termin in Ordnung
   OR    (cp0.ok_fg = 0 AND cp0.nicht_ok_fg = 0 AND cp0.nicht_relevant_fg = 0 AND cp0.dat_termin >= CURRENT_DATE )  -- Termin offen in Zukunft
   GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
   ) cpro
   ON tpl.techn_platz_id = cpro.techn_platz_id;