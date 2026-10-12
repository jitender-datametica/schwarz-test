/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/product group/partial week.
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     17.08.2022      Michael Morris             Comparison with previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_WGI_STORE_PARTIAL_WEEK_1 COMMENT = 'Counts the missing items per store/product group/partial week'
(
  client_id                      COMMENT 'MIS Client ID'
, loc_sid_wh                     COMMENT 'S-Key der Gesellschaft'
, move_to_store_id               COMMENT 'S-Key der Location_1, hier der Filiale'
, wh_id                          COMMENT 'Gesellschaft ID'
, orig_store_nr                  COMMENT 'Store ID'
, item_grp_int_sid               COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id               COMMENT 'Warengruppe ID'
, aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                    COMMENT 'Interner Währungs-Code'
, cy_week_partial_week_id        COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                       COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                        COMMENT 'Geschäftsjahr'
, day_cnt                        COMMENT 'Anzahl der öffenen Tage des Monats'
, skipped_cnt                    COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt                  COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_avg_day          COMMENT 'Durchschnittliche Fehlartikeltageswert'
, day_cnt_vj                     COMMENT 'Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'
, skipped_cnt_vj                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'
, miss_item_cnt_vj               COMMENT 'Anzahl der Fehlartikeln innerhalb des Monats'
, miss_item_cnt_avg_day_vj       COMMENT 'Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'
, miss_item_cnt_diff             COMMENT 'Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'
, miss_item_avg_day_diff         COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'
, miss_item_avg_day_diff_delta   COMMENT 'Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'
)
AS
SELECT   
	client_id
	, loc_sid_wh
	, move_to_store_id
	, wh_id
	, orig_store_nr
	, item_grp_int_sid 
	, itemgroup_int_id 
	, aspect_id
	, CAST(currency_iso_cd AS VARCHAR(3)) AS currency_iso_cd
	, curr_tot_id
	, cy_week_partial_week_id
	, cy_month
	, busyear
	, day_cnt
	, skipped_cnt
	, miss_item_cnt
	, CASE WHEN day_cnt > 0 THEN (miss_item_cnt / day_cnt) ELSE 0 END AS miss_item_cnt_avg_day
	, day_cnt_vj
	, skipped_cnt_vj_cal
	, miss_item_cnt_vj_cal
	, CASE WHEN day_cnt_vj > 0 THEN (miss_item_cnt_vj_cal / day_cnt_vj) ELSE 0 END AS miss_item_cnt_avg_day_vj
	, (miss_item_cnt - miss_item_cnt_vj_cal) AS miss_item_cnt_diff
	, (miss_item_cnt_avg_day - miss_item_cnt_avg_day_vj) AS miss_item_avg_day_diff
	, CASE WHEN miss_item_cnt_avg_day_vj > 0 THEN (miss_item_avg_day_diff / miss_item_cnt_avg_day_vj * 100 ) ELSE 0 END AS miss_item_avg_day_diff_delta
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
		, SUM(skipped_fg) OVER (PARTITION BY client_id, wh_id, move_to_store_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, curr_tot_id) AS skipped_cnt
		, SUM(CASE WHEN skipped_fg = 0 AND miss_item_cnt IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, wh_id, move_to_store_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, curr_tot_id) AS day_cnt
		, SUM(CASE WHEN skipped_fg = 0 THEN miss_item_cnt ELSE 0 END) OVER (PARTITION BY client_id, wh_id, move_to_store_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt
		, SUM(CASE WHEN skipped_fg_vj_cal = 0 AND miss_item_cnt_vj_cal IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, wh_id, move_to_store_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, curr_tot_id) AS day_cnt_vj
		, SUM(skipped_fg_vj_cal) OVER (PARTITION BY client_id, wh_id, move_to_store_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, curr_tot_id) AS skipped_cnt_vj_cal
		, SUM(CASE WHEN skipped_fg_vj_cal = 0 THEN miss_item_cnt_vj_cal ELSE 0 END) OVER (PARTITION BY client_id, wh_id, move_to_store_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_vj_cal
	FROM p_lew_mart_lead.v_agg_miss_wgi_store_day_1
	) AS w
;