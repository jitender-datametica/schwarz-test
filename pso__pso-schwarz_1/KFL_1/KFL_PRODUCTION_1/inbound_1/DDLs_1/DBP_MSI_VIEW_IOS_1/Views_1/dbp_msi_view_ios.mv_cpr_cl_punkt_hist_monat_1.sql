CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_cpr_cl_punkt_hist_monat_1
AS
-- 20130326  kkaiser:  Anfo: 579821: diese Historie greift auf den ersten des Monats
-- 20130703 kkaiser, Anfo # 585615, CPR_REALISIERUNG soll nicht mehr automatisch auf BAUBEGINN umgesetzt werden
SELECT
cl_au.checkliste_punkt_id AS checkliste_punkt_id,
cl_au.cpr_checkliste_id  AS cpr_checkliste_id,
cl_au.projekt_phase_id AS projekt_phase_id,
CASE
WHEN cl_au.dat_ende_ist IS NOT NULL AND date_part(year,cl_au.dat_ende_ist) <> '2001'
THEN cl_au.dat_ende_ist
ELSE CAST(NULL AS DATE)
END             AS dat_ist_termin,
CASE
WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND date_part(year,cl_au.dat_start_einschraenkung) <> '2001'
THEN cl_au.dat_start_einschraenkung
ELSE CAST(NULL AS DATE)
END       AS dat_start_soll,
CASE
WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND date_part(year,cl_au.dat_ende_einschraenkung) <> '2001'
THEN cl_au.dat_ende_einschraenkung
ELSE CAST(NULL AS DATE)
END             AS dat_soll_termin,
COALESCE(
CASE WHEN date_part(year,dat_start_ist) = '2001' THEN NULL ELSE dat_start_ist
END,
CASE
WHEN dat_start_soll >= CURRENT_DATE THEN dat_start_soll
ELSE NULL
END)::DATE AS dat_start_termin,
COALESCE(
CASE WHEN date_part(year,dat_ist_termin) = '2001' THEN NULL ELSE dat_ist_termin
END,
CASE
WHEN dat_soll_termin >= CURRENT_DATE THEN dat_soll_termin
ELSE NULL
END)::DATE AS dat_termin,
CASE
WHEN dat_termin <= CURRENT_DATE THEN 1
WHEN dat_termin > CURRENT_DATE THEN 0
ELSE -1
END::BYTEINT        AS termin_fg,
CASE
WHEN dat_termin <= CURRENT_DATE + 98       THEN CAST((dat_termin /*Warning, Format 'DD.MM.YYYY' removed.*/) AS VARCHAR (10))
WHEN dat_termin <= ADD_MONTHS(CURRENT_DATE, 6)  THEN CAST((dat_termin /*Warning, Format 'MMMBYYYY' removed.*/)  AS VARCHAR (10))
WHEN dat_termin <= ADD_MONTHS(CURRENT_DATE, 18) THEN
CASE
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN  1 AND  3 THEN 'I'
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN  4 AND  6 THEN 'II'
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN  7 AND  9 THEN 'III'
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 10 AND 12 THEN 'IV'
ELSE ''
END || '/' ||  (dat_termin /*Warning, Format 'YYYY' removed.*/)
WHEN dat_termin > ADD_MONTHS(CURRENT_DATE, 18)  THEN CAST((dat_termin /*Warning, Format 'YYYY' removed.*/)    AS VARCHAR (10))
ELSE NULL
END             AS text_termin,
CASE
WHEN  dat_soll_termin  is not null  AND dat_ist_termin is NULL
THEN  CAST ((dat_soll_termin /*Warning, Format 'MMMBYYYY' removed.*/) AS VARCHAR (10))
ELSE  CAST((dat_ist_termin /*Warning, Format 'DD.MM.YYYY' removed.*/) AS VARCHAR (10)) END  AS text2_termin,
CASE
WHEN date_part(year,dat_ende_ist) <> '2001' AND date_part(year,dat_start_ist) <> '2001' AND dat_ende_ist >= dat_start_ist
THEN dat_ende_ist - dat_start_ist
WHEN  date_part(year,dat_ende_einschraenkung) <> 2001 AND date_part(year,dat_start_einschraenkung) <> '2001'  AND dat_ende_einschraenkung >= dat_start_einschraenkung
THEN dat_ende_einschraenkung - dat_start_einschraenkung

ELSE 0
END AS dauer_termin,
cl_au.sortier_nummer AS sortier_nummer,
cl_au.ok_fg    AS ok_fg,
cl_au.nicht_ok_fg  AS nicht_ok_fg,
cl_au.nicht_relevant_fg AS nicht_relevant_fg,
cl_au.obligatorisch_fg  AS obligatorisch_fg,
cl_au.cpr_suchfeld  AS cpr_suchfeld_id,
cl_au.cpr_prozess  AS cpr_prozess,
cl_au.terminart   AS terminart,
cl_au.dat_start_ist  AS dat_start_ist,
cl_au.dat_ende_ist  AS dat_ende_ist,
cl_au.dat_start_max  AS dat_start_max,
cl_au.dat_ende_max  AS dat_ende_max,
cl_au.dat_start_plan AS dat_start_plan,
cl_au.dat_ende_plan  AS dat_ende_plan,
cl_au.dat_start_einschraenkung AS dat_start_einschraenkung,
cl_au.dat_ende_einschraenkung AS dat_ende_einschraenkung,
cl_au.gesamt_puffer  AS gesamt_puffer,
cl_au.dauer    AS dauer,
cl_au.cpr_prio    AS cpr_prio,
cl_au.cpr_systemstatus1_id  AS cpr_systemstatus1_id,
cl_au.cpr_systemstatus3_id  AS cpr_systemstatus3_id,
cl_au.cpr_systemstatus2_id  AS cpr_systemstatus2_id,
pr.mandant_id,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/  AS dat_vorhersage_start,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/   AS  dat_vorhersage_ende,
CASE
WHEN dat_termin <= CURRENT_DATE + 84 THEN CAST((dat_termin /*Warning, Format 'DD.MM.YY' removed.*/) AS VARCHAR (10))
WHEN dat_termin <= CURRENT_DATE + 168  THEN CAST((dat_termin /*Warning, Format 'MMMBYY' removed.*/) AS VARCHAR (10))
WHEN dat_termin<= ADD_MONTHS(CURRENT_DATE, 18) THEN
CASE
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 1 AND 3 THEN 'I'
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 4 AND 6 THEN 'II'
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 7 AND 9 THEN 'III'
WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 10 AND 12 THEN 'IV'
ELSE ''
END || '/' || (dat_termin /*Warning, Format 'YY' removed.*/)
ELSE NULL
END       AS dat_realisierung,
CASE
WHEN dat_start_termin <= CURRENT_DATE + 84 THEN CAST((dat_start_termin /*Warning, Format 'DD.MM.YY' removed.*/) AS VARCHAR (10))
WHEN dat_start_termin <= CURRENT_DATE + 168  THEN CAST((dat_start_termin /*Warning, Format 'MMMBYY' removed.*/) AS VARCHAR (10))
WHEN dat_start_termin<= ADD_MONTHS(CURRENT_DATE, 18) THEN
CASE
WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 1 AND 3 THEN 'I'
WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 4 AND 6 THEN 'II'
WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 7 AND 9 THEN 'III'
WHEN EXTRACT(MONTH FROM dat_start_termin) BETWEEN 10 AND 12 THEN 'IV'
ELSE ''
END || '/' || (dat_start_termin /*Warning, Format 'YY' removed.*/)
ELSE NULL
END       AS dat_start_realisierung,
CASE
WHEN dat_ist_termin is NULL AND dat_soll_termin IS NOT NULL THEN CAST((dat_soll_termin /*Warning, Format 'MMMBYY' removed.*/) AS VARCHAR (10))
WHEN dat_ist_termin is NOT NULL  THEN CAST((dat_ist_termin /*Warning, Format 'DD.MM.YY' removed.*/) AS VARCHAR (10))
ELSE NULL
END       AS dat_soll_monat,
cl_au.ref_monat AS ref_monat
FROM
( -- cl_au
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
cp.cpr_systemstatus1_id,
cp.cpr_systemstatus3_id,
cp.cpr_systemstatus2_id,
cp.cpr_suchfeld_id,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/  AS dat_vorhersage_start,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/   AS  dat_vorhersage_ende,
'' AS dat_realisierung,
'' AS dat_start_realisierung,
'' AS dat_soll_monat,
t.ref_monat AS ref_monat
FROM dbp_view.v_cpr_cl_punkt_per_1  cp

LEFT JOIN dbp_msi_view_ios.mv_ref_monat_1 t
ON t.ref_monat <= CURRENT_DATE

INNER JOIN dbp_view.v_cpr_checkliste_per_1 cl
ON cp.cpr_checkliste_id = cl.cpr_checkliste_id
AND t.ref_monat BETWEEN cl.dat_von AND cl.dat_bis

INNER JOIN dbp_view.v_l_cpr_suchfeld_1  su
ON cp.cpr_suchfeld_id = su.cpr_suchfeld_id

WHERE
t.ref_monat BETWEEN cp.dat_von AND cp.dat_bis
--
UNION /*** ***/
--
SELECT
CAST(au.cpr_aufgabe_id AS CHAR(32)) AS checkliste_punkt_id,
CAST(NULL AS CHAR(32)) AS cpr_checkliste_id,
au.projekt_phase_id,
au.sortier_nummer,
CASE
WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 1
ELSE 0
END  AS ok_fg,
CASE
WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 0
ELSE 1
END  AS nicht_ok_fg,
CASE
WHEN au.cpr_systemstatus1_id = 4
THEN 1
ELSE 0
END     AS nicht_relevant_fg,
0   AS obligatorisch_fg,
CASE
WHEN su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN' THEN 'KBE_BAUANTRAG'
-- WHEN su.cpr_suchfeld = 'CPR_REALISIERUNG' THEN 'BAUBEGINN'
ELSE su.cpr_suchfeld
END        AS cpr_suchfeld,
CAST(NULL AS CHAR(40))  AS cpr_prozess,
CAST(NULL AS CHAR(20))  AS terminart,
au.dat_start_ist,
CASE
WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
THEN au.dat_start_ist
ELSE au.dat_ende_ist
END        AS dat_ende_ist,
au.dat_start_max,
CASE
WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
THEN au.dat_start_max
ELSE au.dat_ende_max
END     AS dat_ende_max,
au.dat_start_plan,
CASE
WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
THEN au.dat_start_plan
ELSE au.dat_ende_plan
END     AS dat_ende_plan,
au.dat_start_einschraenkung,
CASE
WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN','CPR_REALISIERUNG')
THEN au.dat_start_einschraenkung
ELSE au.dat_ende_einschraenkung
END     AS dat_ende_einschraenkung,
au.gesamt_puffer,
au.dauer,
au.cpr_prio,
au.cpr_systemstatus1_id,
au.cpr_systemstatus3_id,
au.cpr_systemstatus2_id,
su.cpr_suchfeld_id,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/  AS dat_vorhersage_start,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/   AS  dat_vorhersage_ende,
'' AS dat_realisierung,
'' AS dat_start_realisierung,
'' AS dat_soll_monat,
t.ref_monat AS ref_monat
FROM dbp_view.v_cpr_aufgabe_per_1  au

LEFT JOIN dbp_msi_view_ios.mv_ref_monat_1 t
ON t.ref_monat <= CURRENT_DATE

INNER JOIN dbp_view.v_l_cpr_suchfeld_1  su
ON au.cpr_suchfeld_id = su.cpr_suchfeld_id

WHERE
t.ref_monat BETWEEN au.dat_von AND au.dat_bis
--
UNION /*** ***/
--
SELECT
CAST(au.cpr_aufgabe_id AS CHAR(32)) AS checkliste_punkt_id,
CAST(NULL AS CHAR(32)) AS cpr_checkliste_id,
au.projekt_phase_id,
au.sortier_nummer,
CASE
WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 1
ELSE 0
END   AS ok_fg,
CASE
WHEN au.cpr_systemstatus1_id IN (2,3,6) THEN 0
ELSE 1
END   AS nicht_ok_fg,
CASE
WHEN au.cpr_systemstatus1_id = 4
THEN 1
ELSE 0
END     AS nicht_relevant_fg,
0    AS obligatorisch_fg,
'KBE_BAUGENEHMIGUNG' AS cpr_suchfeld,
CAST(NULL AS CHAR(40)) AS cpr_prozess,
CAST(NULL AS CHAR(20)) AS terminart,
au.dat_start_ist,
au.dat_ende_ist,
au.dat_start_max,
au.dat_ende_max,
au.dat_start_plan,
au.dat_ende_plan,
au.dat_start_einschraenkung,
au.dat_ende_einschraenkung,
au.gesamt_puffer,
au.dauer,
au.cpr_prio,
au.cpr_systemstatus1_id,
au.cpr_systemstatus3_id,
au.cpr_systemstatus2_id,
su.cpr_suchfeld_id,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/  AS dat_vorhersage_start,
CURRENT_DATE /*Warning, Format 'DD.MM.YY' removed.*/   AS  dat_vorhersage_ende,
'' AS dat_realisierung,
'' AS dat_start_realisierung,
'' AS dat_soll_monat,
t.ref_monat AS ref_monat
FROM dbp_view.v_cpr_aufgabe_per_1 au

INNER JOIN dbp_view.v_l_cpr_suchfeld_1  su
ON au.cpr_suchfeld_id = su.cpr_suchfeld_id


LEFT JOIN dbp_msi_view_ios.mv_ref_monat_1 t
ON t.ref_monat <= CURRENT_DATE


WHERE
t.ref_monat BETWEEN au.dat_von AND au.dat_bis
AND su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN'
) cl_au

INNER JOIN dbp_view.v_cpr_phase_per_1  ph
ON cl_au.projekt_phase_id = ph.projekt_phase_id
AND cl_au.ref_monat BETWEEN ph.dat_von AND ph.dat_bis

INNER JOIN dbp_view.v_cpr_projekt_per_1 pr
ON ph.projekt_id = pr.projekt_id
AND cl_au.ref_monat BETWEEN pr.dat_von AND pr.dat_bis;