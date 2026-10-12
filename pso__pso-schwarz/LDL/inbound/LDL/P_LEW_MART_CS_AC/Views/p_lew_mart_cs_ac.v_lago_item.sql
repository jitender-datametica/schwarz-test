CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_lago_item
(
  client_id                                    
  , country_iso_cd   
  , item_id
  , orig_item_nr
  , orig_item_nr_int
  , case_size_lago
  , valid_from
  , valid_until
  , brand_name
  , item_actiongroup_id
  , item_sub_actiongroup_id
  , is_plu_item
  , buying_list_type_id
  , plu_nr
  , unitsize
  , buying_employee_skey
  , buying_employee_name
  , subitemgroup_id
  , int_subitemgroup_id
  , itemstatus_cd
  , packagetype_desc  
  , item_familygroup_id
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT
  i.client_id                                    
  , i.country_iso_cd   
  , i.item_id
  , i.orig_item_nr
  , i.orig_item_nr_int
  , i.case_size_lago
  , i.valid_from
  , i.valid_until
  , i.brand_name
  , i.item_actiongroup_id
  , i.item_sub_actiongroup_id
  , i.is_plu_item
  , i.buying_list_type_id
  , i.plu_nr
  , i.unitsize
  , i.buying_employee_skey
  , i.buying_employee_name
  , i.subitemgroup_id
  , i.int_subitemgroup_id
  , i.itemstatus_cd
  , i.packagetype_desc    
  , i.item_familygroup_id  
  , i.cs_updated
  , i.cs_created
  , i.cs_load_id
FROM P_LEW_MART_CS.v_lago_item AS i ;