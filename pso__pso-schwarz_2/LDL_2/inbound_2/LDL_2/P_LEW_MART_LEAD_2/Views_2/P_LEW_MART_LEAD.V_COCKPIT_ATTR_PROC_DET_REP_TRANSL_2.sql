/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_proc_det_rep_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_proc_det_rep_transl_2
(
  id 
, process_id
, process_desc
, process_desc_AT   
, process_desc_BE   
, process_desc_BE_fr
, process_desc_BG   
, process_desc_CH   
, process_desc_CS   
, process_desc_CY   
, process_desc_CZ   
, process_desc_DK   
, process_desc_EE   
, process_desc_ES   
, process_desc_FI   
, process_desc_FR   
, process_desc_GB   
, process_desc_GR   
, process_desc_HR   
, process_desc_HU   
, process_desc_IE   
, process_desc_IT   
, process_desc_LT   
, process_desc_LV   
, process_desc_MT   
, process_desc_NI   
, process_desc_NL   
, process_desc_PL   
, process_desc_PT   
, process_desc_RO   
, process_desc_RS   
, process_desc_SE   
, process_desc_SI   
, process_desc_SK   
, process_desc_US   
)
AS
SELECT
  detrep.id 
, detrep.process_id
, detrep.process_desc
, COALESCE(transl.transl_AT   , detrep.process_desc)  AS process_desc_AT   
, COALESCE(transl.transl_BE   , detrep.process_desc)  AS process_desc_BE   
, COALESCE(transl.transl_BE_fr, detrep.process_desc)  AS process_desc_BE_fr
, COALESCE(transl.transl_BG   , detrep.process_desc)  AS process_desc_BG   
, COALESCE(transl.transl_CH   , detrep.process_desc)  AS process_desc_CH   
, COALESCE(transl.transl_CS   , detrep.process_desc)  AS process_desc_CS   
, COALESCE(transl.transl_CY   , detrep.process_desc)  AS process_desc_CY   
, COALESCE(transl.transl_CZ   , detrep.process_desc)  AS process_desc_CZ   
, COALESCE(transl.transl_DK   , detrep.process_desc)  AS process_desc_DK   
, COALESCE(transl.transl_EE   , detrep.process_desc)  AS process_desc_EE   
, COALESCE(transl.transl_ES   , detrep.process_desc)  AS process_desc_ES   
, COALESCE(transl.transl_FI   , detrep.process_desc)  AS process_desc_FI   
, COALESCE(transl.transl_FR   , detrep.process_desc)  AS process_desc_FR   
, COALESCE(transl.transl_GB   , detrep.process_desc)  AS process_desc_GB   
, COALESCE(transl.transl_GR   , detrep.process_desc)  AS process_desc_GR   
, COALESCE(transl.transl_HR   , detrep.process_desc)  AS process_desc_HR   
, COALESCE(transl.transl_HU   , detrep.process_desc)  AS process_desc_HU   
, COALESCE(transl.transl_IE   , detrep.process_desc)  AS process_desc_IE   
, COALESCE(transl.transl_IT   , detrep.process_desc)  AS process_desc_IT   
, COALESCE(transl.transl_LT   , detrep.process_desc)  AS process_desc_LT   
, COALESCE(transl.transl_LV   , detrep.process_desc)  AS process_desc_LV   
, COALESCE(transl.transl_MT   , detrep.process_desc)  AS process_desc_MT   
, COALESCE(transl.transl_NI   , detrep.process_desc)  AS process_desc_NI   
, COALESCE(transl.transl_NL   , detrep.process_desc)  AS process_desc_NL   
, COALESCE(transl.transl_PL   , detrep.process_desc)  AS process_desc_PL   
, COALESCE(transl.transl_PT   , detrep.process_desc)  AS process_desc_PT   
, COALESCE(transl.transl_RO   , detrep.process_desc)  AS process_desc_RO   
, COALESCE(transl.transl_RS   , detrep.process_desc)  AS process_desc_RS   
, COALESCE(transl.transl_SE   , detrep.process_desc)  AS process_desc_SE   
, COALESCE(transl.transl_SI   , detrep.process_desc)  AS process_desc_SI   
, COALESCE(transl.transl_SK   , detrep.process_desc)  AS process_desc_SK   
, COALESCE(transl.transl_US   , detrep.process_desc)  AS process_desc_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map_detail_reports_2 detrep
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_2 transl
ON transl.transl = TRIM(detrep.process_desc)
;
