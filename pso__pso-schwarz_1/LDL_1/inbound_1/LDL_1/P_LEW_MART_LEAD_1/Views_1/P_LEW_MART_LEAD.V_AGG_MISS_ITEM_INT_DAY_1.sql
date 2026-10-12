/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country_1/day.
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_lead.v_agg_miss_item_int_day_1 COMMENT = 'Anzahl der Fehlartikel pro Land_1/Tag_1'
(
  client_id                    COMMENT 'MIS Client ID'
, dat_formdate                 COMMENT 'Bezugsdatum'
, day_of_week                  COMMENT 'Tag_1 der Woche_1'
, cy_month                     COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, cy_week_partial_week_id      COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_week                      COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                      COMMENT 'Geschäftsjahr'
, aspect_id                    COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd              COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                  COMMENT 'Interner Währungs-Code'
, store_cnt                    COMMENT 'Anzahl der Filiale'
, miss_item_cnt                COMMENT 'Anzahl der Fehlartikel über allen Filialen der Gesellschaft'
, skipped_cnt                  COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_avg_day        COMMENT 'Durchschnittliche Fehlartikeltageswert pro Filiale'
, cal_dt_swday_prev_1y         COMMENT 'Datum des Vorjahres (gleiche Wochentag)'
, cy_week_vj                   COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - von Vorjahr'
, cy_month_vj                  COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'
, busyear_vj                   COMMENT 'Geschäftsjahr - von Vorjahr'
, store_cnt_vj                 COMMENT 'Anzahl der Filiale aus dem Vorjahr'
, miss_item_cnt_vj             COMMENT 'Anzahl der Fehlartikel vom Vorjahr'
, skipped_cnt_vj               COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_avg_day_vj     COMMENT 'Fehlartikel Durchschnittswert pro Filiale/Tag_1 - aus dem Vorjahr'
, miss_item_cnt_diff           COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff       COMMENT 'Aktuelle Durchschnittswert (Filale/Tag_1) minus Durchschnittswert (Filale/Tag_1) aus dem Vorjahr'
, miss_item_avg_day_diff_delta COMMENT 'Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'
)
AS
SELECT   
	client_id
	, dat_formdate
	, day_of_week
	, cy_month
	, cy_week_partial_week_id
	, cy_week
	, busyear
	, aspect_id
	, CAST(currency_iso_cd AS VARCHAR(3)) AS currency_iso_cd
	, curr_tot_id
	, store_cnt
	, miss_item_cnt
	, skipped_cnt
	, CASE WHEN store_cnt > 0 THEN (miss_item_cnt / store_cnt) ELSE 0 END AS miss_item_cnt_avg_day
	, cal_dt_vj_cal
	, cy_week_vj_cal
	, cy_month_vj_cal
	, busyear_vj_cal
	, store_cnt_vj_cal
	, miss_item_cnt_vj_cal
	, skipped_cnt_vj_cal
	, CASE WHEN store_cnt_vj_cal > 0 THEN (miss_item_cnt_vj_cal / store_cnt_vj_cal) ELSE 0 END AS miss_item_cnt_avg_day_vj
	, (miss_item_cnt - miss_item_cnt_vj_cal) AS miss_item_cnt_diff
	, (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj) AS miss_item_avg_day_diff
	, CASE WHEN miss_item_cnt_vj_cal > 0 THEN (miss_item_cnt_diff / miss_item_cnt_vj_cal * 100) ELSE 0 END AS miss_item_diff_delta
FROM (
	SELECT DISTINCT 
		client_id
		, dat_formdate
		, day_of_week
		, cy_month
		, cy_week_partial_week_id
		, cy_week
		, busyear
		, aspect_id
		, currency_iso_cd
		, curr_tot_id
		, SUM(CASE WHEN miss_item_cnt IS NOT NULL AND skipped_fg = 0 THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS store_cnt
		, SUM(CASE WHEN skipped_fg = 0 THEN miss_item_cnt ELSE 0 END) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS miss_item_cnt
		, SUM(skipped_fg) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS skipped_cnt
		, MAX(cal_dt_vj_cal) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS cal_dt_vj_cal
		, MAX(cy_week_vj_cal) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS cy_week_vj_cal
		, MAX(cy_month_vj_cal) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS cy_month_vj_cal
		, MAX(busyear_vj_cal) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS busyear_vj_cal
		, SUM(CASE WHEN miss_item_cnt_vj_cal IS NOT NULL AND skipped_fg_vj_cal = 0 THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS store_cnt_vj_cal
		, SUM(CASE WHEN skipped_fg_vj_cal = 0 THEN miss_item_cnt_vj_cal ELSE 0 END) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS miss_item_cnt_vj_cal
		, SUM(skipped_fg_vj_cal) OVER (PARTITION BY client_id, aspect_id, dat_formdate, curr_tot_id) AS skipped_cnt_vj_cal
	FROM p_lew_mart_lead.v_agg_miss_item_store_day_1
    ) AS whd
;