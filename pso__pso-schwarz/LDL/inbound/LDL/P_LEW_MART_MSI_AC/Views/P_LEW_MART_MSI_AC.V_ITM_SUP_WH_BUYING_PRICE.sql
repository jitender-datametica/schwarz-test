CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_SUP_WH_BUYING_PRICE
/*
#DescStart#
#$Revision: 7174 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , wh_id
    , item_id
    , supplier_id
    , dat_rec_start
    , dat_rec_end
    , dat_valid_from
    , dat_valid_until
    , dat_valid_until_group
    , currency_nr
    , currency_nr_special
    , group_nr
    , delivery_item_cd
    , dur_shelflife_cust
    , period_id_shelflife_cust
    , dur_shelflife_store
    , period_id_shelflife_store
    , dur_shelflife_wh
    , period_id_shelflife_wh
    , price_buying
    , price_buying_special
)
AS
SELECT
client_id,
wh_id,
item_id,
supplier_id,
dat_rec_start,
dat_rec_end,
dat_valid_from,
dat_valid_until,
dat_valid_until_group,
currency_nr,
currency_nr_special,
group_nr,
delivery_item_cd,
dur_shelflife_cust,
period_id_shelflife_cust,
dur_shelflife_store,
period_id_shelflife_store,
dur_shelflife_wh,
period_id_shelflife_wh,
price_buying,
price_buying_special
FROM p_lew_mart_msi.v_itm_sup_wh_buying_price
;


