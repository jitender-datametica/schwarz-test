
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_MSI_DRILL_ALL_ITEM_2
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     base.client_id,
   base.item_sid,
   base.item_mstr_sid,
   base.adv_week_sid,
   base.adv_week_rltd_sid,
   base._count,
   CASE WHEN base.item_sid <> -2  THEN
   -- Color code # Regular grey medium light
           --base.pa07_value
           base.pa27_value
           || '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r '
           || ' Artikel_2: <'
           || base.orig_item_nr || ' - '
           -- AKU 20190513 Replace "" by &quot;
           || TRIM(REPLACE(REPLACE(REPLACE(REPLACE(base.item_descr_int,'ü','&uuml;'),'ä','&auml;'),'ö','&ouml;'),'""','&apos;'))
   || '> &uuml;ber alle Werbewochen'
   || '"" HREF=""mstrWeb'
   -- ?
   || CHR(63)
   --PIT-40.01 Artikel_2 Werbewochen
   || 'evt=2048001&src=mstrWeb.2048001&documentID='
   || base.pa16_value
   || '&elementsPromptAnswers='
   -- E  Land_2 ( Basic ) = ?!
   || CASE WHEN base.pa06_value IS NOT NULL THEN
       base.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
      ELSE NULL END
   -- E Artikel_2 = ?!
   || CASE WHEN base.pa17_value IS NOT NULL THEN
       base.pa17_value || -- CAST( base.item_sid AS VARCHAR(12))
   CAST( base.item_mstr_sid AS VARCHAR(12)) || ','
   ELSE NULL END
-- E Werbewoche = ?!
|| CASE WHEN base.pa08_value IS NOT NULL THEN
    base.pa08_value || CAST( base.adv_week_sid  AS VARCHAR(12)) ||  ','
   ELSE NULL END
-- E Vergleichswerbewoche = ?!
|| CASE WHEN base.pa09_value IS NOT NULL THEN
    base.pa09_value || CAST( base.adv_week_rltd_sid AS VARCHAR(12))
   ELSE NULL END
|| '"" '
|| base.pa26_value
|| '> '
|| base.pa15_value
|| '</a></span>'
ELSE
NULL
END
AS drill_to_all_items_link_html
FROM
(
SELECT DISTINCT
base.client_id,
   base.item_sid,
   base.adv_week_id,
   adw.adv_week_sid,
   adw.adv_week_rltd_id,
   adw.adv_week_rltd_sid,
   CAST( COALESCE(base.item_sid, -1) *100 + base.client_id AS INTEGER ) AS item_mstr_sid,
   CAST(1 AS INTEGER) AS _count,
   itm.orig_item_nr,
   itm.item_descr_int,
   pa.pa01_value,
   pa.pa02_value,
   pa.pa03_value,
   pa.pa04_value,
   pa.pa05_value,
   pa.pa06_value,
   pa.pa07_value,
   pa.pa08_value,
   pa.pa09_value,
   pa.pa10_value,
   pa.pa11_value,
   pa.pa12_value,
   pa.pa13_value,
   pa.pa14_value,
   pa.pa15_value,
   pa.pa16_value,
   pa.pa17_value,
   pa.pa18_value,
   pa.pa19_value,
   pa.pa20_value,
   pa.pa21_value,
   pa.pa22_value,
   pa.pa23_value,
   pa.pa24_value,
   pa.pa25_value,
   pa.pa26_value,
   pa.pa27_value
      FROM p_lew_mart_analytics.v_pit_base_period_item_2 AS base
   INNER JOIN p_lew_mart_analytics.v_pit_item_2 AS  itm
   ON  base.item_sid   = itm.item_sid
   AND base.client_id  = itm.client_id
   INNER JOIN
   (
       SELECT
         adw.adv_week_id,
   adw.client_id,
   CAST( (adw.adv_week_id * 100) + adw.client_id AS INTEGER) AS adv_week_sid,
   adw_rltd.adv_week_id AS adv_week_rltd_id,
   CAST( (adw_rltd.adv_week_id * 100) + adw_rltd.client_id AS INTEGER) AS adv_week_rltd_sid
          FROM p_lew_mart_analytics.v_pit_adv_week_2 AS adw
   INNER JOIN p_lew_mart_analytics.v_pit_adv_week_2 AS adw_rltd
   ON adw.client_id      = adw_rltd.client_id
   AND adw.adv_week_seq  = adw_rltd.adv_week_seq + 1
) AS adw
   ON  base.adv_week_id = adw.adv_week_id
   AND base.client_id   = adw.client_id
   CROSS JOIN
   (
       SELECT
         MAX(CASE WHEN param_id =  1 THEN COALESCE(param_value,'<!-- ERROR SPAN Tag_2 -->') END)          AS pa01_value,
   MAX(CASE WHEN param_id =  2 THEN COALESCE(param_value,'<!-- ERROR IMG Tag_2  -->') END)          AS pa02_value,
   MAX(CASE WHEN param_id =  3 THEN COALESCE(param_value,'<!-- ERROR Target Attribute -->') END)  AS pa03_value,
   MAX(CASE WHEN param_id =  4 THEN param_value END)                                              AS pa04_value,
   MAX(CASE WHEN param_id =  5 THEN param_value END)                                              AS pa05_value,
   MAX(CASE WHEN param_id =  6 THEN param_value END)                                              AS pa06_value,
   MAX(CASE WHEN param_id =  7 THEN COALESCE(param_value,'N/a')END)                               AS pa07_value,
   MAX(CASE WHEN param_id =  8 THEN param_value END)                                              AS pa08_value,
   MAX(CASE WHEN param_id =  9 THEN param_value END)                                              AS pa09_value,
   MAX(CASE WHEN param_id = 10 THEN param_value END)                                              AS pa10_value,
   MAX(CASE WHEN param_id = 11 THEN param_value END)                                              AS pa11_value,
   MAX(CASE WHEN param_id = 12 THEN COALESCE(param_value,'N/a') END)                              AS pa12_value,
   MAX(CASE WHEN param_id = 13 THEN param_value END)                                              AS pa13_value,
   MAX(CASE WHEN param_id = 14 THEN param_value END)                                              AS pa14_value,
   MAX(CASE WHEN param_id = 15 THEN COALESCE(param_value,'<!-- ERROR IMG Tag_2  -->') END)          AS pa15_value,
   MAX(CASE WHEN param_id = 16 THEN param_value END)                                              AS pa16_value,
   MAX(CASE WHEN param_id = 17 THEN param_value END)                                              AS pa17_value,
   MAX(CASE WHEN param_id = 18 THEN param_value END)                                              AS pa18_value,
   MAX(CASE WHEN param_id = 19 THEN param_value END)                                              AS pa19_value,
   MAX(CASE WHEN param_id = 20 THEN param_value END)                                              AS pa20_value,
   MAX(CASE WHEN param_id = 21 THEN param_value END)                                              AS pa21_value,
   MAX(CASE WHEN param_id = 22 THEN param_value END)                                              AS pa22_value,
   MAX(CASE WHEN param_id = 23 THEN param_value END)                                              AS pa23_value,
   MAX(CASE WHEN param_id = 24 THEN param_value END)                                              AS pa24_value,
   MAX(CASE WHEN param_id = 25 THEN param_value END)                                              AS pa25_value,
   MAX(CASE WHEN param_id = 26 THEN param_value END)                                              AS pa26_value,
   MAX(CASE WHEN param_id = 27 THEN COALESCE(param_value,'<!-- ERROR SPAN Tag_2 CALENDAR_2 -->') END) AS pa27_value
          FROM p_lew_mart_analytics.v_pit_param_2
      ) AS pa
  ) AS base;
