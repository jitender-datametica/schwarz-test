/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_ref_hier_cockpit_group_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_ref_hier_cockpit_group_transl_2
(
  group_id
, group_desc
, group_desc_AT   
, group_desc_BE   
, group_desc_BE_fr
, group_desc_BG   
, group_desc_CH   
, group_desc_CS   
, group_desc_CY   
, group_desc_CZ   
, group_desc_DK   
, group_desc_EE   
, group_desc_ES   
, group_desc_FI   
, group_desc_FR   
, group_desc_GB   
, group_desc_GR   
, group_desc_HR   
, group_desc_HU   
, group_desc_IE   
, group_desc_IT   
, group_desc_LT   
, group_desc_LV   
, group_desc_MT   
, group_desc_NI   
, group_desc_NL   
, group_desc_PL   
, group_desc_PT   
, group_desc_RO   
, group_desc_RS   
, group_desc_SE   
, group_desc_SI   
, group_desc_SK   
, group_desc_US   
)
AS
SELECT
  ref_hier.group_id
, ref_hier.group_desc
, COALESCE(transl.transl_AT   , ref_hier.group_desc) AS group_desc_AT   
, COALESCE(transl.transl_BE   , ref_hier.group_desc) AS group_desc_BE   
, COALESCE(transl.transl_BE_fr, ref_hier.group_desc) AS group_desc_BE_fr
, COALESCE(transl.transl_BG   , ref_hier.group_desc) AS group_desc_BG   
, COALESCE(transl.transl_CH   , ref_hier.group_desc) AS group_desc_CH   
, COALESCE(transl.transl_CS   , ref_hier.group_desc) AS group_desc_CS   
, COALESCE(transl.transl_CY   , ref_hier.group_desc) AS group_desc_CY   
, COALESCE(transl.transl_CZ   , ref_hier.group_desc) AS group_desc_CZ   
, COALESCE(transl.transl_DK   , ref_hier.group_desc) AS group_desc_DK   
, COALESCE(transl.transl_EE   , ref_hier.group_desc) AS group_desc_EE   
, COALESCE(transl.transl_ES   , ref_hier.group_desc) AS group_desc_ES   
, COALESCE(transl.transl_FI   , ref_hier.group_desc) AS group_desc_FI   
, COALESCE(transl.transl_FR   , ref_hier.group_desc) AS group_desc_FR   
, COALESCE(transl.transl_GB   , ref_hier.group_desc) AS group_desc_GB   
, COALESCE(transl.transl_GR   , ref_hier.group_desc) AS group_desc_GR   
, COALESCE(transl.transl_HR   , ref_hier.group_desc) AS group_desc_HR   
, COALESCE(transl.transl_HU   , ref_hier.group_desc) AS group_desc_HU   
, COALESCE(transl.transl_IE   , ref_hier.group_desc) AS group_desc_IE   
, COALESCE(transl.transl_IT   , ref_hier.group_desc) AS group_desc_IT   
, COALESCE(transl.transl_LT   , ref_hier.group_desc) AS group_desc_LT   
, COALESCE(transl.transl_LV   , ref_hier.group_desc) AS group_desc_LV   
, COALESCE(transl.transl_MT   , ref_hier.group_desc) AS group_desc_MT   
, COALESCE(transl.transl_NI   , ref_hier.group_desc) AS group_desc_NI   
, COALESCE(transl.transl_NL   , ref_hier.group_desc) AS group_desc_NL   
, COALESCE(transl.transl_PL   , ref_hier.group_desc) AS group_desc_PL   
, COALESCE(transl.transl_PT   , ref_hier.group_desc) AS group_desc_PT   
, COALESCE(transl.transl_RO   , ref_hier.group_desc) AS group_desc_RO   
, COALESCE(transl.transl_RS   , ref_hier.group_desc) AS group_desc_RS   
, COALESCE(transl.transl_SE   , ref_hier.group_desc) AS group_desc_SE   
, COALESCE(transl.transl_SI   , ref_hier.group_desc) AS group_desc_SI   
, COALESCE(transl.transl_SK   , ref_hier.group_desc) AS group_desc_SK   
, COALESCE(transl.transl_US   , ref_hier.group_desc) AS group_desc_US   
FROM P_LEW_MART_LEAD.t_ref_hier_cockpit_2_0_2 ref_hier
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_2 transl
ON transl.transl = TRIM(ref_hier.group_desc)
;

