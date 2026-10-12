
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_MSI_DRILL_MEDIUM_2
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     base.client_id,
   base.adv_week_id,
   base.adv_week_sid,
   base.adv_medium_sid,
   base.adv_medium_mstr_sid,
   base.adv_medium_grp_sid,
   base.adv_medium_grp_mstr_sid,
   CAST(1 AS INTEGER) AS rowcnt,
   /* regular case drill to Item_2 Level (per Medium) */
   CASE WHEN base.advert_items_cnt > 0 AND base.adv_medium_sid >= 0 AND SUBSTR( UPPER(base.advert_medium_DESCR), 1, 3) <> 'TOT' AND mdg.adv_medium_grp_LidlPlus_fg = 0 THEN
/* Color code # Regular grey medium light */
   pa.pa01_value
|| '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r '
|| ' Werbewoche '
|| adw.adv_week_long_descr
|| ' und Medium: '
|| TRIM(REPLACE(REPLACE(REPLACE(REPLACE(md.advert_medium_descr,'ü','&uuml;'),'ä','&auml;'),'ö','&ouml;'),'""','&apos;'))
   || '"" HREF=""mstrWeb'
   /* ? */
   || CHR(63)
   /* PIT-60.20 Werbemedien Artikel_2    BE88CFE0446BEF8F594B88B48837EF4F */
   || 'evt=2048001&src=mstrWeb.2048001&documentID='
   || pa.pa29_value
   || '&elementsPromptAnswers='
   /* E  Land_2 ( Basic ) = ?! */
   || CASE WHEN pa.pa06_value IS NOT NULL THEN
        pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
      ELSE NULL END
   /* E Werbewoche = ?! */
   || CASE WHEN pa.pa08_value IS NOT NULL THEN
        pa.pa08_value || CAST( CAST( COALESCE(base.adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
   ELSE NULL END
/* E Werbemedium = ?! */
|| CASE WHEN pa.pa28_value IS NOT NULL THEN
     pa.pa28_value || CAST ( base.adv_medium_mstr_sid AS VARCHAR(12))
   ELSE NULL END
|| '"" '
|| pa.pa26_value
|| '> '
|| pa.pa02_value
|| '</a></span>'
/* Drill to total (all items in Medium Group) */
WHEN base.advert_items_cnt > 0 AND (base.adv_medium_sid < 0 OR SUBSTR( UPPER(base.advert_medium_DESCR), 1, 3) = 'TOT') AND mdg.adv_medium_grp_LidlPlus_fg = 0  THEN
/* default NULL VALUE */
/* Color code #C0C0C0 Regular grey medium light */
   pa.pa12_value
|| '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r '
|| ' Werbewoche '
|| adw.adv_week_long_descr
|| ' und alle Medien aus der Gruppe_2 '
|| mdg.advert_medium_grp_descr
|| '"" HREF=""mstrWeb'
/* ? */
|| CHR(63)
/* PIT-60.29 Werbemedien Gruppe_2 Artikel_2 */
|| 'evt=2048001&src=mstrWeb.2048001&documentID='
|| pa.pa33_value
|| '&elementsPromptAnswers='
/* E  Land_2 ( Basic ) = ?! */
|| CASE WHEN pa.pa06_value IS NOT NULL THEN
    pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
  ELSE NULL END
/* E Werbewoche = ?! */
|| CASE WHEN pa.pa08_value IS NOT NULL THEN
    pa.pa08_value || CAST( CAST( COALESCE(base.adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
   ELSE NULL END
/* E Werbemedium Gruppe_2 = ?! */
|| CASE WHEN pa.pa31_value IS NOT NULL THEN
    pa.pa31_value || CAST ( base.adv_medium_grp_mstr_sid AS VARCHAR(12))
   ELSE NULL END
|| '"" '
|| pa.pa26_value
|| '> '
|| pa.pa02_value
|| '</a></span>'
ELSE
NULL
END AS drill_to_medium_item_link_html,
   CASE WHEN base.advert_items_cnt > 0 AND SUBSTR( UPPER(base.advert_medium_DESCR), 1, 3) <> 'TOT' AND base.adv_medium_mstr_sid >= 0 AND mdg.adv_medium_grp_LidlPlus_fg = 0 THEN
/* Color code #00A3E4 Regular blue */
   pa.pa01_value
|| '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r '
|| ' f&uuml;r alle Werbewochen ab '
|| adw.adv_week_long_descr
|| ' und Werbemedium '
|| TRIM(REPLACE(REPLACE(REPLACE(REPLACE(md.advert_medium_descr,'ü','&uuml;'),'ä','&auml;'),'ö','&ouml;'),'""','&apos;'))
   || '"" HREF=""mstrWeb'
   /* ? */
   || CHR(63)
   /* PIT-60.10 Werbemedien Werbewochen */
   || 'evt=2048001&src=mstrWeb.2048001&documentID='
   || pa.pa30_value
   || '&elementsPromptAnswers='
   /* E  Land_2 ( Basic ) = ?! */
   || CASE WHEN pa.pa06_value IS NOT NULL THEN
        pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
      ELSE NULL END
   /* E Werbewoche = ?! */
   || CASE WHEN pa.pa08_value IS NOT NULL THEN
        pa.pa08_value || CAST( CAST( COALESCE(base.adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
   ELSE NULL END
/* E Werbemedium = ?! */
|| CASE WHEN pa.pa28_value IS NOT NULL THEN
     pa.pa28_value || CAST ( base.adv_medium_mstr_sid AS VARCHAR(12))
   ELSE NULL END
|| '"" '
|| pa.pa26_value
|| '> '
|| pa.pa15_value
|| '</a></span>'
/* Drill to total (Medium Group - Historical Advertising Weeks) */
WHEN base.advert_items_cnt > 0 AND (base.adv_medium_mstr_sid < 0 OR SUBSTR( UPPER(base.advert_medium_DESCR), 1, 3) = 'TOT') AND mdg.adv_medium_grp_LidlPlus_fg = 0  THEN
/* default NULL VALUE */
/* Color code #00A3E4 Regular blue */
   pa.pa12_value
|| '<a style=""color:#ffffff"" title=""Detailanzeige f&uuml;r '
|| ' f&uuml;r alle Werbewochen ab '
|| adw.adv_week_long_descr
|| ' und alle Medien aus der Gruppe_2 '
|| mdg.advert_medium_grp_descr
|| '"" HREF=""mstrWeb'
/* ? */
|| CHR(63)
/* PIT-60.19 Werbemedien Gruppe_2 Werbewochen */
|| 'evt=2048001&src=mstrWeb.2048001&documentID='
|| pa.pa32_value
|| '&elementsPromptAnswers='
/*  E  Land_2 ( Basic ) = ?! */
|| CASE WHEN pa.pa06_value IS NOT NULL THEN
     pa.pa06_value || CAST( base.client_id AS VARCHAR(12)) || ','
   ELSE NULL END
/* E Werbewoche = ?! */
|| CASE WHEN pa.pa08_value IS NOT NULL THEN
     pa.pa08_value || CAST( CAST( COALESCE(base.adv_week_id, -1) *100 + base.client_id AS INTEGER ) AS VARCHAR(12)) ||  ','
   ELSE NULL END
/* E Werbemedium Gruppe_2 = ?! */
|| CASE WHEN pa.pa31_value IS NOT NULL THEN
     pa.pa31_value || CAST ( base.adv_medium_grp_mstr_sid AS VARCHAR(12))
   ELSE NULL END
|| '"" '
|| pa.pa26_value
|| '> '
|| pa.pa15_value
|| '</a></span>'
ELSE
NULL
END AS drill_to_medium_h_link_html
FROM p_lew_mart_analytics.v_pit_base_medium_all_2 AS base
   INNER JOIN p_lew_mart_analytics.v_pit_advert_medium_2 AS md
   ON  base.adv_medium_sid     = md.adv_medium_sid
   AND base.client_id          = md.client_id
   INNER JOIN p_lew_mart_analytics.v_pit_advert_medium_grp_2 AS mdg
   ON  base.adv_medium_grp_sid = mdg.adv_medium_grp_sid
   AND base.client_id          = mdg.client_id
   INNER JOIN
   (
       SELECT
         client_id,
   adv_week_id,
   adv_week_descr,
   CAST(adv_week_week_num /*Warning, Format '99' removed, semantic information not found.*/ AS CHAR(2))  || '/' || CAST(adv_week_year_num AS CHAR(4)) AS adv_week_long_descr,
   adv_week_year_num,
   adv_week_week_num
      FROM p_lew_mart_analytics.t_advert_week_2
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
   MAX(CASE WHEN param_id = 26 THEN param_value END)                                              AS pa26_value,
   MAX(CASE WHEN param_id = 27 THEN param_value END)                                              AS pa27_value,
   MAX(CASE WHEN param_id = 28 THEN param_value END)                                              AS pa28_value,
   MAX(CASE WHEN param_id = 29 THEN param_value END)                                              AS pa29_value,
   MAX(CASE WHEN param_id = 30 THEN param_value END)                                              AS pa30_value,
   MAX(CASE WHEN param_id = 31 THEN param_value END)                                              AS pa31_value,
   MAX(CASE WHEN param_id = 32 THEN param_value END)                                              AS pa32_value,
   MAX(CASE WHEN param_id = 33 THEN param_value END)                                              AS pa33_value
      FROM p_lew_mart_analytics.v_pit_param_2
  ) AS pa
  WHERE base.nearest_rltd_adv_week_fg = 1
   ;
