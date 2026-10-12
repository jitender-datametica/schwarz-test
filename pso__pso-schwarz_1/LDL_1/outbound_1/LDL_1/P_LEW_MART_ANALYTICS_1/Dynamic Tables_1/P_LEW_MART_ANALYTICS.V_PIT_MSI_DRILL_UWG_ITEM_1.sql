
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.v_pit_msi_drill_uwg_item_1
 AS
/* Drill from itemgroup_1 WGI (or subitemgroup UWG) to items (Artikel_1) */
/* PIT-30.10.10 Kategorien UWG Artikel_1   A50746BC433E0CE9BC647EA8B66469F5 */ /* E Werbewoche = ?! */
/* E Unterwarengruppe = ?! */ /* PIT-30.10.19 Kategorien UWG Artikel_1 (Alle UWG)    7B27D2FD11E970A516860080EF25BEE9 */
/* E Werbewoche = ?! */ /* E Unterwarengruppe = ?! */ /* E Warengruppe International = ?! */ SELECT BASE.client_id,
 BASE.adv_week_id,
 CAST(BASE.adv_week_id * 100 + BASE.client_id AS BIGNUMERIC) AS adv_week_sid,
 BASE.rltd_adv_week_id,
 CAST(COALESCE(BASE.rltd_adv_week_id, - 1) * 100 + BASE.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 BASE.item_grp_int_sid,
 BASE.sub_item_grp_sid,
 CAST(COALESCE(BASE.item_grp_int_sid, - 1) * 100 + BASE.client_id AS BIGNUMERIC) AS item_grp_int_mstr_sid,
 CAST(COALESCE(BASE.sub_item_grp_sid, - 1) * 100 + BASE.client_id AS BIGNUMERIC) AS sub_item_grp_mstr_sid,
 1 AS `_count`,
  CASE
  WHEN BASE.sub_item_grp_sid <> - 2
  THEN pa.pa01_value || '<a style="color:#ffffff" title="Detailanzeige f&uuml;r' || ' Werbewoche ' || ADW.adv_week_descr
                   || ' und UWG: ' || TRIM(REPLACE(REPLACE(REPLACE(REPLACE(SIG.sub_item_grp_descr_int, 'ü', '&uuml;'),
                    'ä', '&auml;'), 'ö', '&ouml;'), '"', '&apos;')) || '" HREF="mstrWeb' /* ? */ || CHR(63) ||
             'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa04_value || '&elementsPromptAnswers='
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
         WHEN pa.pa10_value IS NOT NULL
         THEN pa.pa10_value || CAST(CAST((COALESCE(BASE.sub_item_grp_sid, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
           STRING)
         ELSE NULL
         END || '" ' || pa.pa03_value || '> ' || pa.pa02_value || '</a></span>'
   /* Drill from total of the itemgroup_1 WGI to all items of this itemgroup_1 WGI */
  WHEN BASE.sub_item_grp_sid = - 2
  THEN /* default NULL VALUE */ pa.pa12_value || '<a style="color:#ffffff" title="Detailanzeige f&uuml;r' ||
                   ' Werbewoche ' || ADW.adv_week_descr || ' und alle UWG' || '" HREF="mstrWeb' /* ? */ || CHR(63) ||
              'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa14_value || '&elementsPromptAnswers='
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
          WHEN pa.pa10_value IS NOT NULL
          THEN pa.pa10_value || CAST(CAST((COALESCE(BASE.sub_item_grp_sid, - 1) * 100) + BASE.client_id AS BIGNUMERIC)
             AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa11_value IS NOT NULL
         THEN pa.pa11_value || CAST(CAST((COALESCE(BASE.item_grp_int_sid, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
           STRING)
         ELSE NULL
         END || '" ' || pa.pa03_value || '> ' || pa.pa02_value || '</a></span>'
  ELSE NULL
  END AS drill_to_item_link_html
FROM ldl_p_lew_mart_analytics.v_pit_base_category_all_1 AS BASE
 INNER JOIN ldl_p_lew_mart_analytics.v_pit_itemgroup_international_1 AS IGI ON BASE.client_id = IGI.client_id AND BASE.item_grp_int_sid
     = IGI.item_grp_int_sid AND BASE.item_grp_int_sid <> - 2
   /* Keeping only the nearest related advertising week (no related week on item_1 level needed) */
 INNER JOIN ldl_p_lew_mart_analytics.v_pit_subitemgroup_1 AS SIG ON BASE.client_id = SIG.client_id AND BASE.sub_item_grp_sid
    = SIG.sub_item_grp_sid
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_week_1 AS ADW ON BASE.client_id = ADW.client_id AND BASE.adv_week_id = ADW.adv_week_id
   
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_week_1 AS RLTD_ADW ON BASE.client_id = RLTD_ADW.client_id AND BASE.rltd_adv_week_id
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
     WHEN param_id = 26
     THEN param_value
     ELSE NULL
     END) AS pa26_value
  FROM ldl_p_lew_mart_analytics.v_pit_param_1) AS pa ON TRUE
WHERE BASE.advert_items_cnt > 0
 AND BASE.nearest_rltd_adv_week_fg = 1;


