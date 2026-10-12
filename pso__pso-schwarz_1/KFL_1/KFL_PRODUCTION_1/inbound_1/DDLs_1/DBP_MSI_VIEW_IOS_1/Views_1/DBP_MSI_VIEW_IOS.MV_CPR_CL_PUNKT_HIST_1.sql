CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_CL_PUNKT_HIST_1
(
checkliste_punkt_id
,cpr_checkliste_id
,projekt_phase_id
,dat_ist_termin
,dat_start_soll
,dat_soll_termin
,dat_start_termin
,dat_start_vorhersage
,dat_ende_vorhersage
,dat_termin
,termin_fg
,text_termin
,text2_termin
,dauer_termin
,sortier_nummer
,ok_fg
,nicht_ok_fg
,nicht_relevant_fg
,obligatorisch_fg
,cpr_suchfeld_id
,cpr_prozess
,terminart
,dat_start_ist
,dat_ende_ist
,dat_start_max
,dat_ende_max
,dat_start_plan
,dat_ende_plan
,dat_start_einschraenkung
,dat_ende_einschraenkung
,gesamt_puffer
,dauer
,cpr_prio
,cpr_systemstatus1_id
,cpr_systemstatus3_id
,cpr_systemstatus2_id
,mandant_id
,dat_realisierung
,dat_start_realisierung
,dat_soll_monat
)
AS
   -- 2008-10-23
   -- FAKTVIEW cpr_cl_punkt_hist
   -- Historisierte Daten
   -- Aufbau analog mv_cpr_cl_punkt_1 + dat_extrakt
   -- 20081218:
   -- cpr_prozess NULL gesetzt
   -- terminart NULL gesetzt
   -- dat_extrakt NULL gesetzt
   -- join zur cpr_suchfeld_spr_zu_1, um suchfeld_bez zu bekommen
   -- 20090114: cpr_suchfeld wird wieder geliefert statt suchfeld_bez
   -- 20090205:
   -- Daten werden aus cpr_aufgabe_per_1 geliefert, falls vorhanden.
   -- Ausgabe von Mandant_id, dazu join der Hierachie bis cpr_projekt_per.
   -- 20090212:
   -- cpr_aufgabe_id aus cpr_aufgabe_per_1 wird als checkliste_punkt_id.
   -- Änderung der cpr_suchfeld Ausgabe aus cpr_aufgabe_per.
   -- Geänderte Ausgabe wenn cpr_suchfeld aus cpr_aufgabe_per_1 CPR_REALISIERUNG oder
   -- CPR_BAURECHTSVERFAHREN ist.
   -- 20090219:
   -- Anpassung der Views, weil Spalten im Datenmodell umbenannt wurden
   -- Zur Performancesteigerung werden redundante Joins zu einem zusammengefasst
   -- 20090224:
   -- Folgende Spalten wurden wegen Nicht-Gebrauchs entfernt:
   -- cpr_apprel
   -- aenderbar_fg
   -- cl_punkt_gruppe_id
   -- term_einschr_typ
   -- termin_einschraenk_kz
   -- duunit
   -- Folgende Spalten wurden umbenannt:
   -- dat_start_einschraenkung ersetzt dat_einschraenkung
   -- dat_ende_einschraenkung ersetzt dat_einschraenkung_2
   -- 20090323 tbanh: dat_start_einschraenkung mit dat_ende_einschraenkung fuer dat_soll_termin ersetzt
   -- 20090323 lipkin. DD.MM.YYYY Anzeige bei text_termin innerhalb 98 Tage bis Termin
   --  anstatt bisheriger 84.
   -- 20090323 lipkin: Spalte dauer_termin hinzugefügt
   -- -20090526   Anpassung CASE Statement bei Aufgaben :
   ---                       Ersetzt  IN durch LIKE ANY
   -- 20090713 awenzel: LIKEs durch ist gleich oder IN ersetzt
   -- 20100727 aalberg:  WHEN dat_soll_termin >= DATE, THEN dat_termin
   --                    WHEN dat_soll_termin < DATE, THEN NULL
   -- 20100830  bandeira:  dat_soll_termin >= DATE, THEN dat_termin (Korrektur)
   -- 20110323  bandeira:  WHEN dat_ist_termin >= DATE, THEN dat_start_termin
   --                    WHEN dat_ist_termin < DATE, THEN NULL
   -- 20111027  kkaiser:  wenn cpr_systemstatus1_id = 4 in der Aufgabe, wird das nicht_relevant_fg auf 1 gesetzt
   -- 20120208 kkaiser neues Feld eingebaut, text2_termin, Anfo 561094
   -- 20130311kkaiser neue Felder eingebaut,  dat_vorhersage_ende, dat_vorhersage_start,        Anfo 580167
   -- 20130326  kkaiser:  Anfo: 579821: 2 neue Datums-Felder 0-12 Wochen vor Stille EÖ taggenau, 13-24 Wochen vor Stille EÖ monatsgenau, größer 24 Wochen quartalsgenau, dat_realisierung, dat_start_realisierung
   --                                1 neues Datums-Feld: wenn IST-Termin nicht vorhanden, dann SOLL-Termin als Monatswert, dat_soll_monat
   -- 20130703 kkaiser, Anfo # 585615, CPR_REALISIERUNG soll nicht mehr automatisch auf BAUBEGINN umgesetzt werden
   -- 20150701 kkaiser, # 618615 IST-> PROGNOSE  ->SOLL Logik in dat_termin

   SELECT
   cl_au.checkliste_punkt_id AS checkliste_punkt_id, cl_au.cpr_checkliste_id  AS cpr_checkliste_id, cl_au.projekt_phase_id AS projekt_phase_id, CASE
   WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> '1900-01-01'
   THEN cl_au.dat_ende_ist
   ELSE CAST(NULL AS DATE)
   END             AS dat_ist_termin, CASE
   WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> '1900-01-01'
   THEN cl_au.dat_start_einschraenkung
   ELSE CAST(NULL AS DATE)
   END       AS dat_start_soll, CASE
   WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> '1900-01-01'
   THEN cl_au.dat_ende_einschraenkung
   ELSE CAST(NULL AS DATE)
   END             AS dat_soll_termin, COALESCE(
   CASE WHEN dat_start_ist = '1900-01-01' THEN NULL ELSE dat_start_ist
   END,
   CASE
   WHEN dat_start_soll >= CURRENT_DATE THEN dat_start_soll
   ELSE NULL
   END)::DATE AS dat_start_termin, cl_au.dat_start_vorhersage  AS dat_start_vorhersage, cl_au.dat_ende_vorhersage   AS  dat_ende_vorhersage, COALESCE(
   CASE WHEN dat_ist_termin <> '1900-01-01' AND  dat_ist_termin IS NOT NULL THEN   dat_ist_termin  END,
   CASE WHEN   dat_ende_vorhersage IS NOT NULL    AND dat_ende_vorhersage <> '1900-01-01' AND dat_ende_vorhersage >= CURRENT_DATE THEN dat_ende_vorhersage END,
   CASE WHEN   dat_soll_termin >= CURRENT_DATE  THEN dat_soll_termin END)::DATE AS dat_termin, CASE
   WHEN dat_termin <= CURRENT_DATE THEN 1
   WHEN dat_termin > CURRENT_DATE THEN 0
   ELSE -1
   END::BYTEINT        AS termin_fg, CASE
   WHEN dat_termin <= CURRENT_DATE + 98       THEN TO_VARCHAR(dat_termin, 'DD.MM.YYYY')
   WHEN dat_termin <= ADD_MONTHS(CURRENT_DATE, 6)  THEN TO_VARCHAR(dat_termin, 'MMMBYYYY')
   WHEN dat_termin <= ADD_MONTHS(CURRENT_DATE, 18) THEN CAST(
   CASE
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN  1 AND  3 THEN 'I'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN  4 AND  6 THEN 'II'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN  7 AND  9 THEN 'III'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 10 AND 12 THEN 'IV'
   ELSE ''
   END || '/' ||  (dat_termin ) AS VARCHAR (20))
   WHEN dat_termin > ADD_MONTHS(CURRENT_DATE, 18)  THEN TO_VARCHAR(dat_termin, 'YYYY')
   ELSE NULL
   END             AS text_termin, CASE
   WHEN  dat_ist_termin  is not null  AND dat_ist_termin <> '1900-01-01' THEN TO_VARCHAR(dat_ist_termin, 'DD.MM.YYYY')
   WHEN  dat_ende_vorhersage  is not null  AND dat_ende_vorhersage  > CURRENT_DATE THEN TO_VARCHAR(CURRENT_DATE, 'MMMBYYYY')
   WHEN  dat_soll_termin  is not null  AND   dat_soll_termin  > CURRENT_DATE THEN TO_VARCHAR(dat_soll_termin, 'MMMBYYYY')
   ELSE  NULL END  AS text2_termin, CASE
   WHEN dat_ende_ist <> '1900-01-01' AND dat_start_ist <> '1900-01-01' AND dat_ende_ist >= dat_start_ist
   THEN dat_ende_ist - dat_start_ist

   WHEN  dat_ende_einschraenkung <> '1900-01-01' AND dat_start_einschraenkung <> '1900-01-01'  AND dat_ende_einschraenkung >= dat_start_einschraenkung
   THEN dat_ende_einschraenkung - dat_start_einschraenkung

   ELSE 0
   END AS dauer_termin, cl_au.sortier_nummer AS sortier_nummer, cl_au.ok_fg    AS ok_fg, cl_au.nicht_ok_fg  AS nicht_ok_fg, cl_au.nicht_relevant_fg AS nicht_relevant_fg, cl_au.obligatorisch_fg  AS obligatorisch_fg, cl_au.cpr_suchfeld  AS cpr_suchfeld_id, cl_au.cpr_prozess  AS cpr_prozess, cl_au.terminart   AS terminart, cl_au.dat_start_ist  AS dat_start_ist, cl_au.dat_ende_ist  AS dat_ende_ist, cl_au.dat_start_max  AS dat_start_max, cl_au.dat_ende_max  AS dat_ende_max, cl_au.dat_start_plan AS dat_start_plan, cl_au.dat_ende_plan  AS dat_ende_plan, cl_au.dat_start_einschraenkung AS dat_start_einschraenkung, cl_au.dat_ende_einschraenkung AS dat_ende_einschraenkung, cl_au.gesamt_puffer  AS gesamt_puffer, cl_au.dauer    AS dauer, cl_au.cpr_prio    AS cpr_prio, cl_au.cpr_systemstatus1_id  AS cpr_systemstatus1_id, cl_au.cpr_systemstatus3_id  AS cpr_systemstatus3_id, cl_au.cpr_systemstatus2_id  AS cpr_systemstatus2_id, pr.mandant_id, CASE
   WHEN dat_termin <= CURRENT_DATE + 84 THEN TO_VARCHAR(dat_termin, 'DD.MM.YY')
   WHEN dat_termin <= CURRENT_DATE + 168  THEN TO_VARCHAR(dat_termin, 'MMMBYY')
   WHEN dat_termin<= ADD_MONTHS(CURRENT_DATE, 18) THEN CAST(
   CASE
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 1 AND 3 THEN 'I'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 4 AND 6 THEN 'II'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 7 AND 9 THEN 'III'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 10 AND 12 THEN 'IV'
   ELSE ''
   END || '/' || (dat_termin ) AS VARCHAR (20))
   ELSE NULL
   END       AS dat_realisierung, CASE
   WHEN dat_start_termin <= CURRENT_DATE + 84 THEN TO_VARCHAR(dat_start_termin, 'DD.MM.YY')
   WHEN dat_start_termin <= CURRENT_DATE + 168  THEN TO_VARCHAR(dat_start_termin, 'MMMBYY')
   WHEN dat_start_termin<= ADD_MONTHS(CURRENT_DATE, 18) THEN CAST(
   CASE
   WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 1 AND 3 THEN 'I'
   WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 4 AND 6 THEN 'II'
   WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 7 AND 9 THEN 'III'
   WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 10 AND 12 THEN 'IV'
   ELSE ''
   END || '/' || (dat_start_termin ) AS VARCHAR (20))
   ELSE NULL
   END       AS dat_start_realisierung, CASE
   WHEN dat_ist_termin is NULL AND dat_soll_termin IS NOT NULL THEN TO_VARCHAR(dat_soll_termin, 'MMMBYY')
   WHEN dat_ist_termin is NOT NULL  THEN TO_VARCHAR(dat_ist_termin, 'DD.MM.YY')
   ELSE NULL
   END       AS dat_soll_monat

   FROM
   ( -- cl_au
   SELECT
   cp.checkliste_punkt_id, cp.cpr_checkliste_id, cl.projekt_phase_id, MOD(cp.sortier_nummer, 100) AS sortier_nummer, cp.ok_fg, cp.nicht_ok_fg, cp.nicht_relevant_fg, cp.obligatorisch_fg, su.cpr_suchfeld, CAST(NULL AS CHAR(40)) AS cpr_prozess, CAST(NULL AS CHAR(20)) AS terminart, cp.dat_start_ist, cp.dat_ende_ist, cp.dat_start_max, cp.dat_ende_max, cp.dat_start_plan, cp.dat_ende_plan, cp.dat_start_einschraenkung, cp.dat_ende_einschraenkung, cp.gesamt_puffer, CAST(NULL AS DECIMAL(18,3)) AS dauer, cp.cpr_prio, cp.cpr_systemstatus1_id, cp.cpr_systemstatus3_id, cp.cpr_systemstatus2_id, cp.cpr_suchfeld_id, cp.dat_start_vorhersage  AS dat_start_vorhersage, cp.dat_ende_vorhersage   AS  dat_ende_vorhersage, '' AS dat_realisierung, '' AS dat_start_realisierung, '' AS dat_soll_monat

   FROM dbp_view.v_cpr_cl_punkt_per_1  cp
   INNER JOIN dbp_view.v_cpr_checkliste_per_1 cl
   ON cp.cpr_checkliste_id = cl.cpr_checkliste_id
   AND "CURRENT_DATE" - 14 BETWEEN cl.dat_von AND cl.dat_bis
   INNER JOIN dbp_view.v_l_cpr_suchfeld_1  su
   ON cp.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE "CURRENT_DATE" - 14 BETWEEN cp.dat_von AND cp.dat_bis
   --
   UNION /*** ***/
   --
   SELECT
   CAST(au.cpr_aufgabe_id AS CHAR(32)) AS checkliste_punkt_id, CAST(NULL AS CHAR(32)) AS cpr_checkliste_id, au.projekt_phase_id, au.sortier_nummer, CASE
   WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 1
   ELSE 0
   END  AS ok_fg, CASE
   WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 0
   ELSE 1
   END  AS nicht_ok_fg, CASE
   WHEN au.cpr_systemstatus1_id = 4
   THEN 1
   ELSE 0
   END     AS nicht_relevant_fg, 0   AS obligatorisch_fg, CASE
   WHEN su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN' THEN 'KBE_BAUANTRAG'
   --WHEN su.cpr_suchfeld = 'CPR_REALISIERUNG' THEN 'BAUBEGINN'
   ELSE su.cpr_suchfeld
   END        AS cpr_suchfeld, CAST(NULL AS CHAR(40))  AS cpr_prozess, CAST(NULL AS CHAR(20))  AS terminart, au.dat_start_ist, CASE
   WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
   THEN au.dat_start_ist
   ELSE au.dat_ende_ist
   END        AS dat_ende_ist, au.dat_start_max, CASE
   WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
   THEN au.dat_start_max
   ELSE au.dat_ende_max
   END     AS dat_ende_max, au.dat_start_plan, CASE
   WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
   THEN au.dat_start_plan
   ELSE au.dat_ende_plan
   END     AS dat_ende_plan, au.dat_start_einschraenkung, CASE
   WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
   THEN au.dat_start_einschraenkung
   ELSE au.dat_ende_einschraenkung
   END     AS dat_ende_einschraenkung, au.gesamt_puffer, au.dauer, au.cpr_prio, au.cpr_systemstatus1_id, au.cpr_systemstatus3_id, au.cpr_systemstatus2_id, su.cpr_suchfeld_id, au.dat_start_vorhersage  AS dat_start_vorhersage, au.dat_ende_vorhersage   AS  dat_ende_vorhersage, '' AS dat_realisierung, '' AS dat_start_realisierung, '' AS dat_soll_monat

   FROM dbp_view.v_cpr_aufgabe_per_1  au
   INNER JOIN dbp_view.v_l_cpr_suchfeld_1  su
   ON au.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE "CURRENT_DATE" - 14 BETWEEN au.dat_von AND au.dat_bis
   --
   UNION /*** ***/
   --
   SELECT
   CAST(au.cpr_aufgabe_id AS CHAR(32)) AS checkliste_punkt_id, CAST(NULL AS CHAR(32)) AS cpr_checkliste_id, au.projekt_phase_id, au.sortier_nummer, CASE
   WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 1
   ELSE 0
   END   AS ok_fg, CASE
   WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 0
   ELSE 1
   END   AS nicht_ok_fg, CASE
   WHEN au.cpr_systemstatus1_id = 4
   THEN 1
   ELSE 0
   END     AS nicht_relevant_fg, 0    AS obligatorisch_fg, 'KBE_BAUGENEHMIGUNG' AS cpr_suchfeld, CAST(NULL AS CHAR(40)) AS cpr_prozess, CAST(NULL AS CHAR(20)) AS terminart, au.dat_start_ist, au.dat_ende_ist, au.dat_start_max, au.dat_ende_max, au.dat_start_plan, au.dat_ende_plan, au.dat_start_einschraenkung, au.dat_ende_einschraenkung, au.gesamt_puffer, au.dauer, au.cpr_prio, au.cpr_systemstatus1_id, au.cpr_systemstatus3_id, au.cpr_systemstatus2_id, su.cpr_suchfeld_id, au.dat_start_vorhersage  AS dat_start_vorhersage, au.dat_ende_vorhersage   AS  dat_ende_vorhersage, '' AS dat_realisierung, '' AS dat_start_realisierung, '' AS dat_soll_monat

   FROM dbp_view.v_cpr_aufgabe_per_1 au
   INNER JOIN dbp_view.v_l_cpr_suchfeld_1  su
   ON au.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE "CURRENT_DATE" - 14 BETWEEN au.dat_von AND au.dat_bis
   AND su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN'
   ) cl_au
   INNER JOIN dbp_view.v_cpr_phase_per_1  ph
   ON cl_au.projekt_phase_id = ph.projekt_phase_id
   AND "CURRENT_DATE" - 14 BETWEEN ph.dat_von AND ph.dat_bis
   INNER JOIN dbp_view.v_cpr_projekt_per_1 pr
   ON ph.projekt_id = pr.projekt_id
   AND "CURRENT_DATE" - 14 BETWEEN pr.dat_von AND pr.dat_bis;