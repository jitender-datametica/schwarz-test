--!SET exit_on_error=True;


BEGIN TRANSACTION;


-- Extract data
create or replace temporary table t_cache_fact_wawi_item_variant_sales_price
  as
    select
        pgio.int_org_sid as int_org_sid,
        pgio.int_org_type_cd as int_org_type_cd,
        itmv.country_org_sid as country_org_sid,
        itmv.country_org_cd as country_org_cd,
        imsp.wawi_item_variant_sid as wawi_item_variant_sid,
        itmv.wawi_item_sid as wawi_item_sid,
        -numeric '1' as sales_net_price,
        imsp.sales_gross_price as sales_gross_price,
        -numeric '1' as deposit_val,
        -numeric '1' as tax_pct,
        imsp.curr_cd as curr_cd,
        --
        current_timestamp() as dwh_valid_from_tmsp,
        '9999-12-31 23:59:59.99999999' as dwh_valid_to_tmsp,
        true as dwh_valid_fg,
        current_timestamp() as dwh_created_tmsp,
        current_timestamp() as dwh_updated_tmsp,
        imsp.dwh_load_id,
        imsp.dwh_node_cd,
        pgio.price_grp_prio,
        row_number() over (partition by pgio.int_org_sid, imsp.wawi_item_variant_sid order by if(pgio.price_grp_prio is null, 0, 1), pgio.price_grp_prio desc, if(pgio.dwh_valid_from_tmsp is null, 0, 1), pgio.dwh_valid_from_tmsp desc, if(pgio.price_grp_sid is null, 0, 1), pgio.price_grp_sid desc) as rn
      from
        (
          select
              *
            from
              ldl_data_production_core_rel.t_wawi_item_variant_sales_price_2
            where t_wawi_item_variant_sales_price.dwh_valid_fg
        ) as imsp
        inner join (
          select
              *
            from
              ldl_data_production_core_rel.t_wawi_item_variant_2
            where t_wawi_item_variant.dwh_valid_fg
        ) as itmv on imsp.wawi_item_variant_sid = itmv.wawi_item_variant_sid
        inner join (
          select
              *
            from
              ldl_data_production_core_rel.t_price_group_2
            where t_price_group.dwh_valid_fg
        ) as pg on imsp.price_grp_sid = pg.price_grp_sid
        inner join (
          select
              *
            from
              ldl_data_production_core_rel.t_price_group_to_internal_organization_2
            where t_price_group_to_internal_organization.dwh_valid_fg
        ) as pgio on pg.price_grp_sid = pgio.price_grp_sid
        inner join (
          select
              *
            from
              ldl_data_production_core_rel.t_internal_organization_2
            where t_internal_organization.dwh_valid_fg
        ) as io on pgio.int_org_sid = io.int_org_sid
;
-- where pgio.int_org_sid = 8659 and imsp.wawi_item_variant_sid = 557849



COMMIT TRANSACTION;




CREATE OR REPLACE TEMPORARY TABLE t_cache_fact_wawi_item_variant_sales_price_hst AS
SELECT src.int_org_sid,
 src.int_org_type_cd,
 src.country_org_sid,
 src.country_org_cd,
 src.wawi_item_variant_sid,
 src.wawi_item_sid,
 src.sales_net_price,
 src.sales_gross_price,
 src.deposit_val,
 src.tax_pct,
 src.curr_cd,
 src.dwh_valid_from_tmsp,
 src.dwh_valid_to_tmsp,
 src.dwh_valid_fg,
 src.dwh_created_tmsp,
 src.dwh_updated_tmsp,
 src.dwh_load_id,
 src.dwh_node_cd,
 src.price_grp_prio,
 src.rn,
  CASE
  WHEN tgt.int_org_sid IS NULL
  THEN 'INS'
  WHEN (src.country_org_sid IS DISTINCT FROM tgt.country_org_sid OR src.country_org_cd IS DISTINCT FROM tgt.country_org_cd
             OR src.wawi_item_sid IS DISTINCT FROM tgt.wawi_item_sid OR src.curr_cd IS DISTINCT FROM tgt.curr_cd OR src
         .sales_net_price IS DISTINCT FROM tgt.sales_net_price OR src.sales_gross_price IS DISTINCT FROM tgt.sales_gross_price
         OR src.deposit_val IS DISTINCT FROM tgt.deposit_val OR src.tax_pct IS DISTINCT FROM tgt.tax_pct) AND tgt.int_org_sid
   IS NOT NULL
  THEN 'UPD'
  ELSE 'NCH'
  END AS act
FROM (SELECT *
  FROM t_cache_fact_wawi_item_variant_sales_price
  WHERE rn = 1) AS src
 LEFT JOIN (SELECT *
  FROM ldl_data_production_core_dim.t_fact_wawi_item_variant_sales_price_2
  WHERE dwh_valid_fg) AS tgt ON src.int_org_sid = tgt.int_org_sid AND src.wawi_item_variant_sid = tgt.wawi_item_variant_sid;


BEGIN TRANSACTION;


-- commenting this merge statement as table ETL.T_CACHE_FACT_WAWI_ITEM_VARIANT_SALES_PRICE_HST is out of scope as per delivery

-- Exipire existing records
-- MERGE INTO LDL_DATA_PRODUCTION.core_dim.t_fact_wawi_item_variant_sales_price_2 AS tgt
-- USING (select * from LDL_DATA_PRODUCTION.ETL.T_CACHE_FACT_WAWI_ITEM_VARIANT_SALES_PRICE_HST where rn =1 ) AS src
--    ON tgt.int_org_sid = src.int_org_sid
--   AND tgt.wawi_item_variant_sid = src.wawi_item_variant_sid
--   AND tgt.dwh_valid_fg 
--   AND src.ACT in ( 'INS', 'UPD')
--  WHEN MATCHED AND ACT = 'UPD' THEN UPDATE SET 
--       dwh_valid_to_tmsp = src.dwh_valid_from_tmsp - INTERVAL '1 nanosecond',
--       dwh_valid_fg = FALSE,
--       dwh_updated_tmsp = src.dwh_updated_tmsp
--  WHEN NOT MATCHED AND ACT = 'INS' THEN INSERT (
--       int_org_sid,
--       int_org_type_cd,
--       country_org_sid,
--       country_org_cd,
--       wawi_item_variant_sid,
--       wawi_item_sid,
--       dwh_valid_from_tmsp,
--       dwh_valid_to_tmsp,
--       dwh_valid_fg,
--       sales_net_price,
--       sales_gross_price,
--       deposit_val,
--       tax_pct,
--       curr_cd,
--       dwh_created_tmsp,
--       dwh_updated_tmsp,
--       dwh_load_id,
--       dwh_node_cd)
-- VALUES (
--       src.int_org_sid,
--       src.int_org_type_cd,
--       src.country_org_sid,
--       src.country_org_cd,
--       src.wawi_item_variant_sid,
--       src.wawi_item_sid,
--       '1900-01-01 00:00:00.0000000'::TIMESTAMP /* dwh_valid_from_tmsp */,
--       src.dwh_valid_from_tmsp - INTERVAL '1 nanosecond' /* dwh_valid_to_tmsp */,
--       false /* dwh_valid_fg */,
--       src.sales_net_price,
--       src.sales_gross_price,
--       src.deposit_val,
--       src.tax_pct,
--       src.curr_cd,
--       src.dwh_created_tmsp,
--       src.dwh_updated_tmsp,
--       src.dwh_load_id,
--       src.dwh_node_cd)
-- ;

-- Insert updated records


INSERT INTO ldl_data_production_core_dim.t_fact_wawi_item_variant_sales_price_2 (int_org_sid, int_org_type_cd,
 country_org_sid, country_org_cd, wawi_item_variant_sid, wawi_item_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 dwh_valid_fg, sales_net_price, sales_gross_price, deposit_val, tax_pct, curr_cd, dwh_created_tmsp, dwh_updated_tmsp,
 dwh_load_id, dwh_node_cd)
(SELECT int_org_sid,
  int_org_type_cd,
  country_org_sid,
  country_org_cd,
  wawi_item_variant_sid,
  wawi_item_sid,
  dwh_valid_from_tmsp,
  CAST(dwh_valid_to_tmsp AS TIMESTAMP) AS dwh_valid_to_tmsp,
  dwh_valid_fg,
  sales_net_price,
  sales_gross_price,
  deposit_val,
  tax_pct,
  curr_cd,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
 FROM t_cache_fact_wawi_item_variant_sales_price_hst AS src
 WHERE act IN ('INS', 'UPD')
  AND rn = 1);


COMMIT TRANSACTION;