
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.v_pit_reports_toc_1
 AS
-- E Werbewoche = ?!
 -- E Vergleichswerbewoche = ?!
 -- E Werbewoche = ?!
 -- E Vergleichswerbewoche = ?!

/* Further list ordering */ SELECT BASE.report_id,
 adw.client_id,
 adw.adv_week_sid,
 adw.adv_week_rltd_sid,
 BASE.dwh_valid_from,
 BASE.dwh_valid_to,
 BASE.report_sorting_val,
 BASE.report_name,
 BASE.report_guid,
 BASE.report_annotation,
 BASE.report_visible_fg,
 BASE.report_teaser_fg,
 BASE.report_type_fg,
 BASE.report_panel_name,
 BASE.report_panel_pskey,
 BASE.report_panel_pkey,
 1 AS `_count`,
  CASE
  WHEN BASE.report_teaser_fg = 0 AND BASE.report_type_fg = 0
  THEN '<a style=""color:#ffffff;text-decoration: none;" title=""Detailanzeige f&uuml;r erweiterte Grafische Analyse' ||
                            BASE.report_name || ' f&uuml;r Werbewoche: ' || adw.adv_week_long_descr ||
                         ' und Vergleichswerbewoche: ' || adw.adv_rltd_week_long_descr || ' und Land_1: ' || adw.country_desc
                       || '"" HREF=""mstrWeb' -- ?
 || CHR(63) || pa.pa41_value || BASE.report_guid || pa.pa39_value ||
                '&elementsPromptAnswers=' -- E  Land_1 ( Basic ) = ?!
 || CASE
                WHEN pa.pa06_value IS NOT NULL
                THEN pa.pa06_value || CAST(adw.client_id AS STRING) || ','
                ELSE NULL
                END || CASE
               WHEN pa.pa08_value IS NOT NULL
               THEN pa.pa08_value || CAST(adw.adv_week_sid AS STRING) || ','
               ELSE NULL
               END || CASE
              WHEN pa.pa09_value IS NOT NULL
              THEN pa.pa09_value || CAST(adw.adv_week_rltd_sid AS STRING)
              ELSE NULL
              END || '"" ' || pa.pa26_value || '> ' || pa.pa44_value || '<center>' || pa.pa37_value || pa.pa42_value ||
     SUBSTR(BASE.report_name, 1, 35) || '</span></center></div>' || '</a>'
  ELSE pa.pa44_value || '<center>' || pa.pa38_value || pa.pa43_value || SUBSTR(BASE.report_name, 1, 35) ||
   '</span></center></div>'
  END AS html_web_link_image,
  CASE
  WHEN BASE.report_teaser_fg = 0 AND BASE.report_type_fg = 0
  THEN '<a style=""color:#000000"" title=""Detailanzeige f&uuml;r Erweiterte Grafische Analyse' || BASE.report_name ||
                      ' f&uuml;r Werbewoche: ' || adw.adv_week_long_descr || ' und Vergleichswerbewoche: ' || adw.adv_rltd_week_long_descr
                    || ' und Land_1: ' || adw.country_desc || '"" HREF=""mstrWeb' -- ?
 || CHR(63) || pa.pa41_value ||
             BASE.report_guid || pa.pa39_value || '&elementsPromptAnswers=' -- E  Land_1 ( Basic ) = ?!
 || CASE
           WHEN pa.pa06_value IS NOT NULL
           THEN pa.pa06_value || CAST(adw.client_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa08_value IS NOT NULL
          THEN pa.pa08_value || CAST(adw.adv_week_sid AS STRING) || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa09_value IS NOT NULL
         THEN pa.pa09_value || CAST(adw.adv_week_rltd_sid AS STRING)
         ELSE NULL
         END || '"" ' || pa.pa03_value || '> ' || BASE.report_name || '</a>'
  ELSE BASE.report_name
  END AS html_web_link,
  CASE
  WHEN BASE.report_type_fg = 1
  THEN pa.pa25_value || CASE
                         WHEN BASE.report_panel_name IS NOT NULL
                         THEN '&nbsp;&nbsp;'
                         ELSE ''
                         END || '<a style=""color:#000000"" title=""Detailanzeige f&uuml;r Bericht' || BASE.report_name
                     || ' f&uuml;r Werbewoche: ' || adw.adv_week_long_descr || ' und Vergleichswerbewoche: ' || adw.adv_rltd_week_long_descr
                   || ' und Land_1: ' || adw.country_desc || CASE
                WHEN BASE.report_panel_name IS NOT NULL
                THEN ' f&uuml;r Panel ' || BASE.report_panel_name
                ELSE ''
                END || pa.pa39_value || '"" HREF=""mstrWeb' -- ?
 || CHR(63) ||
           'evt=2048001&src=mstrWeb.2048001&documentID=' || BASE.report_guid || CASE
          WHEN BASE.report_panel_name IS NOT NULL
          THEN '&psKey=' || BASE.report_panel_pskey || '&pKey=' || BASE.report_panel_pkey || pa.pa24_value
          ELSE ''
          END || '"" ' || pa.pa03_value || '> ' || BASE.report_name || CASE
     WHEN BASE.report_panel_name IS NOT NULL
     THEN ' mit Panel ' || BASE.report_panel_name
     ELSE ''
     END || '</a>'
  ELSE NULL
  END AS html_web_link_list,
     'mstrWeb' -- ?
 || CHR(63) || pa.pa41_value || BASE.report_guid || pa.pa39_value AS html_web_link_native
FROM ldl_p_lew_mart_analytics.t_pit_reports_toc_1 AS BASE
 INNER JOIN (SELECT ADW.adv_week_id,
   ADW.adv_week_long_descr,
   ADW.client_id,
   CTR.country_desc_de AS country_desc,
   CAST(ADW.adv_week_id * 100 + ADW.client_id AS BIGNUMERIC) AS adv_week_sid,
   ADW_RLTD.adv_week_id AS adv_week_rltd_id,
   ADW_RLTD.adv_week_long_descr AS adv_rltd_week_long_descr,
   CAST(ADW_RLTD.adv_week_id * 100 + ADW_RLTD.client_id AS BIGNUMERIC) AS adv_week_rltd_sid
  FROM ldl_p_lew_mart_analytics.v_pit_adv_week_1 AS ADW
   INNER JOIN ldl_p_lew_mart_analytics.v_pit_adv_week_1 AS ADW_RLTD ON ADW.client_id = ADW_RLTD.client_id AND ADW.adv_week_seq
       > ADW_RLTD.adv_week_seq AND ADW.adv_week_seq < ADW_RLTD.adv_week_seq + 54
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS CTR ON ADW.client_id = CTR.client_id AND ADW_RLTD.client_id =
     CTR.client_id) AS adw ON CURRENT_DATE BETWEEN BASE.dwh_valid_from AND BASE.dwh_valid_to
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
     END) AS pa36_value,
   MAX(CASE
     WHEN param_id = 37
     THEN param_value
     ELSE NULL
     END) AS pa37_value,
   MAX(CASE
     WHEN param_id = 38
     THEN param_value
     ELSE NULL
     END) AS pa38_value,
   MAX(CASE
     WHEN param_id = 39
     THEN param_value
     ELSE NULL
     END) AS pa39_value,
   MAX(CASE
     WHEN param_id = 40
     THEN param_value
     ELSE NULL
     END) AS pa40_value,
   MAX(CASE
     WHEN param_id = 41
     THEN param_value
     ELSE NULL
     END) AS pa41_value,
   MAX(CASE
     WHEN param_id = 42
     THEN param_value
     ELSE NULL
     END) AS pa42_value,
   MAX(CASE
     WHEN param_id = 43
     THEN param_value
     ELSE NULL
     END) AS pa43_value,
   MAX(CASE
     WHEN param_id = 44
     THEN param_value
     ELSE NULL
     END) AS pa44_value
  FROM ldl_p_lew_mart_analytics.v_pit_param_1) AS pa ON TRUE
WHERE BASE.report_visible_fg = 1;


