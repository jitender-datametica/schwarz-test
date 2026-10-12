
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.v_pit_msi_drill_detail_1
 AS
/* PIT-20.01 Standard-Werbetermine Artikel_1 PV */ /* E Typ = ?! */ /* E Werbetermin = ?! */ /* E Werbewoche = ?! */
/* E Vergleichswerbewoche = ?! */ /* PIT-20.19 Werbetermine Artikel_1 PV (Alle Termine) */ /* E Typ = ?! */
/* E Werbewoche = ?! */ /* E Vergleichswerbewoche = ?! */ /* PIT-20.20 Werbetermine Artikel_1 NF+FA */ /* E Typ = ?! */
/* E Werbetermin = ?! */ /* E Werbewoche = ?! */ /* E Vergleichswerbewoche = ?! */
/* PIT-20.29 Werbetermine Artikel_1 NF+FA (Alle Termine) */ /* E Typ = ?! */ /* E Werbewoche = ?! */
/* E Vergleichswerbewoche = ?! */
/* Keeping only the nearest related advertising week (no related week on item_1 level needed) */ SELECT BASE.client_id,
 BASE.adv_week_id,
 CAST(BASE.adv_week_id * 100 + BASE.client_id AS BIGNUMERIC) AS adv_week_sid,
 BASE.rltd_adv_week_id,
 CAST(BASE.rltd_adv_week_id * 100 + BASE.client_id AS BIGNUMERIC) AS adv_week_rltd_sid,
 BASE.adv_period_id,
 BASE.action_type_id,
 1 AS `_count`,
  CASE
  WHEN BASE.action_type_id = 1 AND BASE.adv_period_id <> - 2
  THEN /* PV */ pa.pa01_value || '<a style="color:#ffffff" title="Detailanzeige f&uuml;r ' || ATY.action_type_descr ||
                     ' für Werbewoche ' || ADW.adv_week_descr || ' und Werbetermin: ' || CASE
                   WHEN ADP.adv_period_descr = 'TOT'
                   THEN 'Gesamt'
                   ELSE ADP.adv_period_descr
                   END || '" HREF="mstrWeb' /* ? */ || CHR(63) || 'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa18_value
               || '&elementsPromptAnswers=' /* E  Land_1 ( Basic ) = ?! */ || CASE
             WHEN pa.pa06_value IS NOT NULL
             THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
             ELSE NULL
             END || CASE
            WHEN pa.pa19_value IS NOT NULL
            THEN pa.pa19_value || CAST(ATY.action_type_id AS STRING) || ','
            ELSE NULL
            END || CASE
           WHEN pa.pa20_value IS NOT NULL
           THEN pa.pa20_value || CAST(BASE.adv_period_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa08_value IS NOT NULL
          THEN pa.pa08_value || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa09_value IS NOT NULL
         THEN pa.pa09_value || CAST(CAST((COALESCE(BASE.rltd_adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
            STRING) || ','
         ELSE NULL
         END || '" ' || pa.pa26_value || '> ' || pa.pa02_value || '</a></span>'
  WHEN BASE.action_type_id = 1 AND BASE.adv_period_id = - 2
  THEN /* Color code #00A3E4 Regular blue */ /* PV */ pa.pa12_value ||
                      '<a style="color:#ffffff" title="Detailanzeige f&uuml;r ' || ATY.action_type_descr ||
                    ' für Werbewoche ' || ADW.adv_week_descr || ' und Werbetermin: ' || CASE
                  WHEN ADP.adv_period_descr = 'TOT'
                  THEN 'Alle Werbetermine'
                  ELSE ADP.adv_period_descr
                  END || '" HREF="mstrWeb' /* ? */ || CHR(63) || 'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa21_value
              || '&elementsPromptAnswers=' /* E  Land_1 ( Basic ) = ?! */ || CASE
            WHEN pa.pa06_value IS NOT NULL
            THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
            ELSE NULL
            END || CASE
           WHEN pa.pa19_value IS NOT NULL
           THEN pa.pa19_value || CAST(ATY.action_type_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa08_value IS NOT NULL
          THEN pa.pa08_value || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa09_value IS NOT NULL
         THEN pa.pa09_value || CAST(CAST((COALESCE(BASE.rltd_adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
            STRING) || ','
         ELSE NULL
         END || '" ' || pa.pa26_value || '> ' || pa.pa02_value || '</a></span>'
  WHEN BASE.action_type_id IN (2, 3) AND BASE.adv_period_id <> - 2
  THEN /* Drill auf Non Food and Food Actions */ pa.pa01_value ||
                       '<a style="color:#ffffff" title="Detailanzeige f&uuml;r ' || ATY.action_type_descr ||
                     ' für Werbewoche ' || ADW.adv_week_descr || ' und Werbetermin: ' || CASE
                   WHEN ADP.adv_period_descr = 'TOT'
                   THEN 'Gesamt'
                   ELSE ADP.adv_period_descr
                   END || '" HREF="mstrWeb' /* ? */ || CHR(63) || 'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa22_value
               || '&elementsPromptAnswers=' /* E  Land_1 ( Basic ) = ?! */ || CASE
             WHEN pa.pa06_value IS NOT NULL
             THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
             ELSE NULL
             END || CASE
            WHEN pa.pa19_value IS NOT NULL
            THEN pa.pa19_value || CAST(ATY.action_type_id AS STRING) || ','
            ELSE NULL
            END || CASE
           WHEN pa.pa20_value IS NOT NULL
           THEN pa.pa20_value || CAST(BASE.adv_period_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa08_value IS NOT NULL
          THEN pa.pa08_value || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa09_value IS NOT NULL
         THEN pa.pa09_value || CAST(CAST((COALESCE(BASE.rltd_adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
            STRING) || ','
         ELSE NULL
         END || '" ' || pa.pa26_value || '> ' || pa.pa02_value || '</a></span>'
  WHEN BASE.action_type_id IN (2, 3) AND BASE.adv_period_id = - 2
  THEN /* Color code #00A3E4 Regular blue */ /* Drill auf Non Food and Food Actions */ pa.pa12_value ||
                      '<a style="color:#ffffff" title="Detailanzeige f&uuml;r ' || ATY.action_type_descr ||
                    ' für Werbewoche ' || ADW.adv_week_descr || ' und Werbetermin: ' || CASE
                  WHEN ADP.adv_period_descr = 'TOT'
                  THEN 'Alle Werbetermine'
                  ELSE ADP.adv_period_descr
                  END || '" HREF="mstrWeb' /* ? */ || CHR(63) || 'evt=2048001&src=mstrWeb.2048001&documentID=' || pa.pa23_value
              || '&elementsPromptAnswers=' /* E  Land_1 ( Basic ) = ?! */ || CASE
            WHEN pa.pa06_value IS NOT NULL
            THEN pa.pa06_value || CAST(BASE.client_id AS STRING) || ','
            ELSE NULL
            END || CASE
           WHEN pa.pa19_value IS NOT NULL
           THEN pa.pa19_value || CAST(ATY.action_type_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa08_value IS NOT NULL
          THEN pa.pa08_value || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa09_value IS NOT NULL
         THEN pa.pa09_value || CAST(CAST((COALESCE(BASE.rltd_adv_week_id, - 1) * 100) + BASE.client_id AS BIGNUMERIC) AS
            STRING) || ','
         ELSE NULL
         END || '" ' || pa.pa26_value || '> ' || pa.pa02_value || '</a></span>'
  ELSE NULL
  END AS drill_to_dokument_link_html
FROM ldl_p_lew_mart_analytics.v_pit_base_period_all_1 AS BASE
 INNER JOIN ldl_p_lew_mart_analytics.t_action_type_1 AS ATY ON BASE.action_type_id = ATY.action_type_id
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_period_1 AS ADP ON BASE.adv_period_id = ADP.adv_period_id
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_week_1 AS ADW ON BASE.client_id = ADW.client_id AND BASE.adv_week_id = ADW.adv_week_id
   /* CROSS JOIN Parameter Values */
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
     END) AS pa26_value
  FROM ldl_p_lew_mart_analytics.v_pit_param_1) AS pa ON TRUE
WHERE BASE.nearest_rltd_adv_week_fg = 1;

