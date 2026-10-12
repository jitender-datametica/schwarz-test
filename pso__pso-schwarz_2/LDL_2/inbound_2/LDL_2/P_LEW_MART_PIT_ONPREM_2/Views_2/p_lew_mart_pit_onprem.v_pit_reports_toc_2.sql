CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_REPORTS_TOC_2

AS
   SELECT
   base.report_id
,   adw.client_id
,   adw.adv_week_sid
,   adw.adv_week_rltd_sid
,   base.dwh_valid_from
,   base.dwh_valid_to
,   base.report_sorting_val
,   base.report_name
,   base.report_guid
,   base.report_annotation
,   base.report_visible_fg
,   base.report_teaser_fg
,   base.report_type_fg
,   base.report_panel_name
,   base.report_panel_pskey
,   base.report_panel_pkey
,   CAST(1 AS INTEGER) AS _count
,   CASE WHEN base.report_teaser_fg = 0 AND report_type_fg = 0 THEN
        '<a style="color:#ffffff;text-decoration: none;" title="Detailanzeige f&uuml;r erweiterte Grafische Analyse'
     || base.report_name
     || ' f&uuml;r Werbewoche: '
     || adw.adv_week_long_descr
     || ' und Vergleichswerbewoche: '
     || adw.adv_rltd_week_long_descr
     || ' und Land_2: '
     || adw.country_desc

     || '" HREF="mstrWeb'
     -- ?
     || CHR(63)
     || pa.pa41_value
     || base.report_guid
     || pa.pa39_value
     || '&elementsPromptAnswers='

     -- E  Land_2 ( Basic ) = ?!
     || CASE WHEN pa.pa06_value IS NOT NULL THEN
         pa.pa06_value || CAST( adw.client_id AS VARCHAR(12)) || ','
        ELSE NULL END

     -- E Werbewoche = ?!
     || CASE WHEN pa.pa08_value IS NOT NULL THEN
         pa.pa08_value || CAST( adw.adv_week_sid  AS VARCHAR(12)) ||  ','
        ELSE NULL END

     -- E Vergleichswerbewoche = ?!
     || CASE WHEN pa.pa09_value IS NOT NULL THEN
         pa.pa09_value || CAST( adw.adv_week_rltd_sid AS VARCHAR(12))
        ELSE NULL END

     || '" '
     || pa.pa26_value
     || '> '
     || pa.pa44_value
     || '<center>'
     || pa.pa37_value
     || pa.pa42_value
     || SUBSTR(base.report_name,1,35)
     || '</span></center></div>'
     || '</a>'
   ELSE
        pa.pa44_value
     || '<center>'
     || pa.pa38_value
     || pa.pa43_value
     || SUBSTR(base.report_name,1,35)
     || '</span></center></div>'
   END AS html_web_link_image
,   CASE WHEN base.report_teaser_fg = 0 AND report_type_fg = 0 THEN
        '<a style="color:#000000" title="Detailanzeige f&uuml;r Erweiterte Grafische Analyse'
     || base.report_name
     || ' f&uuml;r Werbewoche: '
     || adw.adv_week_long_descr
     || ' und Vergleichswerbewoche: '
     || adw.adv_rltd_week_long_descr
     || ' und Land_2: '
     || adw.country_desc

     || '" HREF="mstrWeb'
     -- ?
     || CHR(63)
     || pa.pa41_value
     || base.report_guid
     || pa.pa39_value
     || '&elementsPromptAnswers='

     -- E  Land_2 ( Basic ) = ?!
     || CASE WHEN pa.pa06_value IS NOT NULL THEN
         pa.pa06_value || CAST( adw.client_id AS VARCHAR(12)) || ','
        ELSE NULL END

     -- E Werbewoche = ?!
     || CASE WHEN pa.pa08_value IS NOT NULL THEN
         pa.pa08_value || CAST( adw.adv_week_sid  AS VARCHAR(12)) ||  ','
        ELSE NULL END

     -- E Vergleichswerbewoche = ?!
     || CASE WHEN pa.pa09_value IS NOT NULL THEN
         pa.pa09_value || CAST( adw.adv_week_rltd_sid AS VARCHAR(12))
        ELSE NULL END

     || '" '
     || pa.pa03_value
     || '> '
     || base.report_name
     || '</a>'
   ELSE
        base.report_name
   END AS html_web_link
,   CASE WHEN report_type_fg = 1 THEN
        pa.pa25_value
     || CASE WHEN base.report_panel_name IS NOT NULL THEN '&nbsp;&nbsp;' ELSE '' END /* Further list ordering */
     || '<a style="color:#000000" title="Detailanzeige f&uuml;r Bericht'
     || base.report_name
     || ' f&uuml;r Werbewoche: '
     || adw.adv_week_long_descr
     || ' und Vergleichswerbewoche: '
     || adw.adv_rltd_week_long_descr
     || ' und Land_2: '
     || adw.country_desc
     || CASE WHEN base.report_panel_name IS NOT NULL THEN ' f&uuml;r Panel ' || base.report_panel_name ELSE '' END
     || pa.pa39_value
     || '" HREF="mstrWeb'
     -- ?
     || CHR(63)
     || 'evt=2048001&src=mstrWeb.2048001&documentID='
     || base.report_guid

     || CASE WHEN base.report_panel_name IS NOT NULL THEN
        '&psKey=' || base.report_panel_pskey || '&pKey=' || base.report_panel_pkey || pa.pa24_value ELSE '' END
     || '" '
     || pa.pa03_value
     || '> '
     || base.report_name || CASE WHEN base.report_panel_name IS NOT NULL THEN ' mit Panel ' || base.report_panel_name ELSE '' END
     || '</a>'
   ELSE
        NULL
   END AS html_web_link_list
,   'mstrWeb'
   -- ?
   || CHR(63)
   || pa.pa41_value
   || base.report_guid
   || pa.pa39_value AS html_web_link_native
   FROM p_lew_mart_pit_onprem.t_pit_reports_toc_2 AS base
   CROSS JOIN
   (SELECT
   adw.adv_week_id
,   adw.adv_week_long_descr
,   adw.client_id
,   ctr.country_name AS country_desc
,   CAST( (adw.adv_week_id * 100::INTEGER) + adw.client_id AS INTEGER) AS adv_week_sid
,   adw_rltd.adv_week_id AS adv_week_rltd_id
,   adw_rltd.adv_week_long_descr AS adv_rltd_week_long_descr
,   CAST( (adw_rltd.adv_week_id * 100::INTEGER) + adw_rltd.client_id AS INTEGER) AS adv_week_rltd_sid
   FROM p_lew_mart_pit_onprem.v_pit_adv_week_2 AS adw
   INNER JOIN p_lew_mart_pit_onprem.v_pit_adv_week_2 AS adw_rltd
   ON  adw.client_id       = adw_rltd.client_id
   AND adw.adv_week_seq    > adw_rltd.adv_week_seq
   AND adw.adv_week_seq    < (adw_rltd.adv_week_seq::INTEGER+54)
   INNER JOIN p_lew_core_ac.v_country_2 AS ctr
   ON  ctr.country_sid = adw.client_id
   AND ctr.country_sid = adw_rltd.client_id
) AS adw
   CROSS JOIN
   (SELECT
   MAX(CASE WHEN param_id =  1 THEN COALESCE(param_value,'<!-- ERROR SPAN Tag_2 -->') END)          AS pa01_value
,   MAX(CASE WHEN param_id =  2 THEN COALESCE(param_value,'<!-- ERROR IMG Tag_2  -->') END)          AS pa02_value
,   MAX(CASE WHEN param_id =  3 THEN COALESCE(param_value,'<!-- ERROR Target Attribute -->') END)  AS pa03_value
,   MAX(CASE WHEN param_id =  4 THEN param_value END)                                              AS pa04_value
,   MAX(CASE WHEN param_id =  5 THEN param_value END)                                              AS pa05_value
,   MAX(CASE WHEN param_id =  6 THEN param_value END)                                              AS pa06_value
,   MAX(CASE WHEN param_id =  7 THEN COALESCE(param_value,'N/A')END)                               AS pa07_value
,   MAX(CASE WHEN param_id =  8 THEN param_value END)                                              AS pa08_value
,   MAX(CASE WHEN param_id =  9 THEN param_value END)                                              AS pa09_value
,   MAX(CASE WHEN param_id = 10 THEN param_value END)                                              AS pa10_value
,   MAX(CASE WHEN param_id = 11 THEN param_value END)                                              AS pa11_value
,   MAX(CASE WHEN param_id = 12 THEN COALESCE(param_value,'N/A') END)                              AS pa12_value
,   MAX(CASE WHEN param_id = 13 THEN param_value END)                                              AS pa13_value
,   MAX(CASE WHEN param_id = 14 THEN param_value END)                                              AS pa14_value
,   MAX(CASE WHEN param_id = 15 THEN COALESCE(param_value,'<!-- ERROR IMG Tag_2  -->') END)          AS pa15_value
,   MAX(CASE WHEN param_id = 16 THEN param_value END)                                              AS pa16_value
,   MAX(CASE WHEN param_id = 17 THEN param_value END)                                              AS pa17_value
,   MAX(CASE WHEN param_id = 18 THEN param_value END)                                              AS pa18_value
,   MAX(CASE WHEN param_id = 19 THEN param_value END)                                              AS pa19_value
,   MAX(CASE WHEN param_id = 20 THEN param_value END)                                              AS pa20_value
,   MAX(CASE WHEN param_id = 21 THEN param_value END)                                              AS pa21_value
,   MAX(CASE WHEN param_id = 22 THEN param_value END)                                              AS pa22_value
,   MAX(CASE WHEN param_id = 23 THEN param_value END)                                              AS pa23_value
,   MAX(CASE WHEN param_id = 24 THEN param_value END)                                              AS pa24_value
,   MAX(CASE WHEN param_id = 25 THEN param_value END)                                              AS pa25_value
,   MAX(CASE WHEN param_id = 26 THEN param_value END)                                              AS pa26_value
,   MAX(CASE WHEN param_id = 27 THEN param_value END)                                              AS pa27_value
,   MAX(CASE WHEN param_id = 28 THEN param_value END)                                              AS pa28_value
,   MAX(CASE WHEN param_id = 29 THEN param_value END)                                              AS pa29_value
,   MAX(CASE WHEN param_id = 30 THEN param_value END)                                              AS pa30_value
,   MAX(CASE WHEN param_id = 31 THEN param_value END)                                              AS pa31_value
,   MAX(CASE WHEN param_id = 32 THEN param_value END)                                              AS pa32_value
,   MAX(CASE WHEN param_id = 33 THEN param_value END)                                              AS pa33_value
,   MAX(CASE WHEN param_id = 34 THEN param_value END)                                              AS pa34_value
,   MAX(CASE WHEN param_id = 35 THEN param_value END)                                              AS pa35_value
,   MAX(CASE WHEN param_id = 36 THEN param_value END)                                              AS pa36_value
,   MAX(CASE WHEN param_id = 37 THEN param_value END)                                              AS pa37_value
,   MAX(CASE WHEN param_id = 38 THEN param_value END)                                              AS pa38_value
,   MAX(CASE WHEN param_id = 39 THEN param_value END)                                              AS pa39_value
,   MAX(CASE WHEN param_id = 40 THEN param_value END)                                              AS pa40_value
,   MAX(CASE WHEN param_id = 41 THEN param_value END)                                              AS pa41_value
,   MAX(CASE WHEN param_id = 42 THEN param_value END)                                              AS pa42_value
,   MAX(CASE WHEN param_id = 43 THEN param_value END)                                              AS pa43_value
,   MAX(CASE WHEN param_id = 44 THEN param_value END)                                              AS pa44_value
   FROM p_lew_mart_pit_onprem.v_pit_param_2
  ) AS pa

  WHERE CURRENT_DATE BETWEEN base.dwh_valid_from AND base.dwh_valid_to
  AND base.report_visible_fg = 1;