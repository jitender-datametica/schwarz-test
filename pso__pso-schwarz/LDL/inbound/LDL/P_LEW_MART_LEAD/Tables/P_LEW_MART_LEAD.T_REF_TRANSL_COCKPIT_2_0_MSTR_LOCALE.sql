/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_mstr_locale
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/




CREATE TABLE P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_mstr_locale (
  lang VARCHAR(50)                   COMMENT 'Language'                                 ,
  country_code_export VARCHAR(5)     COMMENT 'Country code from Oracle translation DB'  ,
  country_code_mstr VARCHAR(5)       COMMENT 'Country code as in MSTR application'      ,
  localeid NUMBER(10)                COMMENT 'Locale id from Oracle export'
) COMMENT = 'Country / language list with locale id from Oracle translations export combined with MSTR country codes'
;
