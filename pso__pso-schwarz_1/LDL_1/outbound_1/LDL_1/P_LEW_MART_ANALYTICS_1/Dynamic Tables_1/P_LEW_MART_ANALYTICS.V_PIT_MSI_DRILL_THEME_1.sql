CREATE OR REPLACE TABLE ldl_p_lew_mart_analytics.v_pit_msi_drill_theme_1 AS
/* PIT-70.20 Werbethema Artikel_1  52F115D2432F5057FF6E6BB894CA2929 */ /* E Werbewoche = ?! */ /* E Werbethema = ?! */
/* PIT-70.10 Werbethema Werbewochen */ /* E Werbewoche = ?! */ /* E Werbethema = ?! */ SELECT BASE.client_id,
 BASE.adv_week_id,
 BASE.adv_week_sid,
 BASE.adv_theme_sid,
 BASE.adv_theme_mstr_sid,
 1 AS rowcnt,
  CASE
  WHEN BASE.advert_items_cnt > 0 AND BASE.adv_theme_mstr_sid >= 0
  THEN /* Color code # Regular grey medium light */ pa.pa01_value ||
                    '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r ' || ' Werbewoche ' || adw.adv_week_long_descr
                   || ' und Thema: ' || TRIM(REPLACE(REPLACE(REPLACE(REPLACE(TH.advert_theme, 'ü', '&uuml;'), 'ä',
                    '&auml;'), 'ö', '&ouml;'), '""', '&apos;')) || '"" HREF=""mstrWeb' /* ? */ || CHR(63) ||
             'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa36_value || '&elementsPromptAnswers='
           /* E  Land_1 ( Basic ) = ?! */ || CASE
           WHEN pa.pa06_value IS NOT NULL
           THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa08_value IS NOT NULL
          THEN pa.pa08_value || CAST(CAST((COALESCE(BASE.adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
             STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa34_value IS NOT NULL
         THEN pa.pa34_value || CAST(BASE.adv_theme_mstr_sid AS STRING)
         ELSE NULL
         END || '"" ' || pa.pa26_value || '> ' || pa.pa02_value || '</a></span>'
  ELSE NULL
  END AS drill_to_theme_item_link_html,
  CASE
  WHEN BASE.advert_items_cnt > 0 AND BASE.adv_theme_mstr_sid >= 0
  THEN /* Color code #00A3E4 Regular blue */ pa.pa01_value ||
                    '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r ' || ' f&uuml;r alle Werbewochen ab ' ||
                  adw.adv_week_long_descr || ' und Werbethema ' || TRIM(REPLACE(REPLACE(REPLACE(REPLACE(TH.advert_theme
                     , 'ü', '&uuml;'), 'ä', '&auml;'), 'ö', '&ouml;'), '""', '&apos;')) || '"" HREF=""mstrWeb' /* ? */
              || CHR(63) || 'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa35_value || '&elementsPromptAnswers='
           /* E  Land_1 ( Basic ) = ?! */ || CASE
           WHEN pa.pa06_value IS NOT NULL
           THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa08_value IS NOT NULL
          THEN pa.pa08_value || CAST(CAST((COALESCE(BASE.adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
             STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa34_value IS NOT NULL
         THEN pa.pa34_value || CAST(BASE.adv_theme_mstr_sid AS STRING)
         ELSE NULL
         END || '"" ' || pa.pa26_value || '> ' || pa.pa15_value || '</a></span>'
  ELSE NULL
  END AS drill_to_theme_h_link_html
FROM ldl_p_lew_mart_analytics.v_pit_base_theme_all_1 AS BASE
 INNER JOIN ldl_p_lew_mart_analytics.v_pit_advert_theme_1 AS TH ON BASE.adv_theme_sid = TH.adv_theme_sid AND BASE.client_id
    = TH.client_id
 INNER JOIN (SELECT client_id,
   adv_week_id,
   adv_week_descr,
     SUBSTR(CAST(adv_week_week_num /* Warning, Format '99' removed, semantic information not found. */ AS STRING), 1, 2
      ) || '/' || SUBSTR(CAST(adv_week_year_num AS STRING), 1, 4) AS adv_week_long_descr,
   adv_week_year_num,
   adv_week_week_num
  FROM ldl_p_lew_mart_analytics.t_advert_week_1) AS adw ON BASE.adv_week_id = adw.adv_week_id AND BASE.client_id = adw.client_id
   
 INNER JOIN (SELECT MAX(CASE
     WHEN param_id = 1
     THEN COALESCE(param_value, '<!-- ERROR SPAN Tag_1 -->')
     ELSE NULL
     END) AS pa01_value,
   MAX(CASE
     WHEN param_id = 2
     THEN COALESCE(param_value, '<!-- ERROR IMG Tag_1  -->')
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
     THEN COALESCE(param_value, '<!-- ERROR IMG Tag_1  -->')
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
     THEN param_value
     ELSE NULL
     END) AS pa27_value,
   MAX(CASE
     WHEN param_id = 28
     THEN param_value
     ELSE NULL
     END) AS pa28_value,
   MAX(CASE
     WHEN param_id = 29
     THEN param_value
     ELSE NULL
     END) AS pa29_value,
   MAX(CASE
     WHEN param_id = 30
     THEN param_value
     ELSE NULL
     END) AS pa30_value,
   MAX(CASE
     WHEN param_id = 31
     THEN param_value
     ELSE NULL
     END) AS pa31_value,
   MAX(CASE
     WHEN param_id = 32
     THEN param_value
     ELSE NULL
     END) AS pa32_value,
   MAX(CASE
     WHEN param_id = 33
     THEN param_value
     ELSE NULL
     END) AS pa33_value,
   MAX(CASE
     WHEN param_id = 34
     THEN param_value
     ELSE NULL
     END) AS pa34_value,
   MAX(CASE
     WHEN param_id = 35
     THEN param_value
     ELSE NULL
     END) AS pa35_value,
   MAX(CASE
     WHEN param_id = 36
     THEN param_value
     ELSE NULL
     END) AS pa36_value
  FROM ldl_p_lew_mart_analytics.v_pit_param_1) AS pa ON TRUE;