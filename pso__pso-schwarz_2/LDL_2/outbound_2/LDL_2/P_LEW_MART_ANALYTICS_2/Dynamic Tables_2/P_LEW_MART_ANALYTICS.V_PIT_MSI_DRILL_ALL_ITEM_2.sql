

CREATE TABLE IF NOT EXISTS  ldl_p_lew_mart_analytics.v_pit_msi_drill_all_item_2
 AS
-- PIT-40.01 Artikel_2 Werbewochen
 -- E Artikel_2 = ?!
 -- CAST( base.item_sid AS STRING(12))
 -- E Werbewoche = ?!

-- E Vergleichswerbewoche = ?!
 SELECT client_id,
 item_sid,
 item_mstr_sid,
 adv_week_sid,
 adv_week_rltd_sid,
 `_count`,
  CASE
  WHEN item_sid <> - 2
  THEN -- base.pa07_value
 -- Color code # Regular grey medium light
 pa27_value ||
                      '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r ' || ' Artikel_2: <' || orig_item_nr ||
                   ' - ' -- AKU 20190513 Replace "" by &quot;
 || TRIM(REPLACE(REPLACE(REPLACE(REPLACE(item_descr_int,
                       'ü', '&uuml;'), 'ä', '&auml;'), 'ö', '&ouml;'), '""', '&apos;')) ||
                 '> &uuml;ber alle Werbewochen' || '"" HREF=""mstrWeb' -- ?
 || CHR(63) ||
              'evt=2048001&src=mstrWeb.2048001&documentID=' || pa16_value || '&elementsPromptAnswers='
            -- E  Land_2 ( Basic ) = ?!
 || CASE
            WHEN pa06_value IS NOT NULL
            THEN pa06_value || CAST(client_id AS STRING) || ','
            ELSE NULL
            END || CASE
           WHEN pa17_value IS NOT NULL
           THEN pa17_value || CAST(item_mstr_sid AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa08_value IS NOT NULL
          THEN pa08_value || CAST(adv_week_sid AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa09_value IS NOT NULL
         THEN pa09_value || CAST(adv_week_rltd_sid AS STRING)
         ELSE NULL
         END || '"" ' || pa26_value || '> ' || pa15_value || '</a></span>'
  ELSE NULL
  END AS drill_to_all_items_link_html
FROM (SELECT DISTINCT BASE.client_id,
   BASE.item_sid,
   BASE.adv_week_id,
   adw.adv_week_sid,
   adw.adv_week_rltd_id,
   adw.adv_week_rltd_sid,
   CAST(COALESCE(BASE.item_sid, - 1) * 100 + BASE.client_id AS BIGNUMERIC) AS item_mstr_sid,
   1 AS `_count`,
   ITM.orig_item_nr,
   ITM.item_descr_int,
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
  FROM ldl_p_lew_mart_analytics.v_pit_base_period_item_2 AS BASE
   INNER JOIN ldl_p_lew_mart_analytics.v_pit_item_2 AS ITM ON BASE.item_sid = ITM.item_sid AND BASE.client_id = ITM.client_id
     
   INNER JOIN (SELECT ADW.adv_week_id,
     ADW.client_id,
     CAST(ADW.adv_week_id * 100 + ADW.client_id AS BIGNUMERIC) AS adv_week_sid,
     ADW_RLTD.adv_week_id AS adv_week_rltd_id,
     CAST(ADW_RLTD.adv_week_id * 100 + ADW_RLTD.client_id AS BIGNUMERIC) AS adv_week_rltd_sid
    FROM ldl_p_lew_mart_analytics.v_pit_adv_week_2 AS ADW
     INNER JOIN ldl_p_lew_mart_analytics.v_pit_adv_week_2 AS ADW_RLTD ON ADW.client_id = ADW_RLTD.client_id AND ADW.adv_week_seq
        = ADW_RLTD.adv_week_seq + 1) AS adw ON BASE.adv_week_id = adw.adv_week_id AND BASE.client_id = adw.client_id
   INNER JOIN (SELECT MAX(CASE
       WHEN param_id = 1
       THEN COALESCE(param_value, '<!-- ERROR SPAN Tag_2 -->')
       ELSE NULL
       END) AS pa01_value,
     MAX(CASE
       WHEN param_id = 2
       THEN COALESCE(param_value, '<!-- ERROR IMG Tag_2  -->')
       ELSE NULL
       END) AS pa02_value,
     MAX(CASE
       WHEN param_id = 3
       THEN COALESCE(param_value, '<!-- ERROR Target Attribute -->')
       ELSE NULL
       END) AS pa03_value,
     MAX(CASE
       WHEN param_id = 4
       THEN param_value
       ELSE NULL
       END) AS pa04_value,
     MAX(CASE
       WHEN param_id = 5
       THEN param_value
       ELSE NULL
       END) AS pa05_value,
     MAX(CASE
       WHEN param_id = 6
       THEN param_value
       ELSE NULL
       END) AS pa06_value,
     MAX(CASE
       WHEN param_id = 7
       THEN COALESCE(param_value, 'N/a')
       ELSE NULL
       END) AS pa07_value,
     MAX(CASE
       WHEN param_id = 8
       THEN param_value
       ELSE NULL
       END) AS pa08_value,
     MAX(CASE
       WHEN param_id = 9
       THEN param_value
       ELSE NULL
       END) AS pa09_value,
     MAX(CASE
       WHEN param_id = 10
       THEN param_value
       ELSE NULL
       END) AS pa10_value,
     MAX(CASE
       WHEN param_id = 11
       THEN param_value
       ELSE NULL
       END) AS pa11_value,
     MAX(CASE
       WHEN param_id = 12
       THEN COALESCE(param_value, 'N/a')
       ELSE NULL
       END) AS pa12_value,
     MAX(CASE
       WHEN param_id = 13
       THEN param_value
       ELSE NULL
       END) AS pa13_value,
     MAX(CASE
       WHEN param_id = 14
       THEN param_value
       ELSE NULL
       END) AS pa14_value,
     MAX(CASE
       WHEN param_id = 15
       THEN COALESCE(param_value, '<!-- ERROR IMG Tag_2  -->')
       ELSE NULL
       END) AS pa15_value,
     MAX(CASE
       WHEN param_id = 16
       THEN param_value
       ELSE NULL
       END) AS pa16_value,
     MAX(CASE
       WHEN param_id = 17
       THEN param_value
       ELSE NULL
       END) AS pa17_value,
     MAX(CASE
       WHEN param_id = 18
       THEN param_value
       ELSE NULL
       END) AS pa18_value,
     MAX(CASE
       WHEN param_id = 19
       THEN param_value
       ELSE NULL
       END) AS pa19_value,
     MAX(CASE
       WHEN param_id = 20
       THEN param_value
       ELSE NULL
       END) AS pa20_value,
     MAX(CASE
       WHEN param_id = 21
       THEN param_value
       ELSE NULL
       END) AS pa21_value,
     MAX(CASE
       WHEN param_id = 22
       THEN param_value
       ELSE NULL
       END) AS pa22_value,
     MAX(CASE
       WHEN param_id = 23
       THEN param_value
       ELSE NULL
       END) AS pa23_value,
     MAX(CASE
       WHEN param_id = 24
       THEN param_value
       ELSE NULL
       END) AS pa24_value,
     MAX(CASE
       WHEN param_id = 25
       THEN param_value
       ELSE NULL
       END) AS pa25_value,
     MAX(CASE
       WHEN param_id = 26
       THEN param_value
       ELSE NULL
       END) AS pa26_value,
     MAX(CASE
       WHEN param_id = 27
       THEN COALESCE(param_value, '<!-- ERROR SPAN Tag_2 CALENDAR_2 -->')
       ELSE NULL
       END) AS pa27_value
    FROM ldl_p_lew_mart_analytics.v_pit_param_2) AS pa ON TRUE) AS base;


