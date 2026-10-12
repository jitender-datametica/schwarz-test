INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}  (
       wawi_item_variant_sid,
       wawi_item_sid,
       country_org_sid,
       country_org_cd,
       wawi_item_variant_nr,
       wawi_item_variant_name,
       wawi_item_variant_descr,
       wawi_item_variant_creation_dt,
       wawi_country_status_id,
       wawi_country_status_descr,
       wawi_wh_status_id,
       wawi_wh_status_descr,
       case_size_cnt,
       weight_based_fg,
       item_fam_sid,
       item_fam_nr,
       item_fam_name,
       sub_item_grp_sid,
       sub_item_grp_nr,
       sub_item_grp_name,
       int_item_grp_sid,
       int_item_grp_nr,
       int_item_grp_name,
       food_fg,
       dwh_load_id,
       dwh_node_cd,
       dwh_mapping_tmsp,
       tf_error_fg,
       error_descr,
       record_id,
       filename,
       deleted_fg)
select itmvnt.wawi_item_variant_sid,
       itmvnt.wawi_item_sid,
       itmvnt.country_org_sid,
       itmvnt.country_org_cd,
       itmvnt.wawi_item_variant_nr,
       itmvnt.wawi_item_variant_name,
       itmvnt.wawi_item_variant_descr,
       itmvnt.wawi_item_variant_creation_dt,
       -1 as wawi_country_status_id,
       'Unbekannt' as wawi_country_status_descr,
       -1 as  wawi_wh_status_id,
       'Unbekannt' as wawi_wh_status_descr,
       itmvnt.case_size_cnt,
       itmvnt.weight_based_fg,
       coalesce (pg1.prod_grp_sid ,-1) as item_fam_sid,
       coalesce (pg1.prod_grp_nr ,'@') as item_fam_nr,
       coalesce (pg1.prod_grp_name  ,'Unbekannt') as item_fam_name,
       coalesce (pg2.prod_grp_sid ,-1) as sub_item_grp_sid,
       coalesce (pg2.prod_grp_nr ,'@') as sub_item_grp_nr,
       coalesce (pg2.prod_grp_name ,'Unbekannt') as sub_item_grp_name,
       coalesce (pg3.prod_grp_sid ,-1) as int_item_grp_sid,
       coalesce (pg3.prod_grp_nr ,'@') as int_item_grp_nr,
       coalesce (pg3.prod_grp_name ,'Unbekannt') as int_item_grp_name,
       false as food_fg,
       --
       ${LOAD_ID} as dwh_load_id,
       itmvnt.dwh_node_cd,
       itmvnt.dwh_valid_from_tmsp as dwh_mapping_tmsp,
       0 as tf_error_fg,
       '' as error_descr,
       0 as record_id,
       '${SRC_INPUT_TABLE}' as filename,
       0 as deleted_fg
  from core_rel.t_wawi_item_variant as itmvnt
  left join core_rel.t_wawi_item as itm
    on itmvnt.wawi_item_sid = itm.wawi_item_sid
   and itm.dwh_valid_fg
  left join core_rel.t_wawi_item_to_product_group as itmpg -- Item to the Item-Family-Group
    on itm.wawi_item_sid = itmpg.wawi_item_sid
   and itmpg.prod_grp_type_cd = 'IFG' -- Item-Family-Group
     and itmpg.dwh_valid_fg
  left join core_rel.t_product_group as pg1 -- Item-Family-Group
    on itmpg.prod_grp_sid = pg1.prod_grp_sid
   and pg1.dwh_valid_fg  
  left join core_rel.t_product_group_hierarchy as pgh1 -- Item-Family-Group to the Sub-Item-Group
    on pg1.prod_grp_sid = pgh1.prod_grp_sid
   and pgh1.prod_grp_hierarchy_type_cd = 'IGH' -- Item-Group-Hierarchy
   and pgh1.dwh_valid_fg
  left join core_rel.t_product_group as pg2 -- Sub-Item-Group
    on pgh1.parent_prod_grp_sid = pg2.prod_grp_sid 
--   and pg2.prod_grp_type_cd = 'SIG'   /*REDUNDANT, WOULD DELETE THE LINE*/
   and pg2.dwh_valid_fg
  left join core_rel.t_product_group_hierarchy as pgh2 -- Sub-Item-Group to the Item-Group-International
    on pg2.prod_grp_sid = pgh2.prod_grp_sid 
   and pgh2.prod_grp_hierarchy_type_cd = 'IGH' -- Item-Group-Hierarchy
   and pgh2.dwh_valid_fg
  left join core_rel.t_product_group as pg3 -- Item-Group-International
    on pgh2.parent_prod_grp_sid = pg3.prod_grp_sid 
   and pg3.dwh_valid_fg
where itmvnt.dwh_valid_fg
;
