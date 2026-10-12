CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ADV_INT_DESC_2

(
 cy
, adv_week_int
, adv_wt_nr_int
, adv_desc_int
, adv_short_desc_int
, adv_desc_int_AT
, adv_short_desc_int_AT
, adv_desc_int_BE
, adv_short_desc_int_BE
, adv_desc_int_BG
, adv_short_desc_int_BG
, adv_desc_int_CH
, adv_short_desc_int_CH
, adv_desc_int_CY
, adv_short_desc_int_CY
, adv_desc_int_CZ
, adv_short_desc_int_CZ
, adv_desc_int_DK
, adv_short_desc_int_DK
, adv_desc_int_EE
, adv_short_desc_int_EE
, adv_desc_int_ES
, adv_short_desc_int_ES
, adv_desc_int_FI
, adv_short_desc_int_FI
, adv_desc_int_FR
, adv_short_desc_int_FR
, adv_desc_int_GB
, adv_short_desc_int_GB
, adv_desc_int_GR
, adv_short_desc_int_GR
, adv_desc_int_HR
, adv_short_desc_int_HR
, adv_desc_int_HU
, adv_short_desc_int_HU
, adv_desc_int_IE
, adv_short_desc_int_IE
, adv_desc_int_IT
, adv_short_desc_int_IT
, adv_desc_int_LT
, adv_short_desc_int_LT
, adv_desc_int_LV
, adv_short_desc_int_LV
, adv_desc_int_NI
, adv_short_desc_int_NI
, adv_desc_int_NL
, adv_short_desc_int_NL
, adv_desc_int_DE
, adv_short_desc_int_DE
, adv_desc_int_PL
, adv_short_desc_int_PL
, adv_desc_int_PT
, adv_short_desc_int_PT
, adv_desc_int_RO
, adv_short_desc_int_RO
, adv_desc_int_SE
, adv_short_desc_int_SE
, adv_desc_int_SI
, adv_short_desc_int_SI
, adv_desc_int_SK
, adv_short_desc_int_SK
, adv_desc_int_CS
, adv_short_desc_int_CS
, adv_desc_int_MT
, adv_short_desc_int_MT
, adv_desc_int_US
, adv_short_desc_int_US
, adv_desc_int_RS
, adv_short_desc_int_RS
, cy_week
)
AS
   SELECT
     cy,
   adv_week_int,
   adv_wt_nr_int,
   adv_desc_int,
   adv_short_desc_int,
   adv_desc_int_AT,
   adv_short_desc_int_AT,
   adv_desc_int_BE,
   adv_short_desc_int_BE,
   adv_desc_int_BG,
   adv_short_desc_int_BG,
   adv_desc_int_CH,
   adv_short_desc_int_CH,
   adv_desc_int_CY,
   adv_short_desc_int_CY,
   adv_desc_int_CZ,
   adv_short_desc_int_CZ,
   adv_desc_int_DK,
   adv_short_desc_int_DK,
   adv_desc_int_EE,
   adv_short_desc_int_EE,
   adv_desc_int_ES,
   adv_short_desc_int_ES,
   adv_desc_int_FI,
   adv_short_desc_int_FI,
   adv_desc_int_FR,
   adv_short_desc_int_FR,
   adv_desc_int_GB,
   adv_short_desc_int_GB,
   adv_desc_int_GR,
   adv_short_desc_int_GR,
   adv_desc_int_HR,
   adv_short_desc_int_HR,
   adv_desc_int_HU,
   adv_short_desc_int_HU,
   adv_desc_int_IE,
   adv_short_desc_int_IE,
   adv_desc_int_IT,
   adv_short_desc_int_IT,
   adv_desc_int_LT,
   adv_short_desc_int_LT,
   adv_desc_int_LV,
   adv_short_desc_int_LV,
   adv_desc_int_NI,
   adv_short_desc_int_NI,
   adv_desc_int_NL,
   adv_short_desc_int_NL,
   adv_desc_int_DE,
   adv_short_desc_int_DE,
   adv_desc_int_PL,
   adv_short_desc_int_PL,
   adv_desc_int_PT,
   adv_short_desc_int_PT,
   adv_desc_int_RO,
   adv_short_desc_int_RO,
   adv_desc_int_SE,
   adv_short_desc_int_SE,
   adv_desc_int_SI,
   adv_short_desc_int_SI,
   adv_desc_int_SK,
   adv_short_desc_int_SK,
   adv_desc_int_CS,
   adv_short_desc_int_CS,
   adv_desc_int_MT,
   adv_short_desc_int_MT,
   adv_desc_int_US,
   adv_short_desc_int_US,
   adv_desc_int_RS,
   adv_short_desc_int_RS,
   cy_week
  FROM p_lew_mart_lead.v_adv_int_desc_2;