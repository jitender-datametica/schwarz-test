/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_CALENDAR
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Client Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz	   Initial version
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2024-03-22 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC
PREV_MONTH_NBR;
NEXT_MONTH_NBR;
WORKING_DAY_FG;
WEEKEND_FG;
SATURDAY_FG;
SUNDAY_FG;
FRIDAY_FG;
THURSDAY_FG;
WEDNESDAY_FG;
TUESDAY_FG;
MONDAY_FG;
WEEK_START_FG;
WEEK_END_FG;
WEEK_ISO_START_FG;
WEEK_ISO_END_FG;
SPECIAL_DAY_FG;
*/


/* WORKING_DAY_FG						INTEGER AS (
														IFF(DAY_OF_WEEK_ISO_ID IN (1,2,3,4,5), 1, 0)
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge ob Kalendertag eine Arbeitstag ist (Mon-Fri)',
	WEEKEND_FG							INTEGER AS (
														IFF(DAY_OF_WEEK_ISO_ID IN (6,7), 1, 0)
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge ob Kalendertag an Wochenende ist (Sam-Son)',
	SATURDAY_FG							INTEGER AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 6, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Sam',
	SUNDAY_FG							INTEGER AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 7, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Sun',
	FRIDAY_FG							INTEGER AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 5, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Fri',
	THURSDAY_FG							INTEGER AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 4, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Thu',
	WEDNESDAY_FG						INTEGER AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 3, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Wed',
	TUESDAY_FG							INTEGER AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 2, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Tue',
	MONDAY_FG							INTEGER AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 1, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Mon', */
/* PREV_MONTH_NBR						INTEGER		 AS (
														IFF((MONTH_NBR - (CAST(1 % 12 AS INTEGER ))) = 0, 
															12, 
															MONTH_NBR - (CAST(1 % 12 AS INTEGER ))
															)
														) 																	COMMENT '[VC] Vorherige Monatsnummer. Z.b.: 12 --> 1. iff((MONTH_NBR - 1 % 12)=0,12::INTEGER,(MONTH_NBR - 1 % 12)::INTEGER)',
	NEXT_MONTH_NBR						INTEGER		 AS (
														IFF((MONTH_NBR + (CAST(1 % 12 AS INTEGER ))) = 0, 
															12, 
															MONTH_NBR + (CAST(1 % 12 AS			INTEGER ))
															)
														) 																	COMMENT '[VC] Nächste Monatsnummer. Z.b.: 11 --> 12. iff((MONTH_NBR + 1 % 12)=0,12::INTEGER,(MONTH_NBR + 1 % 12)::INTEGER)', */
/* SPECIAL_DAY_FG						INTEGER AS (
														IFF((DAY_DT) IN ('8888-12-31','9999-12-31','1900-01-01'), 
															1, 
															0
															)
														) 																	COMMENT 'Flagge markiert Spezielle Technische Datümer wie 1900-01-01. 8888-12-31, 9999-12-31', */
-- [View] Relevant Columns will be filled in View! Just mentioned here so that we have Column COMMENTs

/* WEEK_START_FG						INTEGER AS (
														IFF(DAY_OF_WEEK_ID = 1, 1, 0)
														) 																	COMMENT 'Flagge Starttag des Woche',
	WEEK_END_FG							INTEGER AS (
														IFF(DAY_OF_WEEK_ID = 7, 1, 0)
														) 																	COMMENT 'Flagge Endetag des Woche',
		
	WEEK_ISO_START_FG					INTEGER AS (
														IFF(DAY_OF_WEEK_ISO_ID = 1, 1, 0)
														) 																	COMMENT 'Flagge Starttag der ISO Woche',
	WEEK_ISO_END_FG						INTEGER AS (
														IFF(DAY_OF_WEEK_ISO_ID = 7, 1, 0)
														) 																	COMMENT 'Flagge Endetag der ISO Woche', */
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_calendar (
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Kalendertag, Format: YYYYMMDD'),
day_of_week_id INTEGER DEFAULT 0 OPTIONS(description='Wochentag 1-7; englisches Format Sonntag = 0; Montag = 7'),
day_of_week_iso_id INTEGER DEFAULT 0 OPTIONS(description='Wochentag nach ISO Kalender 7=Sonntag; 1= Montag'),
week_id INTEGER DEFAULT 0 OPTIONS(description='Wochen Identifiaktion (nach ISO) Format YYYYWW'),
week_iso_id INTEGER DEFAULT 0 OPTIONS(description='Wochen Identifiaktion (nach ISO) Format YYYYWW'),
month_id INTEGER DEFAULT 0 OPTIONS(description='Monats Identifikation Format YYYYMM Z.B.: 202112 für Dezember 2021'),
month_nbr INTEGER DEFAULT 0 OPTIONS(description='Monatsnummer Jan = 1 Feb = 2 â€¦ Dez = 12'),
year_id INTEGER DEFAULT 0 OPTIONS(description='Jahr'),
year_iso_id INTEGER DEFAULT 0 OPTIONS(description='Jahr (nach ISO)'),
fiscalyear_id INTEGER DEFAULT 0 OPTIONS(description='Fiskaljahr'),
moving_day_start_nbr INTEGER DEFAULT 0 OPTIONS(description='Fortlaufende Tagesnummer'),
mov_day_nbr_per_year INTEGER DEFAULT 0 OPTIONS(description='Fortlaufende Tagesnummer pro Jahr'),
mov_day_nbr_per_month INTEGER DEFAULT 0 OPTIONS(description='Fortlaufende Tagesnummer pro Monat'),
fiscal_year_start_fg INTEGER DEFAULT 0 OPTIONS(description='Flagge Starttag des Finanzjahres'),
fiscal_year_end_fg INTEGER DEFAULT 0 OPTIONS(description='Flagge Endtag des Finanzjahres'),
year_end_fg INTEGER DEFAULT 0 OPTIONS(description='Flagge Starttag des Jahres'),
year_start_fg INTEGER DEFAULT 0 OPTIONS(description='Flagge Endtag des Jahres'),
month_end_fg INTEGER DEFAULT 0 OPTIONS(description='Flagge Starttag des Monats'),
month_start_fg INTEGER DEFAULT 0 OPTIONS(description='Flagge Endetag des Monats'),
day_char STRING(8) DEFAULT '88881231' OPTIONS(description='Kalendertag als Text'),
day_int INTEGER DEFAULT 88881231 OPTIONS(description='Kalendertag als Zahl (Integer)'),
next_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Nächster Kalendertag'),
prev_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Vorheriger Kalendertag'),
sameday_prev_1_year_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Like-for-Like (LfL) Kalendertag vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_2_year_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Like-for-Like (LfL) Kalendertag vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_3_year_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Like-for-Like (LfL) Kalendertag vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_4_year_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Like-for-Like (LfL) Kalendertag vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_1_year_week_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_2_year_week_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche) vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_3_year_week_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_4_year_week_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_1_year_week_iso_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche nach ISO) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_2_year_week_iso_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche nach ISO) vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_3_year_week_iso_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche nach ISO) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_4_year_week_iso_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Woche nach ISO) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_1_year_month_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Monat) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_2_year_month_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Monat) vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_3_year_month_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Monat) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_4_year_month_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Monat) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_1_year_year_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Jahr) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_2_year_year_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Jahr) vor 2Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_3_year_year_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Jahr) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
sameday_prev_4_year_year_id INTEGER DEFAULT - 1
OPTIONS(description='Like-for-Like (LfL) Kalendertag (Jahr) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen'),
prev_1_month_id INTEGER DEFAULT - 1
OPTIONS(description='Vorheriger 1 Monat (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Mai/2021'),
prev_3_month_id INTEGER DEFAULT - 1
OPTIONS(description='Vorheriger 3 Monat (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> März/2021'),
prev_6_month_id INTEGER DEFAULT - 1
OPTIONS(description='Vorheriger 6 Monat (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Mai/2023'),
prev_9_month_id INTEGER DEFAULT - 1
OPTIONS(description='Vorheriger 9 Monat (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Mai/2024'),
prev_12_month_id INTEGER DEFAULT - 1
OPTIONS(description='Vorheriger 12 Monat (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Jun/2020'),
next_1_month_id INTEGER DEFAULT - 1
OPTIONS(description='Nächster Monat (bezogen auf den Kalendertag), e.g. 2021-Jun-25 --> Juli/2021'),
prev_1_year_id INTEGER DEFAULT - 1 OPTIONS(description='Vorheriges 1 Jahr z.B.: 2021 --> 2020'),
prev_2_year_id INTEGER DEFAULT - 1 OPTIONS(description='Vorheriges 2 Jahr z.B.: 2021 --> 2019'),
prev_3_year_id INTEGER DEFAULT - 1 OPTIONS(description='Vorheriges 3 Jahr z.B.: 2021 --> 2018'),
prev_4_year_id INTEGER DEFAULT - 1 OPTIONS(description='Vorheriges 4 Jahr z.B.: 2021 --> 2017'),
next_1_year_id INTEGER DEFAULT - 1 OPTIONS(description='Nächstes 1 Jahr z.B.: 2021 --> 2022'),
prev_1_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 1 Woche (nach ISO) z.B.: 202124 --> 202123'),
prev_2_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 2 Woche (nach ISO) z.B.: 202124 --> 202122'),
prev_3_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 3 Woche (nach ISO) z.B.: 202124 --> 202121'),
prev_4_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 4 Woche (nach ISO) z.B.: 202124 --> 202120'),
prev_5_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 5 Woche (nach ISO) z.B.: 202124 --> 202119'),
prev_6_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 6 Woche (nach ISO) z.B.: 202124 --> 202118'),
prev_7_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 7 Woche (nach ISO) z.B.: 202124 --> 202117'),
prev_8_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 8 Woche (nach ISO) z.B.: 202124 --> 202116'),
prev_9_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Vorherige 9 Woche (nach ISO) z.B.: 202124 --> 202115'),
prev_1_year_week_iso_id INTEGER DEFAULT - 1
OPTIONS(description='Vorheriges Woche (nach ISO) im vorigen Jahr z.B.: 202118 --> 202018'),
next_1_week_iso_id INTEGER DEFAULT - 1 OPTIONS(description='Nächste Woche (nach ISO) z.B.: 202124 --> 202125'),
leap_year_fg INTEGER DEFAULT 0 OPTIONS(description='Flagge zu Schaltjahr. [0/1]'),
prev_month_year_id INTEGER DEFAULT - 1 OPTIONS(description='Jahr des vorherigen Monats z.B.: 2021 bei Monat 202112'),
next_month_year_id INTEGER DEFAULT - 1 OPTIONS(description='Jahr des nächsten Monats z.B.: 2022 bei Monat 202112'),
moving_day_from_start INTEGER DEFAULT - 1
OPTIONS(description='Fortlaufende Zählung der Tage beginnend vom Starttag des Kalendars'),
moving_week_from_start INTEGER DEFAULT - 1
OPTIONS(description='Fortlaufende Zählung der Wochen beginnend vom Starttag des Kalendars'),
moving_week_iso_from_start INTEGER DEFAULT - 1
OPTIONS(description='Fortlaufende Zählung der Wochen (nach ISO) beginnend vom Starttag des Kalendars'),
moving_month_from_start INTEGER DEFAULT - 1
OPTIONS(description='Fortlaufende Zählung der Monate beginnend vom Starttag des Kalendars'),
moving_year_from_start INTEGER DEFAULT - 1
OPTIONS(description='Fortlaufende Zählung der Jahre beginnend vom Starttag des Kalendars'),
week_start_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Starttag der Woche (nach ISO) des jeweilig ausgewählten Tag des Kalenders'),
week_end_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Endetag der Woche (nach ISO) des jeweilig ausgewählten Tag des Kalenders'),
week_iso_start_day_dt DATE DEFAULT DATE '8888-12-31',
week_iso_end_day_dt DATE DEFAULT DATE '8888-12-31',
week_nbr INTEGER DEFAULT - 1 OPTIONS(description='Jahreswochennummer'),
week_iso_nbr INTEGER DEFAULT - 1 OPTIONS(description='Jahreswochennummer (nach ISO)'),
week_iso_sdesc STRING(16777216) DEFAULT 'N/A - 888853'
OPTIONS(description='Kurzbeschreibung der Woche (nach ISO) z.B.: W 2021/24'),
week_iso_ldesc STRING(16777216) DEFAULT 'N/A - 888853'
OPTIONS(description='Langbeschreibung der Woche (nach ISO) z.B.: Woche 2021/24'),
week_sdesc STRING(16777216) DEFAULT 'N/A - 888853',
week_ldesc STRING(16777216) DEFAULT 'N/A - 888853',
month_sdesc STRING(16777216) DEFAULT 'N/A - 888812'
OPTIONS(description='Kurzbeschreibung der Monat z.B.: 2021/ Dezember'),
month_display_name STRING(16777216) DEFAULT 'N/A - Dez / 8888'
OPTIONS(description='Report Darstellung des Monats z.B.: Monat Dezember / 2021'),
month_display_name_sdesc STRING(16777216) DEFAULT 'N/A - Dez / 8888'
OPTIONS(description='Report Darstellung des Monats z.B.: Dez / 2021'),
month_ldesc STRING(16777216) DEFAULT 'N/A - 888812'
OPTIONS(description='Langbeschreibung der Monat z.B.: Monat 2021/ Dezember'),
month_start_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Starttag des Monats des jeweilig ausgewählten Tag des Kalenders'),
month_end_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Endetag des Monats des jeweilig ausgewählten Tag des Kalenders'),
year_start_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Starttag des Jahres des jeweilig ausgewählten Tag des Kalenders'),
year_end_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Endetag des Jahres des jeweilig ausgewählten Tag des Kalenders'),
nbr_of_days_per_week INTEGER DEFAULT - 1 OPTIONS(description='Anzahl der Tage pro Woche'),
nbr_of_days_per_month INTEGER DEFAULT - 1 OPTIONS(description='Anzahl der Tage pro Monat'),
nbr_of_days_per_year INTEGER DEFAULT - 1 OPTIONS(description='Anzahl der Tage pro Jahr'),
day_of_week_sdesc STRING(16777216) DEFAULT 'N/A' OPTIONS(description='Kurzbeschreibung des Wochentages z.B.: Mo, Di'),
day_of_week_ldesc STRING(16777216) DEFAULT 'N/A'
OPTIONS(description='Langbeschreibung des Wochentages z.B.: Montag, Dienstag'),
prev_day_of_week INTEGER DEFAULT - 1 OPTIONS(description='Vorheriger Wochentag Z.B.: Mon (1) --> Son (0)'),
next_day_of_week INTEGER DEFAULT - 1 OPTIONS(description='Nächster Wochentag Z.B.: Mon (1) --> Die (2)'),
splitted_week_fg INTEGER DEFAULT 0
OPTIONS(description='Flagge / Indikator ob die Kalenderwoche in zwie Monate gesplittet ist'),
splitted_week_part1_nbr_of_days INTEGER DEFAULT 0
OPTIONS(description='Anzahl der Tage in der für die gesplittete Woche in vorherigen Monat'),
splitted_week_part2_nbr_of_days INTEGER DEFAULT 0
OPTIONS(description='Anzahl der Tage in der für die gesplittete Woche in aktuellem Monat'),
annotation STRING(16777216) OPTIONS(description='Anmerkungen zu dem jeweiligen Kalendertag, bzw. Name des Feiertages'),
current_day_fg INTEGER DEFAULT 0 OPTIONS(description='[View]: Flagge indiziert den aktuellen Tag = 1'),
current_year_fg INTEGER DEFAULT 0 OPTIONS(description='[View]: Flagge indiziert den aktuelle Monat = 1'),
current_week_fg INTEGER DEFAULT 0 OPTIONS(description='[View]: Flagge indiziert den aktuelle Woche nach ISO = 1'),
current_month_fg INTEGER DEFAULT 0,
mov_day_start_from_current INTEGER DEFAULT 0
OPTIONS(description='[View]: Fortlaufende Nummerierung der Tage wobei der aktuelle Tag ::= 0; gestern ::= -1 und morgen ::= +1'),
mov_week_start_from_current INTEGER DEFAULT 0
OPTIONS(description='[View]: Fortlaufende Nummerierung der Wochen (nach ISO) wobei die aktuelle Woche ::= 0; vorherige Woche ::= -1 und nächste Woche ::= +1'),
mov_month_start_from_current INTEGER DEFAULT 0
OPTIONS(description='[View]: Fortlaufende Nummerierung des Monats wobei der aktuelle Monat ::= 0; vorheriger Monat ::= -1 und nächster Monat ::= +1'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
PRIMARY KEY (day_dt) NOT ENFORCED
) OPTIONS(description='Dimension table calendar');