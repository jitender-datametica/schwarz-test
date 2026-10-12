/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_cp_type_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_cp_type_transl_1
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
FROM P_LEW_MART_LEAD.v_ref_hier_cockpit_cp_type_transl_1
;

