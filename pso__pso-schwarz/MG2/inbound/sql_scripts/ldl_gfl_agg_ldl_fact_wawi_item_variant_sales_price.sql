!SET exit_on_error=True;

BEGIN WORK;

-- Extract data
CREATE OR REPLACE TEMPORARY TABLE ETL.T_CACHE_FACT_WAWI_ITEM_VARIANT_SALES_PRICE AS
(select pgio.int_org_sid as INT_ORG_SID, 
        pgio.int_org_type_cd as INT_ORG_TYPE_CD, 
        itmv.COUNTRY_ORG_SID as COUNTRY_ORG_SID,
        itmv.COUNTRY_ORG_CD as COUNTRY_ORG_CD,
        imsp.wawi_item_variant_sid as WAWI_ITEM_VARIANT_SID, 
        itmv.WAWI_ITEM_SID as WAWI_ITEM_SID,
        -1 AS SALES_NET_PRICE,
        imsp.SALES_GROSS_PRICE AS SALES_GROSS_PRICE,
        -1 AS DEPOSIT_VAL,
        -1 AS TAX_PCT,
        imsp.CURR_CD AS CURR_CD,
        --
        CURRENT_TIMESTAMP as dwh_valid_from_tmsp,
        '9999-12-31 23:59:59.99999999' as dwh_valid_to_tmsp,
        TRUE as dwh_valid_fg,
        CURRENT_TIMESTAMP as dwh_created_tmsp,
        CURRENT_TIMESTAMP as dwh_updated_tmsp,
        imsp.dwh_load_id,
        imsp.dwh_node_cd,
        pgio.PRICE_GRP_PRIO, 
        Row_Number() over (partition by pgio.int_org_sid, 
                                        imsp.wawi_item_variant_sid 
                               order by pgio.PRICE_GRP_PRIO desc, pgio.DWH_VALID_FROM_TMSP desc, pgio.PRICE_GRP_SID desc) as rn
   from (select * from core_rel.t_wawi_item_variant_sales_price where dwh_valid_fg) as imsp
   join (select * from core_rel.t_wawi_item_variant where dwh_valid_fg) as itmv
     on imsp.wawi_item_variant_sid = itmv.wawi_item_variant_sid
   join (select * from core_rel.t_price_group  where dwh_valid_fg ) as pg
     on imsp.price_grp_sid = pg.price_grp_sid
   join (select * from core_rel.t_price_group_to_internal_organization where dwh_valid_fg) as pgio
     on pg.price_grp_sid = pgio.price_grp_sid
   join (select * from core_rel.t_internal_organization where dwh_valid_fg) as io
     on pgio.INT_ORG_SID = io.INT_ORG_SID     
 -- where pgio.int_org_sid = 8659 and imsp.wawi_item_variant_sid = 557849
  );

CREATE OR REPLACE TEMPORARY TABLE ETL.T_CACHE_FACT_WAWI_ITEM_VARIANT_SALES_PRICE_HST AS
select src.*,
       CASE WHEN tgt.int_org_sid IS NULL THEN 'INS'
            WHEN tgt.int_org_sid IS NOT NULL  
             AND ( NOT EQUAL_NULL( src.country_org_sid, tgt.country_org_sid)
                     OR NOT EQUAL_NULL( src.country_org_cd, tgt.country_org_cd)
                     OR NOT EQUAL_NULL( src.wawi_item_sid, tgt.wawi_item_sid)
                     OR NOT EQUAL_NULL( src.CURR_CD, tgt.curr_cd)
                     OR NOT EQUAL_NULL( src.sales_net_price, tgt.sales_net_price)
                     OR NOT EQUAL_NULL( src.sales_gross_price, tgt.sales_gross_price)
                     OR NOT EQUAL_NULL( src.deposit_val, tgt.deposit_val)
                     OR NOT EQUAL_NULL( src.tax_pct, tgt.tax_pct)
                   ) THEN 'UPD'
             ELSE 'NCH'
         END as ACT
  from (select * from ETL.T_CACHE_FACT_WAWI_ITEM_VARIANT_SALES_PRICE where rn = 1) as src
  LEFT JOIN (select * from core_dim.t_fact_wawi_item_variant_sales_price where dwh_valid_fg) as tgt
     ON src.int_org_sid = tgt.int_org_sid
    AND src.wawi_item_variant_sid = tgt.wawi_item_variant_sid
;

-- Exipire existing records
MERGE INTO core_dim.t_fact_wawi_item_variant_sales_price AS tgt
USING (select * from ETL.T_CACHE_FACT_WAWI_ITEM_VARIANT_SALES_PRICE_HST where rn =1 ) AS src
   ON tgt.int_org_sid = src.int_org_sid
  AND tgt.wawi_item_variant_sid = src.wawi_item_variant_sid
  AND tgt.dwh_valid_fg 
  AND src.ACT in ( 'INS', 'UPD')
 WHEN MATCHED AND ACT = 'UPD' THEN UPDATE SET 
      dwh_valid_to_tmsp = src.dwh_valid_from_tmsp - INTERVAL '1 nanosecond',
      dwh_valid_fg = FALSE,
      dwh_updated_tmsp = src.dwh_updated_tmsp
 WHEN NOT MATCHED AND ACT = 'INS' THEN INSERT (
      int_org_sid,
      int_org_type_cd,
      country_org_sid,
      country_org_cd,
      wawi_item_variant_sid,
      wawi_item_sid,
      dwh_valid_from_tmsp,
      dwh_valid_to_tmsp,
      dwh_valid_fg,
      sales_net_price,
      sales_gross_price,
      deposit_val,
      tax_pct,
      curr_cd,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd)
VALUES (
      src.int_org_sid,
      src.int_org_type_cd,
      src.country_org_sid,
      src.country_org_cd,
      src.wawi_item_variant_sid,
      src.wawi_item_sid,
      '1900-01-01 00:00:00.0000000'::TIMESTAMP /* dwh_valid_from_tmsp */,
      src.dwh_valid_from_tmsp - INTERVAL '1 nanosecond' /* dwh_valid_to_tmsp */,
      false /* dwh_valid_fg */,
      src.sales_net_price,
      src.sales_gross_price,
      src.deposit_val,
      src.tax_pct,
      src.curr_cd,
      src.dwh_created_tmsp,
      src.dwh_updated_tmsp,
      src.dwh_load_id,
      src.dwh_node_cd)
;

-- Insert updated records
INSERT INTO core_dim.t_fact_wawi_item_variant_sales_price 
(
      int_org_sid,
      int_org_type_cd,
      country_org_sid,
      country_org_cd,
      wawi_item_variant_sid,
      wawi_item_sid,
      dwh_valid_from_tmsp,
      dwh_valid_to_tmsp,
      dwh_valid_fg,
      sales_net_price,
      sales_gross_price,
      deposit_val,
      tax_pct,
      curr_cd,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd)
select 
      src.int_org_sid,
      src.int_org_type_cd,
      src.country_org_sid,
      src.country_org_cd,
      src.wawi_item_variant_sid,
      src.wawi_item_sid,
      src.dwh_valid_from_tmsp,
      src.dwh_valid_to_tmsp,
      src.dwh_valid_fg,
      src.sales_net_price,
      src.sales_gross_price,
      src.deposit_val,
      src.tax_pct,
      src.curr_cd,
      src.dwh_created_tmsp,
      src.dwh_updated_tmsp,
      src.dwh_load_id,
      src.dwh_node_cd
 from ETL.T_CACHE_FACT_WAWI_ITEM_VARIANT_SALES_PRICE_HST as src
where ACT in ( 'INS', 'UPD') and rn =1 
;


COMMIT;
