/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS_2
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-07-20 Andreas Kurz  Initial version
#  2.2	2022-07-22 Nikolai Toknov  	Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_CNTL_FE_MSTR_REPORT_TOC_2');

DESC TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC_2;
DESC TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_PARAM_2;

DROP VIEW LDL.P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS_2

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_fe_mstr_adv_week_report_links_2
OPTIONS(DESCRIPTION = `SOURCE VIEW CONTROL TABLE FOR ADV.-WEEK RPORT LINKS`) AS -- 
 -- E Vergleichswerbewoche = ?!

-- E Werbewoche = ?!
 -- E Vergleichswerbewoche = ?!
 -- E Werbewoche = ?!
 /* Further list ordering */
-- Table of Reports
 -- Adv.Week
 -- Frontend Parameter
 SELECT toc.report_id,
 adw.client_id,
 adw.adv_week_mstr_id,
 toc.valid_from_dt,
 toc.valid_to_dt,
 toc.report_sort_val,
 toc.report_name,
 toc.report_guid,
 toc.report_annotation,
 toc.report_visible_fg,
 toc.report_teaser_fg,
 toc.report_type_fg,
 toc.report_panel_name,
 toc.report_panel_pskey,
 toc.report_panel_pkey,
 1 AS `_count`,
  CASE
  WHEN toc.report_teaser_fg = 0 AND toc.report_type_fg = 0
  THEN '<a style="color:#ffffff;text-decoration: none;" title="Detailanzeige f' || CHR(38) ||
                              'uuml;r erweiterte Grafische Analyse' || toc.report_name || ' f' || CHR(38) ||
                          'uuml;r Werbewoche: ' || adw.adv_week_ldescr || ' und Land_2: ' || adw.country_descr ||
                      '" HREF="mstrWeb' -- ?
 || CHR(63) || pa.pa41_value || toc.report_guid || pa.pa39_value || CHR(38
                  ) || 'elementsPromptAnswers=' -- E  Land_2 ( Basic ) = ?!
 || CASE
                WHEN pa.pa06_value IS NOT NULL
                THEN pa.pa06_value || CAST(adw.client_id AS STRING) || ','
                ELSE NULL
                END || CASE
               WHEN pa.pa09_value IS NOT NULL
               THEN pa.pa09_value || '#RLTDADVWEEKMSTRID#' || ','
               ELSE NULL
               END || CASE
              WHEN pa.pa08_value IS NOT NULL
              THEN pa.pa08_value || CAST(adw.adv_week_mstr_id AS STRING) || ','
              ELSE NULL
              END || '" ' || pa.pa26_value || '> ' || pa.pa44_value || '<center>' || pa.pa37_value || pa.pa42_value ||
     SUBSTR(toc.report_name, 1, 35) || '</span></center></div>' || '</a>'
  ELSE pa.pa44_value || '<center>' || pa.pa38_value || pa.pa43_value || SUBSTR(toc.report_name, 1, 35) ||
   '</span></center></div>'
  END AS html_web_link_image,
  CASE
  WHEN toc.report_teaser_fg = 0 AND toc.report_type_fg = 0
  THEN '<a style="color:#000000" title="Detailanzeige f' || CHR(38) || 'uuml;r Erweiterte Grafische Analyse' || toc.report_name
                         || ' f' || CHR(38) || 'uuml;r Werbewoche: ' || adw.adv_week_ldescr || ' und Land_2: ' || adw.country_descr
                   || '" HREF="mstrWeb' -- ?
 || CHR(63) || pa.pa41_value || toc.report_guid || pa.pa39_value || CHR(38
             ) || 'elementsPromptAnswers=' -- E  Land_2 ( Basic ) = ?!
 || CASE
           WHEN pa.pa06_value IS NOT NULL
           THEN pa.pa06_value || CAST(adw.client_id AS STRING) || ','
           ELSE NULL
           END || CASE
          WHEN pa.pa09_value IS NOT NULL
          THEN pa.pa09_value || '#RLTDADVWEEKMSTRID#' || ','
          ELSE NULL
          END || CASE
         WHEN pa.pa08_value IS NOT NULL
         THEN pa.pa08_value || CAST(adw.adv_week_mstr_id AS STRING) || ','
         ELSE NULL
         END || '" ' || pa.pa03_value || '> ' || toc.report_name || '</a>'
  ELSE toc.report_name
  END AS html_web_link,
  CASE
  WHEN toc.report_type_fg = 1
  THEN pa.pa25_value || CASE
                               WHEN toc.report_panel_name IS NOT NULL
                               THEN CHR(38) || 'nbsp;' || CHR(38) || 'nbsp;'
                               ELSE ''
                               END || '<a style="color:#000000" title="Detailanzeige f' || CHR(38) || 'uuml;r Bericht'
                          || toc.report_name || ' f' || CHR(38) || 'uuml;r Werbewoche: ' || adw.adv_week_ldescr ||
                     ' und Land_2: ' || adw.country_descr || CASE
                    WHEN toc.report_panel_name IS NOT NULL
                    THEN ' f' || CHR(38) || 'uuml;r Panel ' || toc.report_panel_name
                    ELSE ''
                    END || pa.pa39_value || '" HREF="mstrWeb' -- ?
 || CHR(63) || 'evt=2048001' || CHR(38) ||
             'src=mstrWeb.2048001' || CHR(38) || 'documentID=' || toc.report_guid || CASE
          WHEN toc.report_panel_name IS NOT NULL
          THEN CHR(38) || 'psKey=' || toc.report_panel_pskey || CHR(38) || 'pKey=' || toc.report_panel_pkey || pa.pa24_value
           
          ELSE ''
          END || '" ' || pa.pa03_value || '> ' || toc.report_name || CASE
     WHEN toc.report_panel_name IS NOT NULL
     THEN ' mit Panel ' || toc.report_panel_name
     ELSE ''
     END || '</a>'
  ELSE NULL
  END AS html_web_link_list,
     'mstrWeb' -- ?
 || CHR(63) || pa.pa41_value || toc.report_guid || pa.pa39_value AS html_web_link_native
FROM (SELECT report_id,
   report_sort_val,
   report_name,
   report_guid,
   report_annotation,
   report_visible_fg,
   report_teaser_fg,
   report_type_fg,
   report_panel_name,
   report_panel_pskey,
   report_panel_pkey,
   valid_from_dt,
   valid_to_dt,
   version_nr,
   current_fg,
   reject_fg,
   reject_reason_id,
   source_system_id,
   deleted_fg,
   dwh_created_ts,
   dwh_updated_ts,
   load_id
  FROM ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_report_toc_2
  WHERE CURRENT_DATE BETWEEN valid_from_dt AND valid_to_dt
   AND report_visible_fg = 1) AS toc
 INNER JOIN (SELECT client_id,
   country_descr,
   adv_week_mstr_id,
   adv_week_ldescr,
   adv_week_id
  FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_2
  WHERE deleted_fg = 0
   AND reject_fg = 0
   AND processed_adv_week_fg = 1) AS adw ON TRUE
 INNER JOIN (SELECT MAX(CASE
     WHEN fe_mstr_param_id = 1
     THEN COALESCE(fe_mstr_param_value, '<!-- ERROR SPAN Tag_2 -->')
     ELSE NULL
     END) AS pa01_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 2
     THEN COALESCE(fe_mstr_param_value, '<!-- ERROR IMG Tag_2  -->')
     ELSE NULL
     END) AS pa02_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 3
     THEN COALESCE(fe_mstr_param_value, '<!-- ERROR Target Attribute -->')
     ELSE NULL
     END) AS pa03_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 4
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa04_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 5
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa05_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 6
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa06_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 7
     THEN COALESCE(fe_mstr_param_value, 'N/A')
     ELSE NULL
     END) AS pa07_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 8
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa08_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 9
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa09_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 10
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa10_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 11
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa11_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 12
     THEN COALESCE(fe_mstr_param_value, 'N/A')
     ELSE NULL
     END) AS pa12_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 13
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa13_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 14
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa14_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 15
     THEN COALESCE(fe_mstr_param_value, '<!-- ERROR IMG Tag_2  -->')
     ELSE NULL
     END) AS pa15_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 16
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa16_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 17
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa17_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 18
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa18_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 19
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa19_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 20
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa20_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 21
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa21_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 22
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa22_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 23
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa23_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 24
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa24_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 25
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa25_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 26
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa26_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 27
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa27_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 28
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa28_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 29
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa29_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 30
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa30_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 31
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa31_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 32
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa32_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 33
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa33_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 34
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa34_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 35
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa35_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 36
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa36_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 37
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa37_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 38
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa38_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 39
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa39_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 40
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa40_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 41
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa41_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 42
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa42_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 43
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa43_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 44
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa44_value
  FROM ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_param_2
  WHERE deleted_fg = 0
   AND reject_fg = 0
   AND CURRENT_DATE BETWEEN valid_from_dt AND valid_to_dt) AS pa ON TRUE;



-- SELECT * FROM LDL.P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS_2 LIMIT 10;