create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TOUR_PLOMBE(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	TOUR_ID,
	PLOMBE_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	STATUS_TOUR,
	CD_FG,
	TOUR_KUNDE_ID,
	DAT_SCAN,
	MAX_DAT_SCAN,
	ZEIT_SCAN,
	SCAN_DT,
	MAX_SCAN_DT,
	PLOMBE_PROZESS_ID,
	PLOMBE_PROZESS_BEZ,
	DAT_PLAN_ANKUNFT,
	ZEIT_PLAN_ANKUNFT,
	DIFF_PLAN_SCAN_MINUTEN,
	DIFF_PLAN_SCAN_MINUTEN_KARENZ,
	NACHTFENSTER_FLG,
	TAGANLIEFERUNG_FG,
	TOUR_ENTHAELT_OUG,
	START_ZEIT,
	ENDE_ZEIT,
	ZEIT_RELEVANT_FG
) as










SELECT
dt1.mandant_id,
dt1.wup_id,
dt1.nb_id,
dt1.tour_id,
dt1.plombe_id,
dt1.mandant_id_kunde,
CASE WHEN TRY_CAST(dt1.kunde_id AS INTEGER) IS NULL THEN -3 ELSE v05.aktuell_wup_id END kunde_id,


dt1.status_tour,
dt1.cd_fg,
dt1.tour_kunde_id,
dt1.dat_scan,
MAX(dt1.dat_scan) OVER (PARTITION BY dt1.wup_id, dt1.tour_id, dt1.kunde_id),
dt1.zeit_scan,
TIMESTAMP_FROM_PARTS(dat_scan, COALESCE(CAST(zeit_scan AS CHAR(8)),'00:00:00')) AS scan_dt,
timestamp_from_parts(MAX(dt1.max_dat_scan) OVER (PARTITION BY dt1.wup_id, dt1.tour_id, dt1.kunde_id),COALESCE(CAST(MAX(dt1.ende_zeit) OVER (PARTITION BY dt1.wup_id, dt1.tour_id, dt1.kunde_id) AS CHAR(8)),'00:00:00')) AS max_scan_dt,
dt1.plombe_prozess_id,
dt1.plombe_prozess_bez,
dt1.dat_plan_ankunft,
dt1.zeit_plan_ankunft,
dt1.diff_plan_scan_minuten,
dt1.diff_plan_scan_minuten_karenz,
dt1.nachtfenster_flg,
dt1.taganlieferung_fg,
dt1.tour_enthaelt_oug,
dt1.start_zeit,
dt1.ende_zeit,
dt1.zeit_relevant_fg
FROM
(
SELECT
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.tour_id,
v02.plombe_id,
v01.mandant_id_kunde,
v01.kunde_id,
v01.status_tour,
v01.cd_fg,
TRIM(v01.mandant_id)||TRIM(v01.tour_id)||TRIM(v01.mandant_id_kunde)||TRIM(v01.kunde_id) AS tour_kunde_id,
v02.dat_scan,
v02.max_dat_scan,
TO_TIME(CAST(v02.zeit_scan AS CHAR(8)), 'HH:MI:SS') AS zeit_scan,
v02.plombe_prozess_id,
CASE WHEN v02.plombe_prozess_id IN (1,3) THEN 'Plombe'
WHEN v02.plombe_prozess_id = 2 THEN 'WE-Palette'
END AS plombe_prozess_bez,
v01.dat_tour AS dat_plan_ankunft,
TO_TIME(v01.zeit_plan_ankunft) AS zeit_plan_ankunft,
timestamp_scan,
timestamp_plan_ankunft  AS timestamp_plan_ankunft_,
  CASE WHEN (CAST(timestamp_plan_ankunft_ AS DATE) = '9999-12-31') THEN NULL ELSE
CASE WHEN ((timestamp_plan_ankunft_ IS NOT NULL) AND (timestamp_scan IS NOT NULL))
THEN TRUNC(TIMESTAMPDIFF('second',timestamp_plan_ankunft_,timestamp_scan)/60)
ELSE NULL
END END AS diff_plan_scan_minuten,

TO_NUMBER(diff_plan_scan_minuten) - 15 AS diff_plan_scan_minuten_karenz,
TIMESTAMP_NTZ_FROM_PARTS(DATEADD('day',-1, v01.dat_tour ), '23:59:59')  AS timestamp_nacht_start, 
TIMESTAMP_NTZ_FROM_PARTS(v01.dat_tour, '06:00:00')  AS timestamp_nacht_ende,
  
CASE WHEN timestamp_plan_ankunft_ IS NOT NULL
THEN CASE WHEN timestamp_plan_ankunft_ BETWEEN timestamp_nacht_start AND timestamp_nacht_ende
THEN 1
ELSE 0
END
END AS nachtfenster_flg,
CASE WHEN v01.mandant_id = 1 AND SNOWCONVERT.PUBLIC.time_to_int_udf(v01.zeit_plan_ankunft) BETWEEN 54500 AND 220000 THEN 1
WHEN v01.mandant_id <> 1 THEN 1
ELSE 0
END AS taganlieferung_fg,
v01a.tour_enthaelt_oug,
v02.start_zeit,
v02.ende_zeit,
v01.zeit_relevant_fg
FROM
( 
SELECT
v011.mandant_id,
v011.nb_id,
v011.wup_id,
v011.tour_id,
v011.kunde_id,
v011.mandant_id_kunde,
v011.status_tour,
v011.cd_fg,
v011.zeit_plan_ankunft,
v011.dat_tour,

TIMESTAMP_NTZ_FROM_PARTS(v011.dat_tour, TO_CHAR(v011.zeit_plan_ankunft)) AS timestamp_plan_ankunft,
  v011.zeit_relevant_fg
FROM dbp_view.v_tour_det_zlv_vttkl v011
WHERE v011.zeit_relevant_fg = 1
) v01

LEFT JOIN (
SELECT DISTINCT v011.mandant_id,
v011.nb_id,
v011.wup_id,
v011.tour_id,
v011.kunde_id,
v011.mandant_id_kunde,
MAX(v012.oug_fg)  AS tour_enthaelt_oug
FROM dbp_view.v_tour_det_zlv_vttkl v011
INNER JOIN dbp_view.v_l_lagernummer v012
ON v011.mandant_id     = v012.mandant_id
AND v011.lagernummer_id = v012.lagernummer_id
WHERE v011.menge_stp_geraeumt <> 0
GROUP BY 1,2,3,4,5,6
) v01a

ON v01.mandant_id = v01a.mandant_id
AND v01.tour_id    = v01a.tour_id
AND v01.wup_id     = v01a.wup_id
AND v01.kunde_Id   = v01a.kunde_id

LEFT JOIN (
SELECT
v021.mandant_id,
v021.tour_id,
v021.plombe_id,
v021.wup_id,
v021.nb_id,
v021.dat_scan_ AS dat_scan,
v021.max_dat_scan_ AS max_dat_scan,
CASE WHEN CAST(v021.start_zeit_ AS CHAR(8)) < CAST(v021.zeit_scan_ AS CHAR(8))  THEN CAST(v021.start_zeit_ AS CHAR(8)) ELSE CAST(v021.zeit_scan_ AS CHAR(8)) END AS zeit_scan,
v021.start_zeit_ AS start_zeit,
v021.ende_zeit_ AS ende_zeit,
v021.plombe_prozess_id,
v021.plombe_aktivitaet,
v021.info_code,
v021.timestamp_scan_ AS timestamp_scan
FROM (SELECT
v022.mandant_id,
v022.tour_id,
v022.plombe_id,
v022.wup_id,
v022.nb_id,
v022.plombe_prozess_id,
v022.plombe_aktivitaet,
v022.info_code,
CASE WHEN v022.mandant_id IN (4,7,8) AND COALESCE(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v022.zeit_scan) ,0 )>= 230000 THEN v022.dat_scan + INTERVAL '1 day' ELSE v022.dat_scan END AS dat_scan_,
CASE WHEN v022.mandant_id IN (4,7,8) THEN  CASE WHEN COALESCE(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v022.zeit_scan) ,0 )>= 230000 THEN SNOWCONVERT.PUBLIC.INT_TO_TIME_UDF(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v022.zeit_scan) - 230000)  ELSE SNOWCONVERT.PUBLIC.INT_TO_TIME_UDF(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v022.zeit_scan) + 10000) END ELSE v022.zeit_scan END AS zeit_scan__,
zeit_scan__ AS zeit_scan_,
MIN(CASE WHEN dat_scan_ IS NOT NULL THEN TIMESTAMP_FROM_PARTS(dat_scan_, zeit_scan_) ELSE NULL END) AS timestamp_scan_,      
MIN(timestamp_scan_) OVER (PARTITION BY  v022.mandant_id, v022.tour_id, v022.wup_id) AS min_timestamp_scan_,
MAX(dat_scan_) OVER (PARTITION BY  v022.mandant_id, v022.tour_id, v022.wup_id) AS max_dat_scan_,
CAST(min_timestamp_scan_ AS TIME(0))  AS start_zeit_,
MAX(CASE WHEN plombe_prozess_id=2 THEN timestamp_scan_ ELSE NULL END) OVER (PARTITION BY  v022.mandant_id, v022.tour_id, v022.wup_id  ) TMP_max_2,
MAX(CASE WHEN plombe_prozess_id=3 THEN timestamp_scan_ ELSE NULL END) OVER (PARTITION BY  v022.mandant_id, v022.tour_id, v022.wup_id  ) TMP_max_3,
SUM ( CASE WHEN plombe_prozess_id=2 AND dat_scan_ IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY  v022.mandant_id, v022.tour_id, v022.wup_id) AS TMP_anz_pid_2,
CAST(CASE WHEN TMP_anz_pid_2 > 0 THEN TMP_max_2 ELSE TMP_max_3 END AS TIME(0))  AS ende_zeit_
FROM dbp_view.v_tour_plombe_ziel v022
WHERE  v022.dat_scan IS NOT NULL

AND NOT (v022.plombe_aktivitaet = 13 AND v022.info_code > 0) 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
) v021
WHERE  v021.dat_scan_ IS NOT NULL


QUALIFY ROW_NUMBER() OVER (PARTITION BY v021.mandant_id, v021.tour_id, v021.wup_id, v021.nb_id  ORDER BY timestamp_scan, plombe_prozess_id ASC) = 1
) v02

ON  v01.mandant_id_kunde                     = v02.mandant_id
AND v01.tour_id                               = v02.tour_id
AND CAST(SUBSTR(v01.kunde_id,7,4) AS INTEGER) = v02.wup_id

) dt1
LEFT JOIN dbp_view.v_wup v05
   ON v05.mandant_id = CASE WHEN dt1.mandant_id_kunde IS NULL OR dt1.mandant_id_kunde = 0 THEN dt1.mandant_id ELSE dt1.mandant_id_kunde END
   AND v05.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));