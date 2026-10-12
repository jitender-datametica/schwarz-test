CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_warehouse_allocation_entity_2 (wh_alloc_entity_cd,
wh_alloc_entity_descr, wh_alloc_entity_country_cd, wh_alloc_entity_country_display_order_nr, wh_alloc_entity_group_cd)
AS SELECT wh_alloc_entity_cd,
 wh_alloc_entity_descr,
 wh_alloc_entity_country_cd,
 wh_alloc_entity_display_order_nr AS wh_alloc_entity_country_display_order_nr,
 wh_alloc_entity_group_cd
FROM ldl_dig_lec_share.v_dim_warehouse_allocation_entity_2
UNION ALL
SELECT '-1',
 '',
 '',
 1000,
 '';