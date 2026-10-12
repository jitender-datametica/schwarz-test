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

CREATE TABLE P_LEW_MART_PIT.T_DIM_CALENDAR_2 (
	DAY_DT								DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Kalendertag, Format: YYYYMMDD',
	DAY_OF_WEEK_ID						INTEGER						DEFAULT 0 												COMMENT 'Wochentag 1-7; englisches Format Sonntag = 0; Montag = 7',
	DAY_OF_WEEK_ISO_ID					INTEGER						DEFAULT 0 												COMMENT 'Wochentag nach ISO Kalender 7=Sonntag; 1= Montag',
	WEEK_ID								INTEGER						DEFAULT 0 												COMMENT 'Wochen Identifiaktion (nach ISO) Format YYYYWW',
	WEEK_ISO_ID							INTEGER						DEFAULT 0 												COMMENT 'Wochen Identifiaktion (nach ISO) Format YYYYWW',
	MONTH_ID							INTEGER						DEFAULT 0 												COMMENT 'Monats Identifikation Format YYYYMM Z.B.: 202112 für Dezember 2021',
	MONTH_NBR							INTEGER						DEFAULT 0 												COMMENT 'Monatsnummer Jan = 1 Feb = 2 â€¦ Dez = 12',
		
	/*PREV_MONTH_NBR						INTEGER		 AS (
														IFF((MONTH_NBR - (CAST(1 % 12 AS NUMBER(2,0)))) = 0, 
															12, 
															MONTH_NBR - (CAST(1 % 12 AS NUMBER(2,0)))
															)
														) 																	COMMENT '[VC] Vorherige Monatsnummer. Z.b.: 12 --> 1. iff((MONTH_NBR - 1 % 12)=0,12::INTEGER,(MONTH_NBR - 1 % 12)::INTEGER)',
	NEXT_MONTH_NBR						INTEGER		 AS (
														IFF((MONTH_NBR + (CAST(1 % 12 AS NUMBER(2,0)))) = 0, 
															12, 
															MONTH_NBR + (CAST(1 % 12 AS			NUMBER(2,0)))
															)
														) 																	COMMENT '[VC] Nächste Monatsnummer. Z.b.: 11 --> 12. iff((MONTH_NBR + 1 % 12)=0,12::INTEGER,(MONTH_NBR + 1 % 12)::INTEGER)',
	*/	

	YEAR_ID								INTEGER						DEFAULT 0 												COMMENT 'Jahr',
	YEAR_ISO_ID							INTEGER						DEFAULT 0 												COMMENT 'Jahr (nach ISO)',
					
	FISCALYEAR_ID						INTEGER						DEFAULT 0 												COMMENT 'Fiskaljahr',
		

/*
	WORKING_DAY_FG						SMALLINT	 AS (
														IFF(DAY_OF_WEEK_ISO_ID IN (1,2,3,4,5), 1, 0)
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge ob Kalendertag eine_2 Arbeitstag ist (Mon-Fri)',
	WEEKEND_FG							SMALLINT	 AS (
														IFF(DAY_OF_WEEK_ISO_ID IN (6,7), 1, 0)
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge ob Kalendertag an Wochenende ist (Sam-Son)',
	SATURDAY_FG							SMALLINT	 AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 6, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Sam',
	SUNDAY_FG							SMALLINT	 AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 7, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Sun',
	FRIDAY_FG							SMALLINT	 AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 5, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Fri',
	THURSDAY_FG							SMALLINT	 AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 4, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Thu',
	WEDNESDAY_FG						SMALLINT	 AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 3, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Wed',
	TUESDAY_FG							SMALLINT	 AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 2, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Tue',
	MONDAY_FG							SMALLINT	 AS (		
														IFF(DAY_OF_WEEK_ISO_ID = 1, 1, 0)		
														)	NOT NULL 														COMMENT '[VC] Indikator Flagge Kalendertag = Mon',
		
*/
	MOVING_DAY_START_NBR				INTEGER						DEFAULT 0 												COMMENT 'Fortlaufende Tagesnummer',
	MOV_DAY_NBR_PER_YEAR				INTEGER						DEFAULT 0 												COMMENT 'Fortlaufende Tagesnummer pro Jahr',
	MOV_DAY_NBR_PER_MONTH				INTEGER						DEFAULT 0 												COMMENT 'Fortlaufende Tagesnummer pro Monat_2',
					
	FISCAL_YEAR_START_FG				SMALLINT					DEFAULT 0 												COMMENT 'Flagge Starttag des Finanzjahres',
	FISCAL_YEAR_END_FG					SMALLINT					DEFAULT 0 												COMMENT 'Flagge Endtag des Finanzjahres',
	YEAR_END_FG							SMALLINT					DEFAULT 0 												COMMENT 'Flagge Starttag des Jahres',
	YEAR_START_FG						SMALLINT					DEFAULT 0 												COMMENT 'Flagge Endtag des Jahres',
							
	MONTH_END_FG						SMALLINT					DEFAULT 0 												COMMENT 'Flagge Starttag des Monats',
	MONTH_START_FG						SMALLINT					DEFAULT 0 												COMMENT 'Flagge Endetag des Monats',
				
/*
	WEEK_START_FG						SMALLINT	 AS (
														IFF(DAY_OF_WEEK_ID = 1, 1, 0)
														) 																	COMMENT 'Flagge Starttag des Woche_2',
	WEEK_END_FG							SMALLINT	 AS (
														IFF(DAY_OF_WEEK_ID = 7, 1, 0)
														) 																	COMMENT 'Flagge Endetag des Woche_2',
		
	WEEK_ISO_START_FG					SMALLINT	 AS (
														IFF(DAY_OF_WEEK_ISO_ID = 1, 1, 0)
														) 																	COMMENT 'Flagge Starttag der ISO Woche_2',
	WEEK_ISO_END_FG						SMALLINT	 AS (
														IFF(DAY_OF_WEEK_ISO_ID = 7, 1, 0)
														) 																	COMMENT 'Flagge Endetag der ISO Woche_2',
*/		

	DAY_CHAR							VARCHAR(8)					DEFAULT '88881231' 										COMMENT 'Kalendertag als Text',
	DAY_INT								INTEGER						DEFAULT 88881231 										COMMENT 'Kalendertag als Zahl (Integer)',
		
	NEXT_DAY_DT							DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Nächster Kalendertag',
	PREV_DAY_DT							DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Vorheriger Kalendertag',
																															
	SAMEDAY_PREV_1_YEAR_DAY_DT			DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Like-for-Like (LfL) Kalendertag vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_2_YEAR_DAY_DT			DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Like-for-Like (LfL) Kalendertag vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_3_YEAR_DAY_DT			DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Like-for-Like (LfL) Kalendertag vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_4_YEAR_DAY_DT			DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Like-for-Like (LfL) Kalendertag vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_1_YEAR_WEEK_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_2_YEAR_WEEK_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2) vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_3_YEAR_WEEK_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_4_YEAR_WEEK_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_1_YEAR_WEEK_ISO_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2 nach ISO) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_2_YEAR_WEEK_ISO_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2 nach ISO) vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_3_YEAR_WEEK_ISO_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2 nach ISO) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_4_YEAR_WEEK_ISO_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Woche_2 nach ISO) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_1_YEAR_MONTH_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Monat_2) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_2_YEAR_MONTH_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Monat_2) vor 2 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_3_YEAR_MONTH_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Monat_2) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_4_YEAR_MONTH_ID		INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Monat_2) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_1_YEAR_YEAR_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Jahr) vor 1 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_2_YEAR_YEAR_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Jahr) vor 2Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_3_YEAR_YEAR_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Jahr) vor 3 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
	SAMEDAY_PREV_4_YEAR_YEAR_ID			INTEGER						DEFAULT -1 												COMMENT 'Like-for-Like (LfL) Kalendertag (Jahr) vor 4 Jahr,. Dh. Es Wird Mittwoch mit Mittwoch verglichen',
				
	PREV_1_MONTH_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriger 1 Monat_2 (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Mai/2021',
	PREV_3_MONTH_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriger 3 Monat_2 (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> März/2021',
	PREV_6_MONTH_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriger 6 Monat_2 (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Mai/2023',
	PREV_9_MONTH_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriger 9 Monat_2 (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Mai/2024',
	PREV_12_MONTH_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorheriger 12 Monat_2 (bezogen auf den Kalendertag), z.B.: 2021-Jun-25 --> Jun/2020',
	NEXT_1_MONTH_ID						INTEGER						DEFAULT -1 												COMMENT 'Nächster Monat_2 (bezogen auf den Kalendertag), e.g. 2021-Jun-25 --> Juli/2021',
							
	PREV_1_YEAR_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriges 1 Jahr z.B.: 2021 --> 2020',
	PREV_2_YEAR_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriges 2 Jahr z.B.: 2021 --> 2019',
	PREV_3_YEAR_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriges 3 Jahr z.B.: 2021 --> 2018',
	PREV_4_YEAR_ID						INTEGER						DEFAULT -1 												COMMENT 'Vorheriges 4 Jahr z.B.: 2021 --> 2017',
	NEXT_1_YEAR_ID						INTEGER						DEFAULT -1 												COMMENT 'Nächstes 1 Jahr z.B.: 2021 --> 2022',
				
	PREV_1_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 1 Woche_2 (nach ISO) z.B.: 202124 --> 202123',
	PREV_2_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 2 Woche_2 (nach ISO) z.B.: 202124 --> 202122',
	PREV_3_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 3 Woche_2 (nach ISO) z.B.: 202124 --> 202121',
	PREV_4_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 4 Woche_2 (nach ISO) z.B.: 202124 --> 202120',
	PREV_5_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 5 Woche_2 (nach ISO) z.B.: 202124 --> 202119',
	PREV_6_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 6 Woche_2 (nach ISO) z.B.: 202124 --> 202118',
	PREV_7_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 7 Woche_2 (nach ISO) z.B.: 202124 --> 202117',
	PREV_8_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 8 Woche_2 (nach ISO) z.B.: 202124 --> 202116',
	PREV_9_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Vorherige 9 Woche_2 (nach ISO) z.B.: 202124 --> 202115',
	PREV_1_YEAR_WEEK_ISO_ID				INTEGER						DEFAULT -1 												COMMENT 'Vorheriges Woche_2 (nach ISO) im vorigen Jahr z.B.: 202118 --> 202018',
	NEXT_1_WEEK_ISO_ID					INTEGER						DEFAULT -1 												COMMENT 'Nächste Woche_2 (nach ISO) z.B.: 202124 --> 202125',
				
	LEAP_YEAR_FG						SMALLINT					DEFAULT 0 												COMMENT 'Flagge zu Schaltjahr. [0/1]',
	
	PREV_MONTH_YEAR_ID					INTEGER						DEFAULT -1 												COMMENT 'Jahr des vorherigen Monats z.B.: 2021 bei Monat_2 202112',
	NEXT_MONTH_YEAR_ID					INTEGER						DEFAULT -1 												COMMENT 'Jahr des nächsten Monats z.B.: 2022 bei Monat_2 202112',
				
	MOVING_DAY_FROM_START				INTEGER						DEFAULT -1 												COMMENT 'Fortlaufende Zählung der Tage beginnend vom Starttag des Kalendars',
	MOVING_WEEK_FROM_START				INTEGER						DEFAULT -1 												COMMENT 'Fortlaufende Zählung der Wochen beginnend vom Starttag des Kalendars',
	MOVING_WEEK_ISO_FROM_START			INTEGER						DEFAULT -1 												COMMENT 'Fortlaufende Zählung der Wochen (nach ISO) beginnend vom Starttag des Kalendars',
	MOVING_MONTH_FROM_START				INTEGER						DEFAULT -1 												COMMENT 'Fortlaufende Zählung der Monate beginnend vom Starttag des Kalendars',
	MOVING_YEAR_FROM_START				INTEGER						DEFAULT -1 												COMMENT 'Fortlaufende Zählung der Jahre beginnend vom Starttag des Kalendars',
	
	WEEK_START_DAY_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Starttag der Woche_2 (nach ISO) des jeweilig ausgewählten Tag_2 des Kalenders',
	WEEK_END_DAY_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Endetag der Woche_2 (nach ISO) des jeweilig ausgewählten Tag_2 des Kalenders',
						
	WEEK_ISO_START_DAY_DT				DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	WEEK_ISO_END_DAY_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	
	WEEK_NBR							INTEGER						DEFAULT -1 												COMMENT 'Jahreswochennummer',
	WEEK_ISO_NBR						INTEGER						DEFAULT -1 												COMMENT 'Jahreswochennummer (nach ISO)',
	
	WEEK_ISO_SDESC						VARCHAR						DEFAULT 'N/A - 888853' 									COMMENT 'Kurzbeschreibung der Woche_2 (nach ISO) z.B.: W 2021/24',
	WEEK_ISO_LDESC						VARCHAR						DEFAULT 'N/A - 888853' 									COMMENT 'Langbeschreibung der Woche_2 (nach ISO) z.B.: Woche_2 2021/24',
							
	WEEK_SDESC							VARCHAR						DEFAULT 'N/A - 888853',
	WEEK_LDESC							VARCHAR						DEFAULT 'N/A - 888853',
							
	MONTH_SDESC							VARCHAR						DEFAULT 'N/A - 888812' 									COMMENT 'Kurzbeschreibung der Monat_2 z.B.: 2021/ Dezember',
	MONTH_DISPLAY_NAME					VARCHAR						DEFAULT 'N/A - Dez / 8888' 								COMMENT 'Report Darstellung des Monats z.B.: Monat_2 Dezember / 2021',
	MONTH_DISPLAY_NAME_SDESC			VARCHAR						DEFAULT 'N/A - Dez / 8888' 								COMMENT 'Report Darstellung des Monats z.B.: Dez / 2021',
	MONTH_LDESC							VARCHAR						DEFAULT 'N/A - 888812' 									COMMENT 'Langbeschreibung der Monat_2 z.B.: Monat_2 2021/ Dezember',
	
	MONTH_START_DAY_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Starttag des Monats des jeweilig ausgewählten Tag_2 des Kalenders',
	MONTH_END_DAY_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Endetag des Monats des jeweilig ausgewählten Tag_2 des Kalenders',
																															
	YEAR_START_DAY_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Starttag des Jahres des jeweilig ausgewählten Tag_2 des Kalenders',
	YEAR_END_DAY_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 			COMMENT 'Endetag des Jahres des jeweilig ausgewählten Tag_2 des Kalenders',
	
	NBR_OF_DAYS_PER_WEEK				INTEGER						DEFAULT -1 												COMMENT 'Anzahl der Tage pro Woche_2',
	NBR_OF_DAYS_PER_MONTH				INTEGER						DEFAULT -1 												COMMENT 'Anzahl der Tage pro Monat_2',
	NBR_OF_DAYS_PER_YEAR				INTEGER						DEFAULT -1 												COMMENT 'Anzahl der Tage pro Jahr',
	
	DAY_OF_WEEK_SDESC					VARCHAR						DEFAULT 'N/A' 											COMMENT 'Kurzbeschreibung des Wochentages z.B.: Mo, Di',
	DAY_OF_WEEK_LDESC					VARCHAR						DEFAULT 'N/A' 											COMMENT 'Langbeschreibung des Wochentages z.B.: Montag, Dienstag',
			
	PREV_DAY_OF_WEEK					INTEGER						DEFAULT -1 												COMMENT 'Vorheriger Wochentag Z.B.: Mon (1) --> Son (0)',
	NEXT_DAY_OF_WEEK					INTEGER						DEFAULT -1 												COMMENT 'Nächster Wochentag Z.B.: Mon (1) --> Die (2)',
						
	SPLITTED_WEEK_FG					SMALLINT					DEFAULT 0 												COMMENT 'Flagge / Indikator ob die Kalenderwoche in zwie Monate gesplittet ist',
	SPLITTED_WEEK_PART1_NBR_OF_DAYS		INTEGER						DEFAULT 0 												COMMENT 'Anzahl der Tage in der für die gesplittete Woche_2 in vorherigen Monat_2',
	SPLITTED_WEEK_PART2_NBR_OF_DAYS		INTEGER						DEFAULT 0 												COMMENT 'Anzahl der Tage in der für die gesplittete Woche_2 in aktuellem Monat_2',

	ANNOTATION							VARCHAR 																			COMMENT 'Anmerkungen zu dem jeweiligen Kalendertag, bzw. Name des Feiertages',
	
	-- [View] Relevant Columns will be filled in View! Just mentioned here so that we have Column COMMENTs
	CURRENT_DAY_FG						SMALLINT					DEFAULT 0 												COMMENT '[View]: Flagge indiziert den aktuellen Tag_2 = 1',
	CURRENT_YEAR_FG						SMALLINT					DEFAULT 0 												COMMENT '[View]: Flagge indiziert den aktuelle Monat_2 = 1',
	CURRENT_WEEK_FG						SMALLINT					DEFAULT 0 												COMMENT '[View]: Flagge indiziert den aktuelle Woche_2 nach ISO = 1',
	CURRENT_MONTH_FG					SMALLINT					DEFAULT 0,
			
	MOV_DAY_START_FROM_CURRENT			INTEGER						DEFAULT 0 												COMMENT '[View]: Fortlaufende Nummerierung der Tage wobei der aktuelle Tag_2 ::= 0; gestern ::= -1 und morgen ::= +1',
	MOV_WEEK_START_FROM_CURRENT			INTEGER						DEFAULT 0 												COMMENT '[View]: Fortlaufende Nummerierung der Wochen (nach ISO) wobei die aktuelle Woche_2 ::= 0; vorherige Woche_2 ::= -1 und nächste Woche_2 ::= +1',
	MOV_MONTH_START_FROM_CURRENT		INTEGER						DEFAULT 0 												COMMENT '[View]: Fortlaufende Nummerierung des Monats wobei der aktuelle Monat_2 ::= 0; vorheriger Monat_2 ::= -1 und nächster Monat_2 ::= +1',

	/*SPECIAL_DAY_FG						SMALLINT	 AS (
														IFF((DAY_DT) IN ('8888-12-31','9999-12-31','1900-01-01'), 
															1, 
															0
															)
														) 																	COMMENT 'Flagge markiert Spezielle Technische Datümer wie 1900-01-01. 8888-12-31, 9999-12-31',
 */
	DWH_CREATED_TS						TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 							COMMENT 'Timestamp when record was created',
	PRIMARY KEY (DAY_DT)
)	COMMENT='Dimension table calendar_2'
;