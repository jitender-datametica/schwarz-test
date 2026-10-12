CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_FLOP10_CAL_LIST_DAY_1
AS
 /**************************************************************************
 * Created by Jens Thole
 * on 17.07.2018
 * Inhalt: Ausschnitt aus Kalender - speziell für bo_flop10; tagesgranular: t_cal_calendarday_1
 * ausgehend von der Grundauswahl für das Tage-, Wochen-, und Monatsreporting wird die Gesamtmenge an Reportingtagen aus dem Kalender geschnitten.
 * Für die jeweiligen zeitlichen Reportingtypen werden Flags gebildet
 * Daily:     Datenauswahlbereich: alle Tage der Vorwoche und der aktuellen Woche_1
 * Weekly:  CurrentYear-Zeitbereich: [Woche_1 -4, Woche_1 0]
 *            PreviousYear-Zeitbereich: [Woche_1 -4, Woche_1 +5] 52 Wochen ins Vorjahr versetzt
 * Monthly: Datenauswahlbereich: alle Tage des Vormonats und des aktuellen Monats
 **************************************************************************/
SELECT
cal.cal_dt,

--cast(cal.cal_dt as INTEGER) cal_dt_int,
to_number(to_char(cal.cal_dt,'YYYYMMDD')) cal_dt_int,

cal.cy_week,
cal.cy_month,
cal.cy_week_seq,
cal.cy_month_seq,
CASE WHEN cal.cy_week_seq BETWEEN -1 AND 0 THEN 1 ELSE 0 END                                          AS day_range_fg,
CASE WHEN cal.cy_week_seq BETWEEN -4 AND 0
                  OR cal.cy_week_seq BETWEEN -4 - 52 AND 5 - 52 THEN 1 ELSE 0 END                          AS week_range_fg,
CASE WHEN cal.cy_month_seq BETWEEN -1 AND 0 THEN 1 ELSE 0 END                                         AS month_range_fg
FROM p_lew_core_ac.v_cal_calendarday_1 cal
WHERE cy_week_seq BETWEEN -4 AND 0
 OR cy_week_seq BETWEEN -4 - 52 AND 5 - 52
 or cy_month_seq BETWEEN -1 AND 0
;




