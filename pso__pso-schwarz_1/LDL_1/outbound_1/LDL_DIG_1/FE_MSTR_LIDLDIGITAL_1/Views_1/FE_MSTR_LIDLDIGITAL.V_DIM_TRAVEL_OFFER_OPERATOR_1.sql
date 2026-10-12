CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_offer_operator_1 (trav_offer_operator_cd,
trav_offer_operator_descr) AS SELECT trav_offer_operator_cd,
 CAST(trav_offer_operator_descr AS STRING) AS trav_offer_operator_descr
FROM ldl_dig_lec_share.v_dim_travel_offer_operator_core_view_1
UNION ALL
SELECT '-1',
 '';