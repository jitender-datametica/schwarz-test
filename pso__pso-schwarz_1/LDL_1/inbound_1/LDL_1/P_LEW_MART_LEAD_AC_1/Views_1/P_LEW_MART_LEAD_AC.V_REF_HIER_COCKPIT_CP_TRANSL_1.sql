/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_cp_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_cp_transl_1
(
  cockpit_id
, cockpit_desc
, cockpit_desc_AT   
, cockpit_desc_BE   
, cockpit_desc_BE_fr
, cockpit_desc_BG   
, cockpit_desc_CH   
, cockpit_desc_CS   
, cockpit_desc_CY   
, cockpit_desc_CZ   
, cockpit_desc_DK   
, cockpit_desc_EE   
, cockpit_desc_ES   
, cockpit_desc_FI   
, cockpit_desc_FR   
, cockpit_desc_GB   
, cockpit_desc_GR   
, cockpit_desc_HR   
, cockpit_desc_HU   
, cockpit_desc_IE   
, cockpit_desc_IT   
, cockpit_desc_LT   
, cockpit_desc_LV   
, cockpit_desc_MT   
, cockpit_desc_NI   
, cockpit_desc_NL   
, cockpit_desc_PL   
, cockpit_desc_PT   
, cockpit_desc_RO   
, cockpit_desc_RS   
, cockpit_desc_SE   
, cockpit_desc_SI   
, cockpit_desc_SK   
, cockpit_desc_US   
)
AS
SELECT
  cockpit_id
, cockpit_desc
, cockpit_desc_AT   
, cockpit_desc_BE   
, cockpit_desc_BE_fr
, cockpit_desc_BG   
, cockpit_desc_CH   
, cockpit_desc_CS   
, cockpit_desc_CY   
, cockpit_desc_CZ   
, cockpit_desc_DK   
, cockpit_desc_EE   
, cockpit_desc_ES   
, cockpit_desc_FI   
, cockpit_desc_FR   
, cockpit_desc_GB   
, cockpit_desc_GR   
, cockpit_desc_HR   
, cockpit_desc_HU   
, cockpit_desc_IE   
, cockpit_desc_IT   
, cockpit_desc_LT   
, cockpit_desc_LV   
, cockpit_desc_MT   
, cockpit_desc_NI   
, cockpit_desc_NL   
, cockpit_desc_PL   
, cockpit_desc_PT   
, cockpit_desc_RO   
, cockpit_desc_RS   
, cockpit_desc_SE   
, cockpit_desc_SI   
, cockpit_desc_SK   
, cockpit_desc_US   
FROM P_LEW_MART_LEAD.v_ref_hier_cockpit_cp_transl_1
;

