CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.AUTDI_13_1(
	COUNTRY
	, ITEMNR_LONG
	, ITEM_NR
	, ITEMNR_LONG_DESC
	, STORE
	, ITEMDESC
	, ENTRYDATE
	, STORE_DAY
	, WAREHOUSEMIL
	, STATUS
	, STD
	, QUANTITY
	, MISSING_ITEMS
	, SUSPICIOUS_STOCK
	, STORE_DESC
	, WAREHOUSENO
	, SUBGROUP_DESC
	, SUBGROUP_NO
	, FAMILY_DESC
	, FAMILY_NO
	, RLZ_CUSTOMER
	, RLZ_STORE
	, RLZ_WH
) AS
    /* Version: 1.1
	** Author:	Dominik Pfarr
	** Date: 	2023-06-29
	** Changes:	remove Order Area from View definition
	*/
SELECT
  vm.country 
, vm.itemnr_long   
, vm.item_nr 
, vm.item_nr || ' - ' || vm.itemdesc AS itemnr_long_desc 
, vm.store  
, vm.itemdesc  
, vm.entrydate    
, vm.store || vm.entrydate AS Store_day   
, vm.warehousemil  
, vm.status   
, vm.STD  
, vm.quantity 
, CASE  WHEN vm.quantity=0 AND dd_param.param_value <> vm.item_nr THEN 1 ELSE 0 END AS missing_items  
, CASE  WHEN vm.quantity<>0 AND dd_param.param_value <> vm.item_nr THEN 1 ELSE 0 END AS  suspicious_stock   
, s.store_address store_desc  
, s.store_wh warehouseno  
, i.item_sub_group subgroup_desc 
, i.item_sub_group_nr subgroup_no  
, i.item_family_group family_desc   
, i.item_family_group_nr family_no 
, i.item_rlz_supplier rlz_customer   
, i.item_rlz_store rlz_store 
, i.item_rlz_warehouse rlz_wh
FROM core.t_oracle_v_fk_mil vm
    JOIN core.t_oracle_v_dim_item i 
        ON vm.item_nr = i.item_nr  
        AND vm.country = i.country
    JOIN core.t_oracle_v_dim_store s 
        ON s.store_nr=vm.store 
        AND s.country = vm.country
        AND s.deleted = 0
    LEFT OUTER JOIN core.t_oracle_v_dd_parameter dd_param 
        ON vm.country = dd_param.country
        AND dd_param.param_name = 'CONTROL_ITEM';