/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_ref_hier_cockpit_cp_type_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_ref_hier_cockpit_cp_type_transl
(
  cockpit_type_id
, cockpit_type_desc
, cockpit_type_desc_AT   
, cockpit_type_desc_BE   
, cockpit_type_desc_BE_fr
, cockpit_type_desc_BG   
, cockpit_type_desc_CH   
, cockpit_type_desc_CS   
, cockpit_type_desc_CY   
, cockpit_type_desc_CZ   
, cockpit_type_desc_DK   
, cockpit_type_desc_EE   
, cockpit_type_desc_ES   
, cockpit_type_desc_FI   
, cockpit_type_desc_FR   
, cockpit_type_desc_GB   
, cockpit_type_desc_GR   
, cockpit_type_desc_HR   
, cockpit_type_desc_HU   
, cockpit_type_desc_IE   
, cockpit_type_desc_IT   
, cockpit_type_desc_LT   
, cockpit_type_desc_LV   
, cockpit_type_desc_MT   
, cockpit_type_desc_NI   
, cockpit_type_desc_NL   
, cockpit_type_desc_PL   
, cockpit_type_desc_PT   
, cockpit_type_desc_RO   
, cockpit_type_desc_RS   
, cockpit_type_desc_SE   
, cockpit_type_desc_SI   
, cockpit_type_desc_SK   
, cockpit_type_desc_US   
)
AS
SELECT
  ref_hier.cockpit_type_id
, ref_hier.cockpit_type_desc
, COALESCE(transl.transl_AT   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_AT   
, COALESCE(transl.transl_BE   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_BE   
, COALESCE(transl.transl_BE_fr, ref_hier.cockpit_type_desc) AS cockpit_type_desc_BE_fr
, COALESCE(transl.transl_BG   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_BG   
, COALESCE(transl.transl_CH   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_CH   
, COALESCE(transl.transl_CS   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_CS   
, COALESCE(transl.transl_CY   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_CY   
, COALESCE(transl.transl_CZ   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_CZ   
, COALESCE(transl.transl_DK   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_DK   
, COALESCE(transl.transl_EE   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_EE   
, COALESCE(transl.transl_ES   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_ES   
, COALESCE(transl.transl_FI   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_FI   
, COALESCE(transl.transl_FR   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_FR   
, COALESCE(transl.transl_GB   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_GB   
, COALESCE(transl.transl_GR   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_GR   
, COALESCE(transl.transl_HR   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_HR   
, COALESCE(transl.transl_HU   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_HU   
, COALESCE(transl.transl_IE   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_IE   
, COALESCE(transl.transl_IT   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_IT   
, COALESCE(transl.transl_LT   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_LT   
, COALESCE(transl.transl_LV   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_LV   
, COALESCE(transl.transl_MT   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_MT   
, COALESCE(transl.transl_NI   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_NI   
, COALESCE(transl.transl_NL   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_NL   
, COALESCE(transl.transl_PL   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_PL   
, COALESCE(transl.transl_PT   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_PT   
, COALESCE(transl.transl_RO   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_RO   
, COALESCE(transl.transl_RS   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_RS   
, COALESCE(transl.transl_SE   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_SE   
, COALESCE(transl.transl_SI   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_SI   
, COALESCE(transl.transl_SK   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_SK   
, COALESCE(transl.transl_US   , ref_hier.cockpit_type_desc) AS cockpit_type_desc_US   
FROM P_LEW_MART_LEAD.t_ref_hier_cockpit_2_0 ref_hier
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0 transl
ON transl.transl = TRIM(ref_hier.cockpit_type_desc)
;

