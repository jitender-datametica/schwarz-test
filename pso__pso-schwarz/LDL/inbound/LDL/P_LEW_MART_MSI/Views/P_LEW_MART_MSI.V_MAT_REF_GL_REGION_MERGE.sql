CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_REF_GL_REGION_MERGE
AS
/*
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2018    Khusainov, Timur            Initiliazation
#  1.1  07.08.2020    Roy,Ritanjal                Introduce new country Latviya
#  1.2  17.12.2021    Michael Morris              Added Estonia EE
#----------------------------------------------------------------------------
*/
SELECT   rME.client_id
       , rME.gl_region_id
       , rME.gl_region_desc
       , rME.gl_last_name
       , rME.gl_first_name
       , rME.aspect_id
       , COALESCE(cLE.int_id, -1335)           AS int_id
       , cLE.country_iso_cd
       , COALESCE(cLE.country_group_id, -1335) AS country_group_id
       , cLE.lisy_sort
       , cLE.dashboard_relevant_fg
       , cLE.country_desc_AT
       , cLE.country_desc_BE
       , cLE.country_desc_BG
       , cLE.country_desc_CH
       , cLE.country_desc_CY
       , cLE.country_desc_CZ
       , cLE.country_desc
       , cLE.country_desc_DK
       , cLE.country_desc_EE
       , cLE.country_desc_ES
       , cLE.country_desc_FI
       , cLE.country_desc_FR
       , cLE.country_desc_GB
       , cLE.country_desc_GR
       , cLE.country_desc_HR
       , cLE.country_desc_HU
       , cLE.country_desc_IE
       , cLE.country_desc_IT
       , cLE.country_desc_LT
       , cLE.country_desc_NI
       , cLE.country_desc_NL
       , cLE.country_desc_DE
       , cLE.country_desc_LV
       , cLE.country_desc_PL
       , cLE.country_desc_PT
       , cLE.country_desc_RO
       , cLE.country_desc_SE
       , cLE.country_desc_SI
       , cLE.country_desc_SK
       , cLE.country_desc_CS
       , cLE.country_desc_MT
       , cLE.country_desc_US
       , cLE.country_desc_RS
       , cLE.country_opening_date
  FROM P_LEW_MART_MSI.v_mat0_ref_gl_region_merge AS rME
  LEFT JOIN P_LEW_MART_MSI.v_mat_ref_client_lead AS cLE
    ON rME.client_id = cLE.client_id
;