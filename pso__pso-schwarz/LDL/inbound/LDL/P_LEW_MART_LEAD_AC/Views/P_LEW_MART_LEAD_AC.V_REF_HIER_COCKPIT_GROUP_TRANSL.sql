/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_group_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_group_transl
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
FROM P_LEW_MART_LEAD.v_ref_hier_cockpit_group_transl
;

