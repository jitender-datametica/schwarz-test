CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_msi_drill_uwg_1 AS
/* Drill from WGI Warengruppe International  ( Kategorie )  to UWG Unterwarengruppe */
/* PIT-30.01 Kategorien UWG    E70B30FA47D3B01BD03314AE9C0CBD72 */ /* E Werbewoche = ?! */
/* E Vergleichswerbewoche = ?! */ /* E Warengruppe International = ?! */
/* PIT-30.01 Kategorien UWG    E70B30FA47D3B01BD03314AE9C0CBD72 */ /* E Werbewoche = ?! */
/* E Vergleichswerbewoche = ?! */ /* E Warengruppe International = ?! */ SELECT BASE.client_id,
 BASE.adv_week_id,
 CAST(BASE.adv_week_id * 100 + BASE.client_id AS BIGNUMERIC) AS adv_week_sid,
 BASE.rltd_adv_week_id,
 CAST(COALESCE(BASE.rltd_adv_week_id, - 1) * 100 + BASE.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 BASE.item_grp_int_sid,
 CAST(COALESCE(BASE.item_grp_int_sid, - 1) * 100 + BASE.client_id AS BIGNUMERIC) AS item_grp_int_mstr_sid,
 1 AS `_count`,
  CASE
  WHEN BASE.item_grp_int_sid <> - 2
  THEN /* Color code #00A3E4 Regular blue */ pa.pa01_value || '<a style="color:#ffffff" title="Detailanzeige für ' ||
                      ' für Werbewoche ' || ADW.adv_week_descr || ' und für Vergleichswoche ' || RLTD_ADW.adv_week_descr
                    || ' und Kategorie: ' || TRIM(REPLACE(REPLACE(REPLACE(REPLACE(IGI.item_grp_int_descr_int, 'ü',
                      '&uuml;'), 'ä', '&auml;'), 'ö', '&ouml;'), '"', '&apos;')) || '" HREF="mstrWeb' /* ? */ || CHR(63
                ) || 'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa05_value || '&elementsPromptAnswers='
            /* E  Land_1  (  Basic  )  = ?! */ || CASE
            WHEN pa.pa06_value IS NOT NULL
            THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
            ELSE NULL
            END || CASE
           WHEN pa.pa08_value IS NOT NULL
           THEN pa.pa08_value || CAST(CAST((COALESCE(BASE.adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
              STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa09_value IS NOT NULL
          THEN pa.pa09_value || CAST(CAST((COALESCE(BASE.rltd_adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC)
             AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa11_value IS NOT NULL
         THEN pa.pa11_value || CAST(CAST((COALESCE(BASE.item_grp_int_sid, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
           STRING)
         ELSE NULL
         END || '" ' || pa.pa26_value || '> ' || pa.pa02_value || '</a></span>' /* Drill to total */
  WHEN BASE.item_grp_int_sid = - 2
  THEN /* Color code #00A3E4 Regular blue */ /* DEFAULT NULL VALUE */ pa.pa12_value ||
                      '<a style="color:#ffffff" title="Detailanzeige für ' || ' für Werbewoche ' || ADW.adv_week_descr
                   || ' und für Vergleichswoche ' || RLTD_ADW.adv_week_descr || ' und alle Kategorien ' ||
                '" HREF="mstrWeb' /* ? */ || CHR(63) || 'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa13_value
            || '&elementsPromptAnswers=' /* E  Land_1  (  Basic  )  = ?! */ || CASE
            WHEN pa.pa06_value IS NOT NULL
            THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
            ELSE NULL
            END || CASE
           WHEN pa.pa08_value IS NOT NULL
           THEN pa.pa08_value || CAST(CAST((COALESCE(BASE.adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
              STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa09_value IS NOT NULL
          THEN pa.pa09_value || CAST(CAST((COALESCE(BASE.rltd_adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC)
             AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa11_value IS NOT NULL
         THEN pa.pa11_value || CAST(CAST((COALESCE(BASE.item_grp_int_sid, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
           STRING)
         ELSE NULL
         END || '" ' || pa.pa26_value || '> ' || pa.pa02_value || '</a></span>'
  ELSE NULL
  END AS drill_to_uwg_link_html
FROM ldl_p_lew_mart_pit_onprem.v_pit_base_category_all_1 AS BASE
 INNER JOIN ldl_p_lew_mart_pit_onprem.v_pit_itemgroup_international_1 AS IGI ON BASE.client_id = IGI.client_id AND BASE.item_grp_int_sid
     = IGI.item_grp_int_sid AND BASE.sub_item_grp_sid = - 2
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS ADW ON BASE.client_id = ADW.client_id AND BASE.adv_week_id = ADW
   .adv_week_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS RLTD_ADW ON BASE.client_id = RLTD_ADW.client_id AND BASE.rltd_adv_week_id
    = RLTD_ADW.adv_week_id /* CROSS JOIN Parameter Values */
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
     THEN COALESCE(param_value, 'N/A')
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
     THEN COALESCE(param_value, 'N/A')
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
     WHEN param_id = 26
     THEN param_value
     ELSE NULL
     END) AS pa26_value
  FROM ldl_p_lew_mart_pit_onprem.v_pit_param_1) AS pa ON TRUE
WHERE BASE.advert_items_cnt > 0;