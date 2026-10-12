/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_transl_cockpit_2_0
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_ref_transl_cockpit_2_0
(
  transl
, transl_AT     
, transl_BE     
, transl_BE_fr  
, transl_BG     
, transl_CH     
, transl_CS     
, transl_CY     
, transl_CZ     
, transl_DK     
, transl_EE     
, transl_ES     
, transl_FI     
, transl_FR     
, transl_GB     
, transl_GR     
, transl_HR     
, transl_HU     
, transl_IE     
, transl_IT     
, transl_LT     
, transl_LV     
, transl_MT     
, transl_NI     
, transl_NL     
, transl_PL     
, transl_PT     
, transl_RO     
, transl_RS     
, transl_SE     
, transl_SI     
, transl_SK     
, transl_US     
)
AS
SELECT
  transl
, transl_AT     
, transl_BE     
, transl_BE_fr  
, transl_BG     
, transl_CH     
, transl_CS     
, transl_CY     
, transl_CZ     
, transl_DK     
, transl_EE     
, transl_ES     
, transl_FI     
, transl_FR     
, transl_GB     
, transl_GR     
, transl_HR     
, transl_HU     
, transl_IE     
, transl_IT     
, transl_LT     
, transl_LV     
, transl_MT     
, transl_NI     
, transl_NL     
, transl_PL     
, transl_PT     
, transl_RO     
, transl_RS     
, transl_SE     
, transl_SI     
, transl_SK     
, transl_US     
FROM P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0
;
