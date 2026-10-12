INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}  (
       wawi_item_sid,
       country_org_sid,
       country_org_cd,
       wawi_item_nr,
       wawi_item_name,
       wawi_item_descr,
       wawi_item_creation_dt,
       wawi_item_status_cd,
       wawi_item_status_descr,
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
select itm.wawi_item_sid,
       itm.country_org_sid,
       itm.country_org_cd,
       itm.wawi_item_nr,
       itm.wawi_item_name,
       itm.wawi_item_descr,
       itm.wawi_item_creation_dt,
       '@' as wawi_item_status_cd,
       'Unbekannt'  as wawi_item_status_descr,
       coalesce (pg1.prod_grp_sid ,'-1') as item_fam_sid,
       coalesce (pg1.prod_grp_nr ,'@') as item_fam_nr,
       coalesce (pg1.prod_grp_name  ,'Unbekannt') as item_fam_name,
       coalesce (pg2.prod_grp_sid ,'-1') as sub_item_grp_sid,
       coalesce (pg2.prod_grp_nr ,'@') as sub_item_grp_nr,
       coalesce (pg2.prod_grp_name ,'Unbekannt') as sub_item_grp_name,
       coalesce (pg3.prod_grp_sid ,-1) as int_item_grp_sid,
       coalesce (pg3.prod_grp_nr ,'@') as int_item_grp_nr,
       coalesce (pg3.prod_grp_name ,'Unbekannt') as int_item_grp_name,
       0 as food_fg,
       ${LOAD_ID} as dwh_load_id,
       itm.dwh_node_cd,
       itm.dwh_valid_from_tmsp as dwh_mapping_tmsp,
       0 as tf_error_fg,
       '' as error_descr,
       0 as record_id,
       '${SRC_INPUT_TABLE}' as filename,
       0 as deleted_fg
  from core_rel.t_wawi_item_2 as itm
  left join core_rel.t_wawi_item_to_product_group_2 as itmpg -- Item_2 to the Item_2-Family-Group
    on itm.wawi_item_sid = itmpg.wawi_item_sid
   and itmpg.prod_grp_type_cd = 'IFG' -- Item_2-Family-Group
     and itmpg.dwh_valid_fg
  left join core_rel.t_product_group_2 as pg1 -- Item_2-Family-Group
    on itmpg.prod_grp_sid = pg1.prod_grp_sid
   and pg1.dwh_valid_fg  
  left join core_rel.t_product_group_hierarchy_2 as pgh1 -- Item_2-Family-Group to the Sub-Item_2-Group
    on pg1.prod_grp_sid = pgh1.prod_grp_sid
   and pgh1.prod_grp_hierarchy_type_cd = 'IGH' -- Item_2-Group-Hierarchy_2
   and pgh1.dwh_valid_fg
  left join core_rel.t_product_group_2 as pg2 -- Sub-Item_2-Group
    on pgh1.parent_prod_grp_sid = pg2.prod_grp_sid 
   and pg2.dwh_valid_fg
  left join core_rel.t_product_group_hierarchy_2 as pgh2 -- Sub-Item_2-Group to the Item_2-Group-International
    on pg2.prod_grp_sid = pgh2.prod_grp_sid 
   and pgh2.prod_grp_hierarchy_type_cd = 'IGH' -- Item_2-Group-Hierarchy_2
   and pgh2.dwh_valid_fg
  left join core_rel.t_product_group_2 as pg3 -- Item_2-Group-International
    on pgh2.parent_prod_grp_sid = pg3.prod_grp_sid 
   and pg3.dwh_valid_fg
where itm.dwh_valid_fg
;
