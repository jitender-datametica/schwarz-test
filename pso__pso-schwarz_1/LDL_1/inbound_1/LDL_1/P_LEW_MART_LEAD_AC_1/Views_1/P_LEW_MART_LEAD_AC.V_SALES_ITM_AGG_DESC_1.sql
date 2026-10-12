CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_SALES_ITM_AGG_DESC_1
(
  cy_week_partial_week_id
, client_id
, region_id
, region_desc
, wh_id
, wh_id_exp
, wh_desc
, aspect_id
, aspect_desc
, store_id
, move_store_desc
, account_manager_id
, account_manager_name
, sales_manager_id
, sales_manager_name
, cy
, adv_week_int
, adv_wt_nr_int
, adv_desc_int
, adv_short_desc_int
, cy_week
, parent_wh_id
, parent_desc
, dashboard_relevant_fg
, country_group_id
, country_group_desc
, cy_week_sequence
, itemgroup_int_id
, item_id
, orig_item_nr
, dat_valid_from
, orig_item_nr_int
, fa_sales_deliv_pcs
, fa_sales_stc
, fa_sales_excl_day
, fa_sales_1_day_pcs
, fa_sales_3_day_pcs
, fa_sales_7_day_pcs
, nf_sales_deliv_pcs
, nf_sales_stc
, nf_sales_excl_day
, nf_sales_1_day_pcs
, nf_sales_3_day_pcs
, nf_sales_7_day_pcs
, country_desc_AT
, country_desc_BE
, country_desc_BG
, country_desc_CH
, country_desc_CY
, country_desc_CZ
, country_desc
, country_desc_DK
, country_desc_ES
, country_desc_FI
, country_desc_FR
, country_desc_GB
, country_desc_GR
, country_desc_HR
, country_desc_HU
, country_desc_IE
, country_desc_IT
, country_desc_LT
, country_desc_NI
, country_desc_NL
, country_desc_DE
, country_desc_PL
, country_desc_PT
, country_desc_RO
, country_desc_SE
, country_desc_SI
, country_desc_SK
, country_desc_CS
, country_desc_MT
, country_desc_US
, country_desc_RS
, cy_week_desc_AT
, cy_week_desc_BE
, cy_week_desc_BG
, cy_week_desc_CH
, cy_week_desc_CY
, cy_week_desc_CZ
, cy_week_desc
, cy_week_desc_DK
, cy_week_desc_EE
, cy_week_desc_ES
, cy_week_desc_FI
, cy_week_desc_FR
, cy_week_desc_GB
, cy_week_desc_GR
, cy_week_desc_HR
, cy_week_desc_HU
, cy_week_desc_IE
, cy_week_desc_IT
, cy_week_desc_LT
, cy_week_desc_LV
, cy_week_desc_NI
, cy_week_desc_NL
, cy_week_desc_DE
, cy_week_desc_PL
, cy_week_desc_PT
, cy_week_desc_RO
, cy_week_desc_SE
, cy_week_desc_SI
, cy_week_desc_SK
, cy_week_desc_CS
, cy_week_desc_MT
, cy_week_desc_US
, cy_week_desc_RS
, itemgroup_int_desc_AT
, itemgroup_int_desc_BE
, itemgroup_int_desc_BG
, itemgroup_int_desc_CH
, itemgroup_int_desc_CY
, itemgroup_int_desc_CZ
, itemgroup_int_desc
, itemgroup_int_desc_DK
, itemgroup_int_desc_ES
, itemgroup_int_desc_FI
, itemgroup_int_desc_FR
, itemgroup_int_desc_GB
, itemgroup_int_desc_GR
, itemgroup_int_desc_HR
, itemgroup_int_desc_HU
, itemgroup_int_desc_IE
, itemgroup_int_desc_IT
, itemgroup_int_desc_LT
, itemgroup_int_desc_NI
, itemgroup_int_desc_NL
, itemgroup_int_desc_DE
, itemgroup_int_desc_PL
, itemgroup_int_desc_PT
, itemgroup_int_desc_RO
, itemgroup_int_desc_SE
, itemgroup_int_desc_SI
, itemgroup_int_desc_SK
, itemgroup_int_desc_CS
, itemgroup_int_desc_MT
, itemgroup_int_desc_US
, itemgroup_int_desc_RS
, item_desc_AT
, item_desc_BE
, item_desc_BG
, item_desc_CH
, item_desc_CY
, item_desc_CZ
, item_desc
, item_desc_DK
, item_desc_ES
, item_desc_FI
, item_desc_FR
, item_desc_GB
, item_desc_GR
, item_desc_HR
, item_desc_HU
, item_desc_IE
, item_desc_IT
, item_desc_LT
, item_desc_NI
, item_desc_NL
, item_desc_DE
, item_desc_PL
, item_desc_PT
, item_desc_RO
, item_desc_SE
, item_desc_SI
, item_desc_SK
, item_desc_CS
, item_desc_MT
, item_desc_US
, item_desc_RS
, adv_desc_int_AT
, adv_desc_int_BE
, adv_desc_int_BG
, adv_desc_int_CH
, adv_desc_int_CY
, adv_desc_int_CZ
, adv_desc_int_DK
, adv_desc_int_EE
, adv_desc_int_ES
, adv_desc_int_FI
, adv_desc_int_FR
, adv_desc_int_GB
, adv_desc_int_GR
, adv_desc_int_HR
, adv_desc_int_HU
, adv_desc_int_IE
, adv_desc_int_IT
, adv_desc_int_LT
, adv_desc_int_LV
, adv_desc_int_NI
, adv_desc_int_NL
, adv_desc_int_DE
, adv_desc_int_PL
, adv_desc_int_PT
, adv_desc_int_RO
, adv_desc_int_SE
, adv_desc_int_SI
, adv_desc_int_SK
, adv_desc_int_CS
, adv_desc_int_MT
, adv_desc_int_US
, adv_desc_int_RS
)
AS
   SELECT
     cy_week_partial_week_id,
   client_id,
   region_id,
   region_desc,
   wh_id,
   wh_id_exp,
   wh_desc,
   aspect_id,
   aspect_desc,
   store_id,
   move_store_desc,
   account_manager_id,
   account_manager_name,
   sales_manager_id,
   sales_manager_name,
   cy,
   adv_week_int,
   adv_wt_nr_int,
   adv_desc_int,
   adv_short_desc_int,
   cy_week,
   parent_wh_id,
   parent_desc,
   dashboard_relevant_fg,
   country_group_id,
   country_group_desc,
   cy_week_sequence,
   itemgroup_int_id,
   item_id,
   orig_item_nr,
   dat_valid_from,
   orig_item_nr_int,
   fa_sales_deliv_pcs,
   fa_sales_stc,
   fa_sales_excl_day,
   fa_sales_1_day_pcs,
   fa_sales_3_day_pcs,
   fa_sales_7_day_pcs,
   nf_sales_deliv_pcs,
   nf_sales_stc,
   nf_sales_excl_day,
   nf_sales_1_day_pcs,
   nf_sales_3_day_pcs,
   nf_sales_7_day_pcs,
   country_desc_AT,
   country_desc_BE,
   country_desc_BG,
   country_desc_CH,
   country_desc_CY,
   country_desc_CZ,
   country_desc,
   country_desc_DK,
   country_desc_ES,
   country_desc_FI,
   country_desc_FR,
   country_desc_GB,
   country_desc_GR,
   country_desc_HR,
   country_desc_HU,
   country_desc_IE,
   country_desc_IT,
   country_desc_LT,
   country_desc_NI,
   country_desc_NL,
   country_desc_DE,
   country_desc_PL,
   country_desc_PT,
   country_desc_RO,
   country_desc_SE,
   country_desc_SI,
   country_desc_SK,
   country_desc_CS,
   country_desc_MT,
   country_desc_US,
   country_desc_RS,
   cy_week_desc_AT,
   cy_week_desc_BE,
   cy_week_desc_BG,
   cy_week_desc_CH,
   cy_week_desc_CY,
   cy_week_desc_CZ,
   cy_week_desc,
   cy_week_desc_DK,
   cy_week_desc_EE,
   cy_week_desc_ES,
   cy_week_desc_FI,
   cy_week_desc_FR,
   cy_week_desc_GB,
   cy_week_desc_GR,
   cy_week_desc_HR,
   cy_week_desc_HU,
   cy_week_desc_IE,
   cy_week_desc_IT,
   cy_week_desc_LT,
   cy_week_desc_LV,
   cy_week_desc_NI,
   cy_week_desc_NL,
   cy_week_desc_DE,
   cy_week_desc_PL,
   cy_week_desc_PT,
   cy_week_desc_RO,
   cy_week_desc_SE,
   cy_week_desc_SI,
   cy_week_desc_SK,
   cy_week_desc_CS,
   cy_week_desc_MT,
   cy_week_desc_US,
   cy_week_desc_RS,
   itemgroup_int_desc_AT,
   itemgroup_int_desc_BE,
   itemgroup_int_desc_BG,
   itemgroup_int_desc_CH,
   itemgroup_int_desc_CY,
   itemgroup_int_desc_CZ,
   itemgroup_int_desc,
   itemgroup_int_desc_DK,
   itemgroup_int_desc_ES,
   itemgroup_int_desc_FI,
   itemgroup_int_desc_FR,
   itemgroup_int_desc_GB,
   itemgroup_int_desc_GR,
   itemgroup_int_desc_HR,
   itemgroup_int_desc_HU,
   itemgroup_int_desc_IE,
   itemgroup_int_desc_IT,
   itemgroup_int_desc_LT,
   itemgroup_int_desc_NI,
   itemgroup_int_desc_NL,
   itemgroup_int_desc_DE,
   itemgroup_int_desc_PL,
   itemgroup_int_desc_PT,
   itemgroup_int_desc_RO,
   itemgroup_int_desc_SE,
   itemgroup_int_desc_SI,
   itemgroup_int_desc_SK,
   itemgroup_int_desc_CS,
   itemgroup_int_desc_MT,
   itemgroup_int_desc_US,
   itemgroup_int_desc_RS,
   item_desc_AT,
   item_desc_BE,
   item_desc_BG,
   item_desc_CH,
   item_desc_CY,
   item_desc_CZ,
   item_desc,
   item_desc_DK,
   item_desc_ES,
   item_desc_FI,
   item_desc_FR,
   item_desc_GB,
   item_desc_GR,
   item_desc_HR,
   item_desc_HU,
   item_desc_IE,
   item_desc_IT,
   item_desc_LT,
   item_desc_NI,
   item_desc_NL,
   item_desc_DE,
   item_desc_PL,
   item_desc_PT,
   item_desc_RO,
   item_desc_SE,
   item_desc_SI,
   item_desc_SK,
   item_desc_CS,
   item_desc_MT,
   item_desc_US,
   item_desc_RS,
   adv_desc_int_AT,
   adv_desc_int_BE,
   adv_desc_int_BG,
   adv_desc_int_CH,
   adv_desc_int_CY,
   adv_desc_int_CZ,
   adv_desc_int_DK,
   adv_desc_int_EE,
   adv_desc_int_ES,
   adv_desc_int_FI,
   adv_desc_int_FR,
   adv_desc_int_GB,
   adv_desc_int_GR,
   adv_desc_int_HR,
   adv_desc_int_HU,
   adv_desc_int_IE,
   adv_desc_int_IT,
   adv_desc_int_LT,
   adv_desc_int_LV,
   adv_desc_int_NI,
   adv_desc_int_NL,
   adv_desc_int_DE,
   adv_desc_int_PL,
   adv_desc_int_PT,
   adv_desc_int_RO,
   adv_desc_int_SE,
   adv_desc_int_SI,
   adv_desc_int_SK,
   adv_desc_int_CS,
   adv_desc_int_MT,
   adv_desc_int_US,
   adv_desc_int_RS
  FROM p_lew_mart_lead.t_sales_itm_agg_desc_1

;