/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_key_det_rep_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_key_det_rep_transl_2
(
  id 
, key_id
, key_desc
, key_desc_AT   
, key_desc_BE   
, key_desc_BE_fr
, key_desc_BG   
, key_desc_CH   
, key_desc_CS   
, key_desc_CY   
, key_desc_CZ   
, key_desc_DK   
, key_desc_EE   
, key_desc_ES   
, key_desc_FI   
, key_desc_FR   
, key_desc_GB   
, key_desc_GR   
, key_desc_HR   
, key_desc_HU   
, key_desc_IE   
, key_desc_IT   
, key_desc_LT   
, key_desc_LV   
, key_desc_MT   
, key_desc_NI   
, key_desc_NL   
, key_desc_PL   
, key_desc_PT   
, key_desc_RO   
, key_desc_RS   
, key_desc_SE   
, key_desc_SI   
, key_desc_SK   
, key_desc_US   
)
AS
SELECT
  detrep.id 
, detrep.key_id
, detrep.key_desc
, COALESCE(transl.transl_AT   , detrep.key_desc)  AS key_desc_AT   
, COALESCE(transl.transl_BE   , detrep.key_desc)  AS key_desc_BE   
, COALESCE(transl.transl_BE_fr, detrep.key_desc)  AS key_desc_BE_fr
, COALESCE(transl.transl_BG   , detrep.key_desc)  AS key_desc_BG   
, COALESCE(transl.transl_CH   , detrep.key_desc)  AS key_desc_CH   
, COALESCE(transl.transl_CS   , detrep.key_desc)  AS key_desc_CS   
, COALESCE(transl.transl_CY   , detrep.key_desc)  AS key_desc_CY   
, COALESCE(transl.transl_CZ   , detrep.key_desc)  AS key_desc_CZ   
, COALESCE(transl.transl_DK   , detrep.key_desc)  AS key_desc_DK   
, COALESCE(transl.transl_EE   , detrep.key_desc)  AS key_desc_EE   
, COALESCE(transl.transl_ES   , detrep.key_desc)  AS key_desc_ES   
, COALESCE(transl.transl_FI   , detrep.key_desc)  AS key_desc_FI   
, COALESCE(transl.transl_FR   , detrep.key_desc)  AS key_desc_FR   
, COALESCE(transl.transl_GB   , detrep.key_desc)  AS key_desc_GB   
, COALESCE(transl.transl_GR   , detrep.key_desc)  AS key_desc_GR   
, COALESCE(transl.transl_HR   , detrep.key_desc)  AS key_desc_HR   
, COALESCE(transl.transl_HU   , detrep.key_desc)  AS key_desc_HU   
, COALESCE(transl.transl_IE   , detrep.key_desc)  AS key_desc_IE   
, COALESCE(transl.transl_IT   , detrep.key_desc)  AS key_desc_IT   
, COALESCE(transl.transl_LT   , detrep.key_desc)  AS key_desc_LT   
, COALESCE(transl.transl_LV   , detrep.key_desc)  AS key_desc_LV   
, COALESCE(transl.transl_MT   , detrep.key_desc)  AS key_desc_MT   
, COALESCE(transl.transl_NI   , detrep.key_desc)  AS key_desc_NI   
, COALESCE(transl.transl_NL   , detrep.key_desc)  AS key_desc_NL   
, COALESCE(transl.transl_PL   , detrep.key_desc)  AS key_desc_PL   
, COALESCE(transl.transl_PT   , detrep.key_desc)  AS key_desc_PT   
, COALESCE(transl.transl_RO   , detrep.key_desc)  AS key_desc_RO   
, COALESCE(transl.transl_RS   , detrep.key_desc)  AS key_desc_RS   
, COALESCE(transl.transl_SE   , detrep.key_desc)  AS key_desc_SE   
, COALESCE(transl.transl_SI   , detrep.key_desc)  AS key_desc_SI   
, COALESCE(transl.transl_SK   , detrep.key_desc)  AS key_desc_SK   
, COALESCE(transl.transl_US   , detrep.key_desc)  AS key_desc_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map_detail_reports_2 detrep
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_2 transl
ON transl.transl = TRIM(detrep.key_desc)
;
