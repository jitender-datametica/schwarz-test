!SET exit_on_error=True;

/*
#----------------------------------------------------------------------------
# @ LIDL GFL
#----------------------------------------------------------------------------
# Script: t_fact_inventory_difference_by_wawi_item.sql
#----------------------------------------------------------------------------
# Related objects:
#   CORE_REL.T_INVENTORY 
#   CORE_REL.T_WAWI_INVENTORY_RESULT  
#   CORE_REL.T_PRODUCT_RETAIL_LINE  
# History:
			
#  1.00	03.04.2025 Yücel Cesmeli
		 - Initial script
*/

CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.delta_keys AS (
    SELECT DISTINCT  
           src.dwh_cal_dt AS inv_dt
         , src.loc_sid AS int_org_sid
      FROM etl.VT1 AS src
);


BEGIN WORK;

DELETE FROM core_dim.t_fact_inventory_difference_by_wawi_item agg
USING ETL.vt1 b
WHERE b.country_cd = agg.country_org_cd
AND b.dwh_cal_dt = agg.inv_dt
AND b.loc_sid = agg.int_org_sid; 

INSERT INTO core_dim.t_fact_inventory_difference_by_wawi_item
(
   inv_sid
,  inv_type_cd
,  inv_dt
,  int_org_sid
,  int_org_type_cd
,  country_org_cd
,  wawi_item_sid
--,  calc_sales_unit_cnt --Dependency on t_wawi_stock table which is not implemented yet
,  inv_sales_unit_cnt
,  inv_diff_sales_unit_cnt
--,  calc_qty            --Dependency on t_wawi_stock table which is not implemented yet
,  inv_qty
,  inv_diff_qty
,  uom_cd
--,  calc_stock_net_val  --Dependency on item unit net price which requires Vat subject to calculate net price
--,  inv_net_val         --Dependency on item unit net price which requires Vat subject to calculate net price
--,  inv_diff_net_val    --Dependency on item unit net price which requires Vat subject to calculate net price
,  turnover_net_val
,  curr_cd
,  dwh_created_tmsp
,  dwh_updated_tmsp
,  dwh_load_id
,  dwh_node_cd
)
SELECT 
    inv.inv_sid,
    inv.inv_type_cd,
    inv.inv_dt,
    inv.int_org_sid,
    inv.int_org_type_cd,
    inv.country_org_cd,
    inv.wawi_item_sid,
    --calc_sales_unit_cnt 
    inv.inv_sales_unit_cnt,
    inv.inv_diff_sales_unit_cnt,
    --calc_qty
    inv.inv_qty,
    inv.inv_diff_qty,
    coalesce(inv.uom_cd,'@') as uom_cd, 
    --calc_stock_net_val
    --inv_net_val
    --inv_diff_net_val
    inv.turnover_net,
    COALESCE(org.curr_cd,'@')as curr_cd,
    CURRENT_TIMESTAMP AS dwh_created_tmsp,
    CURRENT_TIMESTAMP AS dwh_updated_tmsp,
    '${LOAD_ID}' AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd
FROM
(
select 
wir.inv_sid,
wir.wawi_item_sid,
any_value(wir.inv_type_cd) as inv_type_cd,
any_value(wir.inv_dt) as inv_dt,
any_value(wir.int_org_sid) as int_org_sid,
any_value(wir.int_org_type_cd) as int_org_type_cd,
any_value(wir.country_org_cd) as country_org_cd,
   --calc_sales_unit_cnt 
any_value(wir.inv_sales_unit_cnt) as inv_sales_unit_cnt,
any_value(wir.inv_diff_sales_unit_cnt) as inv_diff_sales_unit_cnt,
    --calc_qty
any_value(wir.inv_qty) as inv_qty,
any_value(wir.inv_diff_qty) as inv_diff_qty,
any_value(wir.uom_cd) as uom_cd,
any_value(wir.country_org_sid) as country_org_sid,
sum(prl.cash_register_sales_net_val) as turnover_net
from core_rel.t_wawi_inventory_result wir
inner join core_rel.t_inventory inv
ON inv.inv_sid=wir.inv_sid
AND wir.DWH_VALID_FG
AND wir.inv_type_cd='FULL'
left outer join CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY_WAWI_ITEM prl
ON prl.wawi_item_sid=wir.wawi_item_sid
and prl.store_sid=wir.int_org_sid
and prl.country_org_cd=wir.country_org_cd
AND prl.bus_dt between inv.inv_period_start_dt and inv.inv_period_end_dt
INNER JOIN ${FWRK_WORK_DB}.delta_keys dk
ON dk.int_org_sid = wir.int_org_sid
AND dk.inv_dt = inv.inv_dt
group by 
wir.inv_sid,
wir.wawi_item_sid

UNION ALL

select 
wir.inv_sid,
wir.wawi_item_sid,
any_value(wir.inv_type_cd) as inv_type_cd,
any_value(wir.inv_dt) as inv_dt,
any_value(wir.int_org_sid) as int_org_sid,
any_value(wir.int_org_type_cd) as int_org_type_cd,
any_value(wir.country_org_cd) as country_org_cd,
   --calc_sales_unit_cnt 
any_value(wir.inv_sales_unit_cnt) as inv_sales_unit_cnt,
any_value(wir.inv_diff_sales_unit_cnt) as inv_diff_sales_unit_cnt,
    --calc_qty
any_value(wir.inv_qty) as inv_qty,
any_value(wir.inv_diff_qty) as inv_diff_qty,
any_value(wir.uom_cd) as uom_cd,
any_value(wir.country_org_sid) as country_org_sid,
sum(prl.cash_register_sales_net_val) as turnover_net
from core_rel.t_wawi_inventory_result wir
left outer join CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY_WAWI_ITEM prl
ON prl.wawi_item_sid=wir.wawi_item_sid
and prl.store_sid=wir.int_org_sid
and prl.bus_dt=wir.inv_dt
and prl.country_org_cd=wir.country_org_cd
INNER JOIN ${FWRK_WORK_DB}.delta_keys dk
ON dk.int_org_sid = wir.int_org_sid
AND dk.inv_dt = wir.inv_dt
AND wir.DWH_VALID_FG
AND wir.inv_type_cd='PART'
group by 
wir.inv_sid,
wir.wawi_item_sid
) inv 

INNER JOIN core_dim.T_DIM_INTERNAL_ORGANIZATION org ON org.int_org_sid=inv.country_org_sid
AND org.dwh_valid_fg
And current_timestamp between org.dwh_valid_from_tmsp and org.dwh_valid_to_tmsp

ORDER BY inv.inv_dt
;

COMMIT;
