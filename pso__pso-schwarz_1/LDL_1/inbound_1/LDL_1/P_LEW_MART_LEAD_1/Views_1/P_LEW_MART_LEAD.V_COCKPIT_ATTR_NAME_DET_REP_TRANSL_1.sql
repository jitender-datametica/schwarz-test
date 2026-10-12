/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_name_det_rep_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_name_det_rep_transl_1
(
  id 
, NAME
, name_AT   
, name_BE   
, name_BE_fr
, name_BG   
, name_CH   
, name_CS   
, name_CY   
, name_CZ   
, name_DK   
, name_EE   
, name_ES   
, name_FI   
, name_FR   
, name_GB   
, name_GR   
, name_HR   
, name_HU   
, name_IE   
, name_IT   
, name_LT   
, name_LV   
, name_MT   
, name_NI   
, name_NL   
, name_PL   
, name_PT   
, name_RO   
, name_RS   
, name_SE   
, name_SI   
, name_SK   
, name_US   
)
AS
SELECT
  detrep.id 
, detrep.NAME
, COALESCE(transl.transl_AT   , detrep.NAME)  AS name_AT   
, COALESCE(transl.transl_BE   , detrep.NAME)  AS name_BE   
, COALESCE(transl.transl_BE_fr, detrep.NAME)  AS name_BE_fr
, COALESCE(transl.transl_BG   , detrep.NAME)  AS name_BG   
, COALESCE(transl.transl_CH   , detrep.NAME)  AS name_CH   
, COALESCE(transl.transl_CS   , detrep.NAME)  AS name_CS   
, COALESCE(transl.transl_CY   , detrep.NAME)  AS name_CY   
, COALESCE(transl.transl_CZ   , detrep.NAME)  AS name_CZ   
, COALESCE(transl.transl_DK   , detrep.NAME)  AS name_DK   
, COALESCE(transl.transl_EE   , detrep.NAME)  AS name_EE   
, COALESCE(transl.transl_ES   , detrep.NAME)  AS name_ES   
, COALESCE(transl.transl_FI   , detrep.NAME)  AS name_FI   
, COALESCE(transl.transl_FR   , detrep.NAME)  AS name_FR   
, COALESCE(transl.transl_GB   , detrep.NAME)  AS name_GB   
, COALESCE(transl.transl_GR   , detrep.NAME)  AS name_GR   
, COALESCE(transl.transl_HR   , detrep.NAME)  AS name_HR   
, COALESCE(transl.transl_HU   , detrep.NAME)  AS name_HU   
, COALESCE(transl.transl_IE   , detrep.NAME)  AS name_IE   
, COALESCE(transl.transl_IT   , detrep.NAME)  AS name_IT   
, COALESCE(transl.transl_LT   , detrep.NAME)  AS name_LT   
, COALESCE(transl.transl_LV   , detrep.NAME)  AS name_LV   
, COALESCE(transl.transl_MT   , detrep.NAME)  AS name_MT   
, COALESCE(transl.transl_NI   , detrep.NAME)  AS name_NI   
, COALESCE(transl.transl_NL   , detrep.NAME)  AS name_NL   
, COALESCE(transl.transl_PL   , detrep.NAME)  AS name_PL   
, COALESCE(transl.transl_PT   , detrep.NAME)  AS name_PT   
, COALESCE(transl.transl_RO   , detrep.NAME)  AS name_RO   
, COALESCE(transl.transl_RS   , detrep.NAME)  AS name_RS   
, COALESCE(transl.transl_SE   , detrep.NAME)  AS name_SE   
, COALESCE(transl.transl_SI   , detrep.NAME)  AS name_SI   
, COALESCE(transl.transl_SK   , detrep.NAME)  AS name_SK   
, COALESCE(transl.transl_US   , detrep.NAME)  AS name_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map_detail_reports_1 detrep
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_1 transl
ON transl.transl = TRIM(detrep.NAME)
;
