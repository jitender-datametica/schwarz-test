CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_BE_MONITORING_1
(
cycle_id
, teilprojekt_id
, teilprojekt_name
, teilprojekt_thema_id
, tp_thema_name
, prio
, env
, cfg
, scr_name
, job_name
, aktiv_flag
, loop_id
, proc_type
, proc_name
, script
, file
, file_line_count
, utl_row_count
, err
, sql_type
, status_1
, status_detail
, start_date_head
, start_date_head_year
, start_date_head_month
, start_date_head_day
, end_date_head
, end_date_head_year
, end_date_head_month
, end_date_head_day
, start_time_head
, start_time_head_round
, end_time_head
, start_date_detail
, start_date_detail_year
, start_date_detail_month
, start_date_detail_day
, end_date_detail
, end_date_detail_year
, end_date_detail_month
, end_date_detail_day
, start_time_detail
, end_time_detail
, start_time_det_round
, runtime_seconds_det
, runtime_minutes_detail_round
, runtime_10minutes_detail_round
, filter_zehn
, filter_zehn_dreissig
, filter_dreissig
)
AS
SELECT DISTINCT
cycle_id,
tp AS teilprojekt_id,
tp_name AS teilprojekt_name,
teilprojekt_thema_id,
tp_thema_name,
prio,
env,
cfg,
scr_name,
job AS job_name,
aktiv_fg AS aktiv_flag,
loop_id,
proc_type,
proc_name,
script,
file,
file_line_count,
utl_row_count,
err,
sql_type,
status_1,
status_det AS status_detail,
start_date_head,
start_date_head_year,
start_date_head_month,
start_date_head_day,
end_date_head,
end_date_head_year,
end_date_head_month,
end_date_head_day,
start_time_head,
start_time_head_round /*** MSC-WARNING - MSCEWI2025 - OUTPUT FORMAT '99:99:99' NOT SUPPORTED. ***/,
end_time_head /*** MSC-WARNING - MSCEWI2025 - OUTPUT FORMAT '99:99:99' NOT SUPPORTED. ***/,
start_date_detail,
start_date_detail_year,
start_date_detail_month,
start_date_detail_day,
end_date_detail,
end_date_detail_year,
end_date_detail_month,
end_date_detail_day,
start_time_detail,
end_time_detail /*** MSC-WARNING - MSCEWI2025 - OUTPUT FORMAT '99:99:99' NOT SUPPORTED. ***/,
start_time_det_round /*** MSC-WARNING - MSCEWI2025 - OUTPUT FORMAT '99:99:99' NOT SUPPORTED. ***/,
time_diff_detail AS runtime_seconds_det,
runtime_minutes_detail_round,
runtime_10minutes_detail_round,
filter_zehn,
filter_zehn_dreissig,
filter_dreissig
FROM
(SELECT
tp.teilprojekt_id AS tp,
tp.teilprojekt_name AS tp_name,
thema.teilprojekt_thema_id,
thema.teilprojekt_thema_name AS tp_thema_name,
thema.dat_begINn,
thema.dat_ENDe,
thema.prio_kz AS prio,
logma.cfg_file_name AS cfg,
logma.env_file_name AS env,
logdet.job_name AS job,
logdet.proc_type AS proc_type,
chk.sql_name AS sql_name,
chk.scr_name AS scr_name,
logdet.proc_name AS proc_name,
fig.aktiv_fg AS aktiv_fg,
logma.cycle_id,
logma.status_1 AS status_1,
logdet.status_1 AS status_det,
logdet.loop_id AS loop_id,
logdet.file_lINe_count AS file_lINe_count,
logdet.utl_row_count AS utl_row_count,
logdet.err_id AS err,
logdet.script_name AS script,
logdet.raw_file AS file,
chk.sql_type,
logdet.date_start AS start_date_detail,
date_part('year', start_date_detail) AS start_date_detail_year,
date_part('month', start_date_detail) AS start_date_detail_month,
date_part('day', start_date_detail) AS start_date_detail_day, 

COALESCE (logdet.date_end, logdet.date_start) AS end_date_detail,
date_part('year', end_date_detail) as  end_date_detail_year,
date_part('month', end_date_detail) as  end_date_detail_month,
date_part('day', end_date_detail) as  end_date_detail_day,
logdet.time_start AS start_time_detail,
COALESCE (logdet.time_end, logdet.time_start) AS end_time_detail,
logma.date_start AS start_date_head,
date_part('year',start_date_head) AS start_date_head_year,
date_part('month',start_date_head) AS start_date_head_month,
date_part('day',start_date_head) AS start_date_head_day,

COALESCE (logma.date_end, logma.date_start) AS end_date_head,

date_part('year', end_date_head) as end_date_head_year,
date_part('month', end_date_head) as end_date_head_month, 
date_part('day', end_date_head) as end_date_head_day,

logma.time_start AS start_time_head,
COALESCE (logma.time_end, logma.time_start) AS end_time_head,
--Time Anpassungen für Snowflake
timediff(seconds, start_time_detail, end_time_detail) AS time_diff_detail,
timediff(seconds, start_time_head, end_time_head) AS time_diff_head,
CASE
WHEN time_diff_detail < 60 THEN 1
ELSE TRUNC(
time_diff_detail::INT / 60) END AS runtime_minutes_detail_round,
TRUNC( ((time_diff_detail + 600) - (MOD((time_diff_detail+ 600), 600))) / 60) AS runtime_10minutes_detail_round,
SECOND(start_time_detail) AS substraction_seconds_detail,
MINUTE(start_time_detail) AS substraction_minutes_detail,
CAST(CASE
WHEN substraction_minutes_detail = 0 THEN 0
WHEN substraction_minutes_detail > 0 AND substraction_minutes_detail < 15 THEN 0
WHEN substraction_minutes_detail > 14 AND substraction_minutes_detail < 30 THEN 15
WHEN substraction_minutes_detail > 29 AND substraction_minutes_detail < 45 THEN 30
ELSE 45 END AS INTEGER) AS rounded_minutes_detail,
dateadd(minute, rounded_minutes_detail, dateadd(second, substraction_seconds_detail ,dateadd(minute, substraction_minutes_detail, start_time_detail))) AS start_time_det_round,
second(start_time_head) AS substraction_seconds_head,
MINUTE(start_time_head) AS substraction_minutes_head,
CAST(CASE
WHEN substraction_minutes_head = 0 THEN 0
WHEN substraction_minutes_head > 0 AND substraction_minutes_head < 15 THEN 0
WHEN substraction_minutes_head > 14 AND substraction_minutes_head < 30 THEN 15
WHEN substraction_minutes_head > 29 AND substraction_minutes_head < 45 THEN 30
ELSE 45 END AS INTEGER) AS rounded_minutes_head,
dateadd(minute, rounded_minutes_head, dateadd(second, substraction_seconds_head ,dateadd(minute, substraction_minutes_head, start_time_head))) AS start_time_head_round,
CASE
WHEN runtime_minutes_detail_round < 10 OR runtime_minutes_detail_round = 10 THEN 1
ELSE 0 END AS filter_zehn,
CASE
WHEN runtime_minutes_detail_round > 10 AND runtime_minutes_detail_round < 30 OR runtime_minutes_detail_round = 30 THEN 1
ELSE 0 END AS filter_zehn_dreissig,
CASE
WHEN runtime_minutes_detail_round > 30 THEN 1
ELSE 0 END AS filter_dreissig
FROM dbp_v_process.v_load_log_detail_1 logdet

INNER JOIN dbp_v_process.v_load_log_master_1 logma
ON  logdet.cycle_id = logma.cycle_id

LEFT JOIN
(SELECT
cycle_id,
sql_name,
sql_type,
job_name,
scr_name,
proc_type
FROM dbp_v_process.v_load_chk_figures_1
WHERE sql_type <> 'N/A'
GROUP BY 1,2,3,4,5,6
)  chk
ON logdet.cycle_id = chk.cycle_id
AND logdet.job_name = chk.job_name
AND logdet.proc_type  = chk.proc_type
AND logdet.proc_name = chk.scr_name

LEFT JOIN
(SELECT
cfg_file_name,
env_file_name,
job_name,
teilprojekt_thema_id,
sql_name,
scr_name,
proc_type,
aktiv_fg
FROM dbp_v_process.v_load_chk_figures_var_1
WHERE dat_ende >= CURRENT_DATE
AND dat_beginn <= CURRENT_DATE
AND aktiv_fg <> 0
GROUP BY 1,2,3,4,5,6,7,8
) fig
ON logma.cfg_file_name = fig.cfg_file_name
AND  logma.env_file_name = fig.env_file_name
AND chk.job_name = fig.job_name
AND chk.proc_type = fig.proc_type
AND chk.sql_name = fig.sql_name
AND chk.scr_name = fig.scr_name

LEFT JOIN dbp_v_process.v_load_teilprojekt_thema_1 thema
ON  thema.teilprojekt_thema_id = fig.teilprojekt_thema_id

LEFT JOIN dbp_v_process.v_load_teilprojekt_1 tp
ON tp.teilprojekt_id = thema.teilprojekt_id

) die_daten;


