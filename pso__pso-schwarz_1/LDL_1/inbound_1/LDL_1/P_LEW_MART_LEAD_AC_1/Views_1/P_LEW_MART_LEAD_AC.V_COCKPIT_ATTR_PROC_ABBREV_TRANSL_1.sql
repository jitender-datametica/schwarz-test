/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_abbrev_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_abbrev_transl_1
(
  identifier_id
, identifier_flag
, process_sorting
, process_abbreviation
, process_abbreviation_AT   
, process_abbreviation_BE   
, process_abbreviation_BE_fr
, process_abbreviation_BG   
, process_abbreviation_CH   
, process_abbreviation_CS   
, process_abbreviation_CY   
, process_abbreviation_CZ   
, process_abbreviation_DK   
, process_abbreviation_EE   
, process_abbreviation_ES   
, process_abbreviation_FI   
, process_abbreviation_FR   
, process_abbreviation_GB   
, process_abbreviation_GR   
, process_abbreviation_HR   
, process_abbreviation_HU   
, process_abbreviation_IE   
, process_abbreviation_IT   
, process_abbreviation_LT   
, process_abbreviation_LV   
, process_abbreviation_MT   
, process_abbreviation_NI   
, process_abbreviation_NL   
, process_abbreviation_PL   
, process_abbreviation_PT   
, process_abbreviation_RO   
, process_abbreviation_RS   
, process_abbreviation_SE   
, process_abbreviation_SI   
, process_abbreviation_SK   
, process_abbreviation_US   
)
AS
SELECT
  identifier_id
, identifier_flag
, process_sorting
, process_abbreviation
, process_abbreviation_AT   
, process_abbreviation_BE   
, process_abbreviation_BE_fr
, process_abbreviation_BG   
, process_abbreviation_CH   
, process_abbreviation_CS   
, process_abbreviation_CY   
, process_abbreviation_CZ   
, process_abbreviation_DK   
, process_abbreviation_EE   
, process_abbreviation_ES   
, process_abbreviation_FI   
, process_abbreviation_FR   
, process_abbreviation_GB   
, process_abbreviation_GR   
, process_abbreviation_HR   
, process_abbreviation_HU   
, process_abbreviation_IE   
, process_abbreviation_IT   
, process_abbreviation_LT   
, process_abbreviation_LV   
, process_abbreviation_MT   
, process_abbreviation_NI   
, process_abbreviation_NL   
, process_abbreviation_PL   
, process_abbreviation_PT   
, process_abbreviation_RO   
, process_abbreviation_RS   
, process_abbreviation_SE   
, process_abbreviation_SI   
, process_abbreviation_SK   
, process_abbreviation_US   
FROM P_LEW_MART_LEAD.v_cockpit_attr_proc_abbrev_transl_1
;
