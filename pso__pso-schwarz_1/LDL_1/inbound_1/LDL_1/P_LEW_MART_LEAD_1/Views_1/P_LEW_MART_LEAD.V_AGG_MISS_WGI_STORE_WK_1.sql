/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_lead.v_agg_miss_wgi_store_wk_1 COMMENT = 'Counts the missing items per warehouse/partial week'
(
  client_id                       COMMENT 'MIS Client ID'
, loc_sid_wh                      COMMENT 'S-Key der Gesellschaft'
, move_to_store_id                COMMENT 'S-Key der Location_1, hier der Filiale'
, wh_id                           COMMENT 'Gesellschaft ID'
, orig_store_nr                   COMMENT 'Store ID'
, item_grp_int_sid                COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id                COMMENT 'Warengruppe ID'
, aspect_id                       COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                 COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                     COMMENT 'Interner Währungs-Code'
, cy_week_partial_week_id         COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                        COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                         COMMENT 'Geschäftsjahr'
, skipped_cnt                     COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, day_cnt                         COMMENT 'Anzahl der öffenen Tage der Woche_1'
, miss_item_cnt_d1                COMMENT 'Anzahl der Fehlartikel Tag_1 1 (Montag)'
, miss_item_cnt_d2                COMMENT 'Anzahl der Fehlartikel Tag_1 2 (Dienstag)'
, miss_item_cnt_d3                COMMENT 'Anzahl der Fehlartikel Tag_1 3 (Mittwoch)'
, miss_item_cnt_d4                COMMENT 'Anzahl der Fehlartikel Tag_1 4 (Donnerstag)'
, miss_item_cnt_d5                COMMENT 'Anzahl der Fehlartikel Tag_1 5 (Freitag)'
, miss_item_cnt_d6                COMMENT 'Anzahl der Fehlartikel Tag_1 6 (Samstag)'
, miss_item_cnt_d7                COMMENT 'Anzahl der Fehlartikel Tag_1 7 (Sonntag)'
, miss_item_cnt                   COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_1'
, miss_item_cnt_avg_day           COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_1)'
, day_cnt_vj                      COMMENT 'Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'
, skipped_cnt_vj                  COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_vj                COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_1 aus dem Vorjahr'
, miss_item_cnt_avg_day_vj        COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_1 aus dem Vorjahr)'
, miss_item_cnt_avg_day_diff      COMMENT 'Differenz zwischen den Durschnittswert (aktuell) und dem Duchschnittswert (Vorjahr)'
, day_cnt_mtd                     COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats'
, skipped_cnt_mtd                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_mtd               COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats'
, day_cnt_mtd_vj                  COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr'
, skipped_cnt_mtd_vj              COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_mtd_vj            COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr'
, miss_item_cnt_avg_day_mtd       COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats)'
, miss_item_cnt_avg_day_mtd_vj    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr)'
, miss_item_cnt_avg_day_mtd_diff  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr)'
, day_cnt_ytd                     COMMENT 'Anzahl der öffenen aufgelaufen Tagen des aktuellen Geschäftsjahrs'
, skipped_cnt_ytd                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_ytd               COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des aktuellen Geschäftsjahres'
, day_cnt_ytd_vj                  COMMENT 'Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres'
, skipped_cnt_ytd_vj              COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_ytd_vj            COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres'
, miss_item_cnt_avg_day_ytd       COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des aktuellen Geschäftsjahres)'
, miss_item_cnt_avg_day_ytd_vj    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres)'
, miss_item_cnt_avg_day_ytd_diff  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr)'
)
AS
SELECT
	d.client_id
	, d.loc_sid_wh
	, d.move_to_store_id
	, d.wh_id
	, d.orig_store_nr
	, d.item_grp_int_sid
	, d.itemgroup_int_id
	, d.aspect_id
	, d.currency_iso_cd
	, d.curr_tot_id
	, d.cy_week_partial_week_id
	, d.cy_month
	, d.busyear
	, d.skipped_cnt_wtd
	, d.day_cnt_wtd
	, d.miss_item_cnt_d1
	, d.miss_item_cnt_d2
	, d.miss_item_cnt_d3
	, d.miss_item_cnt_d4
	, d.miss_item_cnt_d5
	, d.miss_item_cnt_d6
	, d.miss_item_cnt_d7
	, d.miss_item_cnt_wtd
	, CASE WHEN d.day_cnt_wtd > 0 THEN (d.miss_item_cnt_wtd / d.day_cnt_wtd) ELSE 0 END AS miss_item_cnt_avg_day_wtd
	, d.day_cnt_wtd_vj
	, d.skipped_cnt_wtd_vj
	, d.miss_item_cnt_wtd_vj
	, CASE WHEN d.day_cnt_wtd_vj > 0 THEN (d.miss_item_cnt_wtd_vj / d.day_cnt_wtd_vj) ELSE 0 END			AS miss_item_cnt_avg_day_wtd_vj
	, miss_item_cnt_avg_day_wtd - miss_item_cnt_avg_day_wtd_vj												AS miss_item_cnt_avg_day_wtd_diff
	, d.mtd_store_day_cnt																					AS day_cnt_mtd
	, d.mtd_skipped_cnt																						AS skipped_cnt_mtd
	, d.mtd_miss_item_cnt																					AS miss_item_cnt_mtd
	, d.mtd_store_day_cnt_vj																				AS day_cnt_mtd_vj
	, d.mtd_skipped_cnt_vj																					AS skipped_cnt_mtd_vj
	, d.mtd_miss_item_cnt_vj																				AS miss_item_cnt_mtd_vj
	, CASE WHEN d.mtd_store_day_cnt > 0 THEN d.mtd_miss_item_cnt / d.mtd_store_day_cnt ELSE 0 END			AS miss_item_cnt_avg_day_mtd
	, CASE WHEN d.mtd_store_day_cnt_vj > 0 THEN d.mtd_miss_item_cnt_vj / d.mtd_store_day_cnt_vj ELSE 0 END	AS miss_item_cnt_avg_day_mtd_vj
	, miss_item_cnt_avg_day_mtd - miss_item_cnt_avg_day_mtd_vj												AS miss_item_cnt_avg_day_mtd_diff
	, d.ytd_store_day_cnt     + d.mtd_store_day_cnt															AS day_cnt_ytd
	, d.ytd_skipped_cnt       + d.mtd_skipped_cnt															AS skipped_cnt_ytd
	, d.ytd_miss_item_cnt     + d.mtd_miss_item_cnt															AS miss_item_cnt_ytd
	, d.ytd_store_day_cnt_vj  + d.mtd_store_day_cnt_vj														AS day_cnt_ytd_vj
	, d.ytd_skipped_cnt_vj    + d.mtd_skipped_cnt_vj														AS skipped_cnt_ytd_vj
	, d.ytd_miss_item_cnt_vj  + d.mtd_miss_item_cnt_vj														AS miss_item_cnt_ytd_vj
	, CASE WHEN day_cnt_ytd > 0 THEN miss_item_cnt_ytd / day_cnt_ytd ELSE 0 END								AS miss_item_cnt_avg_day_ytd
	, CASE WHEN day_cnt_ytd_vj > 0 THEN miss_item_cnt_ytd_vj / day_cnt_ytd_vj ELSE 0 END					AS miss_item_cnt_avg_day_ytd_vj
	, miss_item_cnt_avg_day_ytd - miss_item_cnt_avg_day_ytd_vj												AS miss_item_cnt_avg_day_ytd_diff
FROM (
	SELECT DISTINCT
		w.client_id
		, w.loc_sid_wh
		, w.move_to_store_id
		, w.wh_id
		, w.orig_store_nr
		, w.item_grp_int_sid
		, w.itemgroup_int_id
		, w.aspect_id
		, w.currency_iso_cd
		, w.curr_tot_id
		, w.cy_week_partial_week_id
		, w.cy_month
		, w.busyear
		, SUM(w.skipped_cnt_wtd     ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS skipped_cnt_wtd
		, SUM(w.day_cnt_wtd         ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS day_cnt_wtd
		, SUM(w.miss_item_cnt_d1    ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d1
		, SUM(w.miss_item_cnt_d2    ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d2
		, SUM(w.miss_item_cnt_d3    ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d3
		, SUM(w.miss_item_cnt_d4    ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d4
		, SUM(w.miss_item_cnt_d5    ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d5
		, SUM(w.miss_item_cnt_d6    ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d6
		, SUM(w.miss_item_cnt_d7    ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d7
		, SUM(w.miss_item_cnt_wtd   ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_wtd
		, SUM(w.day_cnt_wtd_vj)       OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS day_cnt_wtd_vj
		, SUM(w.skipped_cnt_wtd_vj  ) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS skipped_cnt_wtd_vj
		, SUM(w.miss_item_cnt_wtd_vj) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_wtd_vj
		, SUM(COALESCE(mtd_skipped_cnt     ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_skipped_cnt
		, SUM(COALESCE(mtd_miss_item_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_miss_item_cnt
		, SUM(COALESCE(mtd_store_day_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_store_day_cnt
		, SUM(COALESCE(mtd_skipped_cnt_vj  ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_skipped_cnt_vj
		, SUM(COALESCE(mtd_miss_item_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_miss_item_cnt_vj
		, SUM(COALESCE(mtd_store_day_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_store_day_cnt_vj
		, SUM(COALESCE(ytd_skipped_cnt     ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_skipped_cnt
		, SUM(COALESCE(ytd_miss_item_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_miss_item_cnt
		, SUM(COALESCE(ytd_store_day_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_store_day_cnt
		, SUM(COALESCE(ytd_skipped_cnt_vj  ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_skipped_cnt_vj
		, SUM(COALESCE(ytd_miss_item_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_miss_item_cnt_vj
		, SUM(COALESCE(ytd_store_day_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.move_to_store_id, w.aspect_id, w.itemgroup_int_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_store_day_cnt_vj
	FROM (
		SELECT DISTINCT
			client_id
			, loc_sid_wh
			, move_to_store_id
			, wh_id
			, orig_store_nr
			, item_grp_int_sid
			, itemgroup_int_id
			, aspect_id
			, currency_iso_cd
			, curr_tot_id
			, cy_week_partial_week_id
			, cy_month
			, busyear
			, SUM(skipped_fg)                                                                     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS skipped_cnt_wtd
			, SUM(CASE WHEN skipped_fg = 0 AND miss_item_cnt IS NOT NULL THEN 1   ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS day_cnt_wtd
			, SUM(CASE WHEN skipped_fg = 0 AND day_of_week = 1 THEN miss_item_cnt ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d1
			, SUM(CASE WHEN skipped_fg = 0 AND day_of_week = 2 THEN miss_item_cnt ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d2
			, SUM(CASE WHEN skipped_fg = 0 AND day_of_week = 3 THEN miss_item_cnt ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d3
			, SUM(CASE WHEN skipped_fg = 0 AND day_of_week = 4 THEN miss_item_cnt ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d4
			, SUM(CASE WHEN skipped_fg = 0 AND day_of_week = 5 THEN miss_item_cnt ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d5
			, SUM(CASE WHEN skipped_fg = 0 AND day_of_week = 6 THEN miss_item_cnt ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d6
			, SUM(CASE WHEN skipped_fg = 0 AND day_of_week = 7 THEN miss_item_cnt ELSE 0 END)     OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d7
			, SUM(CASE WHEN skipped_fg = 0 THEN miss_item_cnt ELSE 0 END)                         OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_wtd
			, SUM(CASE WHEN skipped_fg_vj_cal = 0 AND miss_item_cnt_vj_cal IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS day_cnt_wtd_vj
			, SUM(skipped_fg_vj_cal)                                                                  OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS skipped_cnt_wtd_vj
			, SUM(CASE WHEN skipped_fg_vj_cal = 0 THEN miss_item_cnt_vj_cal ELSE 0 END)                   OVER (PARTITION BY client_id, wh_id, move_to_store_id, aspect_id, itemgroup_int_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_wtd_vj
			, CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt
			, CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt
			, CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt
			, CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt
			, CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt
			, CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt
			, CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt_vj
		FROM P_LEW_MART_LEAD.v_agg_miss_wgi_store_day_1
		UNION ALL
		SELECT DISTINCT 
			pw.client_id
			, pw.loc_sid_wh
			, pw.move_to_store_id
			, pw.wh_id
			, pw.orig_store_nr
			, pw.item_grp_int_sid
			, pw.itemgroup_int_id
			, pw.aspect_id
			, pw.currency_iso_cd
			, pw.curr_tot_id
			, cal.cy_week_partial_week_id
			, pw.cy_month
			, pw.busyear
			, CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd
			, CAST(NULL AS NUMBER(38,0))   AS day_cnt_wtd
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d1
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d2
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d3
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d4
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d5
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d6
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d7
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd
			, CAST(NULL AS NUMBER(38,0))   AS day_cnt_wtd_vj
			, CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd_vj
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd_vj
			, SUM(COALESCE(pw.skipped_cnt,0))      OVER (PARTITION BY pw.client_id, pw.wh_id, pw.move_to_store_id, pw.aspect_id, pw.itemgroup_int_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_skipped_cnt
			, SUM(COALESCE(pw.miss_item_cnt,0))    OVER (PARTITION BY pw.client_id, pw.wh_id, pw.move_to_store_id, pw.aspect_id, pw.itemgroup_int_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_miss_item_cnt
			, SUM(COALESCE(pw.day_cnt,0))          OVER (PARTITION BY pw.client_id, pw.wh_id, pw.move_to_store_id, pw.aspect_id, pw.itemgroup_int_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_store_day_cnt
			, SUM(COALESCE(pw.skipped_cnt_vj,0))   OVER (PARTITION BY pw.client_id, pw.wh_id, pw.move_to_store_id, pw.aspect_id, pw.itemgroup_int_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_skipped_cnt_vj
			, SUM(COALESCE(pw.miss_item_cnt_vj,0)) OVER (PARTITION BY pw.client_id, pw.wh_id, pw.move_to_store_id, pw.aspect_id, pw.itemgroup_int_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_miss_item_cnt_vj
			, SUM(COALESCE(pw.day_cnt_vj,0))       OVER (PARTITION BY pw.client_id, pw.wh_id, pw.move_to_store_id, pw.aspect_id, pw.itemgroup_int_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_store_day_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt
			, CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt
			, CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt
			, CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt_vj
		FROM P_LEW_MART_LEAD.v_agg_miss_wgi_store_partial_week_1 AS pw
			INNER JOIN P_LEW_BIL_AC.v_cal_week_partial_week_1 AS cal
				ON pw.busyear = cal.busyear
					AND pw.cy_month = cal.cy_month
					AND pw.cy_week_partial_week_id <= cal.cy_week_partial_week_id
		UNION ALL
		SELECT DISTINCT 
			m.client_id
			, m.loc_sid_wh
			, m.move_to_store_id
			, m.wh_id
			, m.orig_store_nr
			, m.item_grp_int_sid
			, m.itemgroup_int_id
			, m.aspect_id
			, m.currency_iso_cd
			, m.curr_tot_id
			, cal.cy_week_partial_week_id
			, cal.cy_month
			, m.busyear
			, CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd
			, CAST(NULL AS NUMBER(38,0))   AS day_cnt_wtd
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d1
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d2
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d3
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d4
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d5
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d6
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d7
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd
			, CAST(NULL AS NUMBER(38,0))   AS day_cnt_wtd_vj
			, CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd_vj
			, CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd_vj
			, CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt
			, CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt
			, CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt
			, CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt_vj
			, CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt_vj
			, SUM(COALESCE(m.skipped_cnt,0))      OVER (PARTITION BY m.client_id, m.wh_id, m.move_to_store_id, m.aspect_id, m.itemgroup_int_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_skipped_cnt
			, SUM(COALESCE(m.miss_item_cnt,0))    OVER (PARTITION BY m.client_id, m.wh_id, m.move_to_store_id, m.aspect_id, m.itemgroup_int_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_miss_item_cnt
			, SUM(COALESCE(m.day_cnt,0))          OVER (PARTITION BY m.client_id, m.wh_id, m.move_to_store_id, m.aspect_id, m.itemgroup_int_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_store_day_cnt
			, SUM(COALESCE(m.skipped_cnt_vj,0))   OVER (PARTITION BY m.client_id, m.wh_id, m.move_to_store_id, m.aspect_id, m.itemgroup_int_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_skipped_cnt_vj
			, SUM(COALESCE(m.miss_item_cnt_vj,0)) OVER (PARTITION BY m.client_id, m.wh_id, m.move_to_store_id, m.aspect_id, m.itemgroup_int_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_miss_item_cnt_vj
			, SUM(COALESCE(m.day_cnt_vj,0))       OVER (PARTITION BY m.client_id, m.wh_id, m.move_to_store_id, m.aspect_id, m.itemgroup_int_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_store_day_cnt_vj
		FROM P_LEW_BIL_AC.v_cal_week_partial_week_1 AS cal
			INNER JOIN  P_LEW_MART_LEAD.v_agg_miss_wgi_store_mth_1 AS m
				ON m.busyear = cal.busyear
                     AND m.cy_month < cal.cy_month
		) AS w
	) AS d
;