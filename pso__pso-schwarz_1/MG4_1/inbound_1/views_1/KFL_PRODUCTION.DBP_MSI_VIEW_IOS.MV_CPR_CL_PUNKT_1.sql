create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_IOS.MV_CPR_CL_PUNKT_1(
	CHECKLISTE_PUNKT_ID,
	CPR_CHECKLISTE_ID,
	PROJEKT_PHASE_ID,
	DAT_IST_TERMIN,
	DAT_START_SOLL,
	DAT_SOLL_TERMIN,
	DAT_SOLL_TERMIN_TEXT,
	DAT_START_TERMIN,
	DAT_START_VORHERSAGE,
	DAT_ENDE_VORHERSAGE,
	DAT_TERMIN,
	DAT_TERMIN_GJ,
	TERMIN_FG,
	TEXT_TERMIN,
	TEXT2_TERMIN,
	DAUER_TERMIN,
	SORTIER_NUMMER,
	OK_FG,
	NICHT_OK_FG,
	NICHT_RELEVANT_FG,
	OBLIGATORISCH_FG,
	CPR_SUCHFELD_ID,
	CPR_PROZESS,
	TERMINART,
	DAT_START_IST,
	DAT_ENDE_IST,
	DAT_START_MAX,
	DAT_ENDE_MAX,
	DAT_START_PLAN,
	DAT_ENDE_PLAN,
	DAT_START_EINSCHRAENKUNG,
	DAT_ENDE_EINSCHRAENKUNG,
	GESAMT_PUFFER,
	DAUER,
	CPR_PRIO,
	DAT_ERSTELLUNG,
	CPR_SYSTEMSTATUS1_ID,
	CPR_SYSTEMSTATUS3_ID,
	CPR_SYSTEMSTATUS2_ID,
	MANDANT_ID,
	SORTIER_NR_MHRWRTGKT,
	DAT_REALISIERUNG,
	DAT_START_REALISIERUNG,
	DAT_SOLL_MONAT,
	AKT_GJ
) as

   SELECT
   cl_au.checkliste_punkt_id AS checkliste_punkt_id, cl_au.cpr_checkliste_id AS cpr_checkliste_id, cl_au.projekt_phase_id AS projekt_phase_id, CASE
   WHEN cl_au.dat_ende_ist IS NOT NULL AND cl_au.dat_ende_ist <> CAST( '1900-01-01' as date)
   THEN cl_au.dat_ende_ist
   ELSE CAST(NULL AS DATE)
   END       AS dat_ist_termin, CASE
   WHEN cl_au.dat_start_einschraenkung IS NOT NULL AND cl_au.dat_start_einschraenkung <> CAST( '1900-01-01' as date)
   THEN cl_au.dat_start_einschraenkung
   ELSE CAST(NULL AS DATE)
   END       AS dat_start_soll, CASE
   WHEN cl_au.dat_ende_einschraenkung IS NOT NULL AND cl_au.dat_ende_einschraenkung <> CAST( '1900-01-01' as date)
   THEN cl_au.dat_ende_einschraenkung
   ELSE CAST(NULL AS DATE)
   END       AS dat_soll_termin, CASE
   WHEN dat_soll_termin <= CURRENT_DATE + 98 THEN TO_VARCHAR(dat_soll_termin, 'DD.MM.YYYY')
   WHEN dat_soll_termin <= ADD_MONTHS(CURRENT_DATE, 6) THEN TO_VARCHAR(dat_soll_termin, 'MMMBYYYY')
   WHEN dat_soll_termin<= ADD_MONTHS(CURRENT_DATE, 18) THEN CAST(
   CASE
   WHEN EXTRACT(MONTH FROM dat_soll_termin) BETWEEN 1 AND 3 THEN 'I'
   WHEN EXTRACT(MONTH FROM dat_soll_termin) BETWEEN 4 AND 6 THEN 'II'
   WHEN EXTRACT(MONTH FROM dat_soll_termin) BETWEEN 7 AND 9 THEN 'III'
   WHEN EXTRACT(MONTH FROM dat_soll_termin) BETWEEN 10 AND 12 THEN 'IV'
   ELSE ''
   END || '/' || extract('YYYY', dat_soll_termin) AS VARCHAR (10))
   WHEN dat_soll_termin > ADD_MONTHS(CURRENT_DATE, 18) THEN TO_VARCHAR(dat_soll_termin, 'YYYY')
   ELSE NULL
   END       AS dat_soll_termin_text, COALESCE(
   CASE WHEN dat_start_ist = CAST( '1900-01-01' as date) THEN NULL ELSE dat_start_ist
   END,
   CASE
   WHEN dat_start_soll >= CURRENT_DATE THEN dat_start_soll
   ELSE NULL
   END)::DATE AS dat_start_termin, CASE WHEN cl_au.dat_start_vorhersage IS NOT NULL AND cl_au.dat_start_vorhersage <> CAST( '1900-01-01' as date)
   THEN cl_au.dat_start_vorhersage ELSE CAST(NULL AS DATE) END       AS dat_start_vorhersage, CASE WHEN cl_au.dat_ende_vorhersage IS NOT NULL AND cl_au.dat_ende_vorhersage <> CAST( '1900-01-01' as date)
   THEN cl_au.dat_ende_vorhersage ELSE CAST(NULL AS DATE) END       AS dat_ende_vorhersage, CASE WHEN dat_ist_termin <> CAST( '1900-01-01' as date) AND  dat_ist_termin IS NOT NULL THEN   dat_ist_termin
   WHEN   dat_ende_vorhersage IS NOT NULL    AND dat_ende_vorhersage <> CAST( '1900-01-01' as date) AND dat_ende_vorhersage >= CURRENT_DATE THEN dat_ende_vorhersage
   WHEN   dat_soll_termin >= CURRENT_DATE  THEN dat_soll_termin
   END::DATE AS dat_termin, tg.dat_termin_gj, CASE
   WHEN dat_termin <= CURRENT_DATE THEN 1
   WHEN dat_termin > CURRENT_DATE THEN 0
   ELSE -1
   END::BYTEINT     AS termin_fg, CASE
   WHEN dat_termin <= CURRENT_DATE + 98 THEN TO_VARCHAR(dat_termin, 'DD.MM.YYYY')
   WHEN dat_termin <= ADD_MONTHS(CURRENT_DATE, 6) THEN TO_VARCHAR(dat_termin, 'MMMBYYYY')
   WHEN dat_termin<= ADD_MONTHS(CURRENT_DATE, 18) THEN CAST(
   CASE
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 1 AND 3 THEN 'I'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 4 AND 6 THEN 'II'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 7 AND 9 THEN 'III'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 10 AND 12 THEN 'IV'
   ELSE ''
   END || '/' || extract('YYYY', dat_termin) AS VARCHAR (10))
   WHEN dat_termin > ADD_MONTHS(CURRENT_DATE, 18) THEN TO_VARCHAR(dat_termin, 'YYYY')
   ELSE NULL
   END       AS text_termin, CASE
   WHEN  dat_ist_termin  IS NOT NULL  AND dat_ist_termin <> CAST( '1900-01-01' as date) THEN TO_VARCHAR(dat_ist_termin, 'DD.MM.YYYY')
   WHEN  dat_ende_vorhersage  IS NOT NULL  AND dat_ende_vorhersage  > CURRENT_DATE THEN TO_VARCHAR(CURRENT_DATE, 'MMMBYYYY')
   WHEN  dat_soll_termin  IS NOT NULL  AND   dat_soll_termin  > CURRENT_DATE THEN TO_VARCHAR(dat_soll_termin, 'MMMBYYYY')
   ELSE  NULL END  AS text2_termin, CASE
   WHEN dat_ende_ist <> CAST( '1900-01-01' as date) AND dat_start_ist <> CAST( '1900-01-01' as date) AND dat_ende_ist >= dat_start_ist
   THEN dat_ende_ist - dat_start_ist

   WHEN  dat_ende_einschraenkung <> CAST( '1900-01-01' as date) AND dat_start_einschraenkung <> CAST( '1900-01-01' as date)  AND dat_ende_einschraenkung >= dat_start_einschraenkung
   THEN dat_ende_einschraenkung - dat_start_einschraenkung

   ELSE 0
   END AS dauer_termin, cl_au.sortier_nummer AS sortier_nummer, cl_au.ok_fg   AS ok_fg, cl_au.nicht_ok_fg  AS nicht_ok_fg, cl_au.nicht_relevant_fg AS nicht_relevant_fg, cl_au.obligatorisch_fg AS obligatorisch_fg, cl_au.cpr_suchfeld AS cpr_suchfeld_id, cl_au.cpr_prozess  AS cpr_prozess, cl_au.terminart  AS terminart, CASE
   WHEN cl_au.dat_start_ist <> CAST( '1900-01-01' as date)
   THEN cl_au.dat_start_ist
   ELSE CAST(NULL AS DATE)
   END     AS dat_start_ist, cl_au.dat_ende_ist AS dat_ende_ist, cl_au.dat_start_max  AS dat_start_max, cl_au.dat_ende_max AS dat_ende_max, cl_au.dat_start_plan AS dat_start_plan, cl_au.dat_ende_plan  AS dat_ende_plan, cl_au.dat_start_einschraenkung AS dat_start_einschraenkung, cl_au.dat_ende_einschraenkung AS dat_ende_einschraenkung, cl_au.gesamt_puffer  AS gesamt_puffer, cl_au.dauer   AS dauer, cl_au.cpr_prio  AS cpr_prio, cl_au.dat_erstellung AS dat_erstellung, cl_au.cpr_systemstatus1_id AS cpr_systemstatus1_id, cl_au.cpr_systemstatus3_id AS cpr_systemstatus3_id, cl_au.cpr_systemstatus2_id AS cpr_systemstatus2_id, pr.mandant_id, cl_au.sortier_nr_mhrwrtgkt, CASE
   WHEN dat_termin <= CURRENT_DATE + 84 THEN TO_VARCHAR(dat_termin, 'DD.MM.YY')
   WHEN dat_termin <= CURRENT_DATE + 168  THEN TO_VARCHAR(dat_termin, 'MMMBYY')
   WHEN dat_termin<= ADD_MONTHS(CURRENT_DATE, 18) THEN CAST(
   CASE
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 1 AND 3 THEN 'I'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 4 AND 6 THEN 'II'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 7 AND 9 THEN 'III'
   WHEN EXTRACT(MONTH FROM dat_termin) BETWEEN 10 AND 12 THEN 'IV'
   ELSE ''
   END || '/' || extract('YY', dat_termin ) AS VARCHAR (10))
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
   END || '/' || extract('YY',dat_start_termin ) AS VARCHAR (10))
   ELSE NULL
   END       AS dat_start_realisierung, CASE
   WHEN dat_ist_termin IS NULL AND dat_soll_termin IS NOT NULL THEN TO_VARCHAR(dat_soll_termin, 'MMMBYY')
   WHEN dat_ist_termin IS NOT NULL  THEN TO_VARCHAR(dat_ist_termin, 'DD.MM.YY')
   ELSE NULL
   END       AS dat_soll_monat, tg.akt_gj

   FROM
   ( -- cl_au
   SELECT
   cp.checkliste_punkt_id, cp.cpr_checkliste_id, cl.projekt_phase_id, MOD(cp.sortier_nummer, 100) AS sortier_nummer, cp.ok_fg, cp.nicht_ok_fg, cp.nicht_relevant_fg, cp.obligatorisch_fg, su.cpr_suchfeld, CAST(NULL AS CHAR(40)) AS cpr_prozess, CAST(NULL AS CHAR(20)) AS terminart, cp.dat_start_ist, cp.dat_ende_ist, cp.dat_start_max, cp.dat_ende_max, cp.dat_start_plan, cp.dat_ende_plan, cp.dat_start_einschraenkung, cp.dat_ende_einschraenkung, cp.gesamt_puffer, CAST(NULL AS DECIMAL(18,3)) AS dauer, cp.cpr_prio, cp.dat_erstellung, cp.cpr_systemstatus1_id, cp.cpr_systemstatus3_id, cp.cpr_systemstatus2_id, cp.cpr_suchfeld_id, cp.sortier_nr_mhrwrtgkt, CASE WHEN cp.dat_start_vorhersage IS NOT NULL AND cp.dat_start_vorhersage <> CAST( '1900-01-01' as date)
   THEN cp.dat_start_vorhersage ELSE CAST(NULL AS DATE) END       AS dat_start_vorhersage, CASE WHEN cp.dat_ende_vorhersage IS NOT NULL AND cp.dat_ende_vorhersage <> CAST( '1900-01-01' as date)
   THEN cp.dat_ende_vorhersage ELSE CAST(NULL AS DATE) END       AS dat_ende_vorhersage, '' AS dat_realisierung, '' AS dat_start_realisierung, '' AS dat_soll_monat, tg.akt_gj

   FROM dbp_view.v_cpr_cl_punkt_per_1 cp
   INNER JOIN dbp_view.v_cpr_checkliste_per_1  cl
   ON cp.cpr_checkliste_id = cl.cpr_checkliste_id
   AND cl.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_l_cpr_suchfeld_1 su
   ON cp.cpr_suchfeld_id = su.cpr_suchfeld_id
   CROSS JOIN
   (
   SELECT
   gj, akt_gj, MAX(max_dat) AS dat_termin_gj
   FROM dbp_view.v_monat_1 tg
   WHERE akt_gj = 0
   GROUP BY 1,2
   ) tg

   WHERE
   cp.dat_bis = '9999-12-31'
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
   END AS nicht_ok_fg, CASE
   WHEN au.cpr_systemstatus1_id = 4
   THEN 1
   ELSE 0
   END     AS nicht_relevant_fg, 0  AS obligatorisch_fg, CASE
   WHEN su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN' THEN 'KBE_BAUANTRAG'
   --WHEN su.cpr_suchfeld = 'CPR_REALISIERUNG' THEN 'BAUBEGINN'
   ELSE su.cpr_suchfeld
   END     AS cpr_suchfeld, CAST(NULL AS CHAR(40)) AS cpr_prozess, CAST(NULL AS CHAR(20)) AS terminart, au.dat_start_ist, CASE
   WHEN su.cpr_suchfeld IN ('CPR_BAURECHTSVERFAHREN')
   THEN au.dat_start_ist
   ELSE au.dat_ende_ist
   END     AS dat_ende_ist, au.dat_start_max, CASE
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
   END     AS dat_ende_einschraenkung, au.gesamt_puffer, au.dauer, au.cpr_prio, CAST(NULL AS DATE) AS dat_erstellung, au.cpr_systemstatus1_id, au.cpr_systemstatus3_id, au.cpr_systemstatus2_id, su.cpr_suchfeld_id, CAST(1 AS SMALLINT) AS sortier_nr_mhrwrtgkt, CASE WHEN au.dat_start_vorhersage IS NOT NULL AND au.dat_start_vorhersage <> CAST( '1900-01-01' as date)
   THEN au.dat_start_vorhersage ELSE CAST(NULL AS DATE) END       AS dat_start_vorhersage, CASE WHEN au.dat_ende_vorhersage IS NOT NULL AND au.dat_ende_vorhersage <> CAST( '1900-01-01' as date)
   THEN au.dat_ende_vorhersage ELSE CAST(NULL AS DATE) END       AS dat_ende_vorhersage, '' AS dat_realisierung, '' AS dat_start_realisierung, '' AS dat_soll_monat, 0 AS akt_gj


   FROM dbp_view.v_cpr_aufgabe_per_1  au
   INNER JOIN dbp_view.v_l_cpr_suchfeld_1  su
   ON au.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE
   au.dat_bis = '9999-12-31'
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
   END     AS nicht_relevant_fg, 0  AS obligatorisch_fg, 'KBE_BAUGENEHMIGUNG'  AS cpr_suchfeld, CAST(NULL AS CHAR(40)) AS cpr_prozess, CAST(NULL AS CHAR(20)) AS terminart, au.dat_start_ist, au.dat_ende_ist, au.dat_start_max, au.dat_ende_max, au.dat_start_plan, au.dat_ende_plan, au.dat_start_einschraenkung, au.dat_ende_einschraenkung, au.gesamt_puffer, au.dauer, au.cpr_prio, CAST(NULL AS DATE) AS dat_erstellung, au.cpr_systemstatus1_id, au.cpr_systemstatus3_id, au.cpr_systemstatus2_id, su.cpr_suchfeld_id, CAST(1 AS SMALLINT) AS sortier_nr_mhrwrtgkt, au.dat_start_vorhersage AS dat_start_vorhersage, au.dat_ende_vorhersage AS dat_ende_vorhersage, '' AS dat_realisierung, '' AS dat_start_realisierung, '' AS dat_soll_monat, 0 AS akt_gj


   FROM dbp_view.v_cpr_aufgabe_per_1  au
   INNER JOIN dbp_view.v_l_cpr_suchfeld_1   su
   ON au.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE
   au.dat_bis = '9999-12-31'
   AND su.cpr_suchfeld = 'CPR_BAURECHTSVERFAHREN'
   ) cl_au
   INNER JOIN dbp_view.v_cpr_phase_per_1  ph
   ON cl_au.projekt_phase_id = ph.projekt_phase_id
   AND ph.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_cpr_projekt_per_1 pr
   ON ph.projekt_id = pr.projekt_id
   AND pr.dat_bis = '9999-12-31'
   CROSS JOIN
   (
   SELECT
   gj, akt_gj, MAX(max_dat) AS dat_termin_gj
   FROM dbp_view.v_monat_1 tg
   WHERE akt_gj = 0
   GROUP BY 1,2
   ) tg;