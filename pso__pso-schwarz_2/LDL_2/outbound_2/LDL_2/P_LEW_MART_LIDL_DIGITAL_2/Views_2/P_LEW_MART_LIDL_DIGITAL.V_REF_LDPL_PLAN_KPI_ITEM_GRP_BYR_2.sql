/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_ldpl_plan_kpi_item_grp_byr_2 (client_id
OPTIONS(description='Identifier for client'), byr OPTIONS(description='Business year number'), itemgroup_int_id
OPTIONS(description='Item_2 group identifier'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Currency tot identifier'), lp_advertising_discount_busyear
OPTIONS(description='Plan value for Lidl Plus advertising discount in EUR. Used for data patch'),
non_lp_advertising_discount_busyear
OPTIONS(description='Plan value for Total advertising discount in EUR. Used for data patch'),
total_advertising_discount_busyear_old
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch. No data sent since 2025'),
total_advertising_discount_busyear
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch. New field added in 2025'),
loyalty_advertising_discount_busyear
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'),
promo_advertising_discount_busyear
OPTIONS(description='Plan value for Promo advertising discount in EUR. Used for data patch'), lp_advertising_discount_fa
OPTIONS(description='Plan value for Lidl Plus advertising discount food aktion_2 in EUR. Used for data patch'),
non_lp_advertising_discount_fa
OPTIONS(description='Plan value for Total advertising discount food aktion_2 in EUR. Used for data patch'),
total_advertising_discount_fa_old
OPTIONS(description='Plan value for Non Lidl Plus advertising food aktion_2 discount in EUR. Used for data. No data sent since 2025'),
total_advertising_discount_fa
OPTIONS(description='Plan value for Non Lidl Plus advertising food aktion_2 discount in EUR. Used for data patch. New field added in 2025'),
loyalty_advertising_discount_fa
OPTIONS(description='Plan value for Loyalty advertising food aktion_2 discount in EUR. Used for data patch'),
promo_advertising_discount_fa
OPTIONS(description='Plan value for Promo advertising food aktion_2 discount in EUR. Used for data patch'),
total_unsold_item_procedure
OPTIONS(description='Plan value for Total unsold item_2 procedure in EUR. Used for data patch'),
total_permanent_discount_price_area_diff
OPTIONS(description='Plan value for Total permanent discount price area difference in EUR. Used for data patch'),
total_net_val_eur_plan_busyear OPTIONS(description='Plan value for total revenue net value. Used for data patch'),
total_net_val_eur_plan_fa OPTIONS(description='Plan value for total revenue Food Aktion_2 net value. Used for data patch'),
dwh_load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time')) AS WITH CTE_CURR_RATE AS (SELECT client_id,
    currency_iso_cd,
    curr_tot_id,
    to_currency_iso_cd,
    rate_currency_exchange
   FROM ldl_p_lew_mart_msi.v_ref_currency_2 AS C
   WHERE local_currency_fg = 0
   UNION ALL
   SELECT client_id,
    currency_iso_cd,
    curr_tot_id,
    currency_iso_cd AS to_currency_iso_cd,
    1 AS rate_currency_exchange
   FROM ldl_p_lew_mart_msi.v_ref_currency_2 AS C
   WHERE currency_iso_cd = 'EUR'
     /* CTE CREATED TO OBTAIN LIST OF EXCHANGE RATES IN ORDER TO POPULATE LOCAL CURRENCIES AND EUR FOR NON EU COUNTRIES */
     ) (SELECT P.client_id,
   P.byr,
   P.itemgroup_int_id,
   C.to_currency_iso_cd AS currency_iso_cd,
    CASE
    WHEN C.to_currency_iso_cd = 'EUR'
    THEN 0
    ELSE P.client_id
    END AS curr_tot_id,
    P.lp_advertising_discount * C.rate_currency_exchange AS lp_advertising_discount_busyear_loc,
    P.non_lp_advertising_discount * C.rate_currency_exchange AS non_lp_advertising_discount_busyear_loc,
    P.total_advertising_discount * C.rate_currency_exchange AS total_advertising_discount_busyear_loc,
     (IFNULL(P.loyalty_advertising_discount, 0) + IFNULL(P.promo_advertising_discount, 0)) * C.rate_currency_exchange AS
   total_advertising_discount_busyear_new_loc,
    P.loyalty_advertising_discount * C.rate_currency_exchange AS loyalty_advertising_discount_busyear_loc,
    P.promo_advertising_discount * C.rate_currency_exchange AS promo_advertising_discount_busyear_loc,
    P.lp_advertising_discount_fa * C.rate_currency_exchange AS lp_advertising_discount_fa_loc,
    P.non_lp_advertising_discount_fa * C.rate_currency_exchange AS non_lp_advertising_discount_fa_loc,
    P.total_advertising_discount_fa * C.rate_currency_exchange AS total_advertising_discount_fa_loc,
     (IFNULL(P.loyalty_advertising_discount_fa, 0) + IFNULL(P.promo_advertising_discount_fa, 0)) * C.rate_currency_exchange
     AS total_advertising_discount_fa_new_loc,
    P.loyalty_advertising_discount_fa * C.rate_currency_exchange AS loyalty_advertising_discount_fa_loc,
    P.promo_advertising_discount_fa * C.rate_currency_exchange AS promo_advertising_discount_fa_loc,
    P.total_unsold_item_procedure * C.rate_currency_exchange AS total_unsold_item_procedure_loc,
    P.total_permanent_discount_price_area_diff * C.rate_currency_exchange AS
   total_permanent_discount_price_area_diff_loc,
    P.total_net_val_eur_plan * C.rate_currency_exchange AS total_net_val_eur_plan_busyear_loc,
    P.total_net_val_eur_plan_fa * C.rate_currency_exchange AS total_net_val_eur_plan_fa_loc,
   P.dwh_load_id,
   P.dwh_created,
   P.dwh_updated
  FROM ldl_p_lew_mart_lidl_digital.t_ref_ldpl_plan_kpi_item_grp_byr_2 AS P
   INNER JOIN CTE_CURR_RATE AS C ON P.client_id = C.client_id AND P.currency_iso_cd = C.currency_iso_cd);