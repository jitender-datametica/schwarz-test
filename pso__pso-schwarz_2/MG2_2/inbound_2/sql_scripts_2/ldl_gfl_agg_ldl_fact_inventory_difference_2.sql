!SET exit_on_error=True;

BEGIN WORK;

/*
#----------------------------------------------------------------------------
# @ LIDL GFL
#----------------------------------------------------------------------------
# Script: ldl_fact_inventory_difference.sql
#----------------------------------------------------------------------------
# Related objects:
#   CORE_REL.T_INVENTORY_2 
#   CORE_REL.T_INVENTORY_STATISTICS_2  
# History:
			
#  1.00	05.03.2025 Yücel Cesmeli
		 - Initial script
*/

DELETE FROM core_dim.t_fact_inventory_difference_2;

INSERT INTO core_dim.t_fact_inventory_difference_2
(
   inv_sid
,  inv_type_cd
,  inv_dt
,  int_org_sid
,  int_org_type_cd
,  country_org_cd
--,  calc_stock_net_val
,  inv_net_val
,  inv_diff_net_val
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
    --NULL AS calc_stock_gross_val, -- t_stock_2 table is not filled up yet
    inv_net.inv_stat_val AS inv_net_val,
    diff.inv_stat_val AS inv_diff_net_val,
    tnov.inv_stat_val AS turnover_net_val,
    COALESCE(org.curr_cd, '@') as curr_cd,
    CURRENT_TIMESTAMP AS dwh_created_tmsp,
    CURRENT_TIMESTAMP AS dwh_updated_tmsp,
    '${LOAD_ID}' AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd
FROM
    core_rel.t_inventory_2 inv
    INNER JOIN core_rel.t_inventory_statistics_2 tnov ON inv.inv_sid = tnov.inv_sid
    AND tnov.inv_stat_type_cd = 'TURNOVER_NET'
    AND tnov.dwh_valid_fg
    INNER JOIN core_rel.t_inventory_statistics_2 diff ON inv.inv_sid = diff.inv_sid
    AND diff.inv_stat_type_cd = 'DIFF_NET'
    AND diff.dwh_valid_fg
    INNER JOIN core_rel.t_inventory_statistics_2 inv_net ON inv.inv_sid = inv_net.inv_sid
    AND inv_net.inv_stat_type_cd = 'INVENTORY_NET'
    AND inv_net.dwh_valid_fg
    LEFT OUTER JOIN core_rel.t_internal_organization_2 org ON org.int_org_sid = inv.country_org_sid
    AND org.dwh_valid_fg
WHERE
    inv.inv_type_cd = 'FULL' --We have net statistics for only Full inventory
;


COMMIT;
