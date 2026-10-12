/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022/2023
#-------------------------------------------------------------------------------
# Interface : View for ETL_LOGGING
#-------------------------------------------------------------------------------
# Describtion: Create View for ETL_LOGGING
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-03-10 Andreas Kurz	    Initial version
#  1.1  2023-03-13 Nikolai Toknov	Cosmetic changes
#  1.2  2025-02-04 Nikolai Toknov	replace ampersand to char(38)
#  1.3  2025-03-24 Nikolai Toknov	Change for Azure-pipeline
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_ETL_LOGGING
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_fe_mstr_notifications_2
OPTIONS(DESCRIPTION = `ACCESS VIEW KONTROLL ENDUSER NOTIFICATIONS ON STARTPAGE`) AS SELECT notification_id,
 notification_html_descr_de,
 notification_html_descr_en,
 notification_author,
 notification_entry_dt,
 FORMAT_DATE('%F', notification_entry_dt) AS notification_entry_dt_char,
 IF(notification_visible_fg = 1, '<p><h3>' || 'Wichtige Mitteilung | Important Notification vom / of: ' || COALESCE(FORMAT_DATE('%F'
                     , notification_entry_dt), '88881231') || '</h3>' || '<br>' || COALESCE(notification_html_descr_de,
                 '') || '<hr>' || '<br>' || COALESCE(notification_html_descr_en, '') || '<br>' || '<em>' || COALESCE(notification_author
           , '') || CHR(38) || 'nbsp;vom' || CHR(38) || 'nbsp;' || COALESCE(FORMAT_DATE('%F', notification_entry_dt),
      '88881231') || '</em>' || '</p>', NULL) AS notification_html_tag,
 notification_visible_fg,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 CAST(load_id AS STRING) AS load_id,
 IF(notification_id >= 0, ((DENSE_RANK() OVER (ORDER BY notification_id IS NULL, notification_id, notification_entry_dt
         IS NULL, notification_entry_dt)) - 2) * - 1, NULL) AS moving_run_id_from_current,
 MAX(notification_id) OVER (ORDER BY NULL IS NULL, NULL RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 max_notification_id
FROM ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_notifications_2 AS NT
WHERE deleted_fg = 0
 AND current_fg = 1
 AND CURRENT_DATE BETWEEN valid_from_dt AND valid_to_dt;