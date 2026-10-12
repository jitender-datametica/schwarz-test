-- 1. Create temp table
create or replace volatile table _check_nielsen_mat_kjmo as
(
  select 
    a.mandant_id,
    SUBSTR(a.per_tag, 2, 4)||SUBSTR(a.per_tag, 7, 2) as nielsen_kjwo,
    b.kjmo 
  from ${TEMP_TABLE} a
  join dbp_data.tag b on nielsen_kjwo = b.kjwo 
  where 
    b.wtag_id = 1
    and (a.mandant_id, a.per_tag) in (
      select mandant_id, max(per_tag) as per_tag 
      from ${TEMP_TABLE} 
      group by 1
    ) 
  group by 1, 2, 3
);

-- 2. Update temp table with the calculated month
update ${TEMP_TABLE} from (select mandant_id, kjmo from _check_nielsen_mat_kjmo group by 1, 2) b
set MAT_KJMO = b.kjmo
where
  ${TEMP_TABLE}.mandant_id = b.mandant_id and
  ${TEMP_TABLE}.MAT_KJMO is null;

-- 3. Cleanup existing data in Fact table
delete from dbp_etl.nielsen_fact 
where (MANDANT_ID, MAT_KJMO) in (select mandant_id, kjmo from _check_nielsen_mat_kjmo group by 1, 2);

-- 4. Insert data from temp to Fact table
INSERT INTO dbp_etl.nielsen_fact (
  MANDANT_ID, MAT_KJMO, FILE_NAME, MKT_TAG, PROD_TAG, PER_TAG,
  SALES_ITEM, SALES_UNIT, SALES_VALUE, NUMERIC_DISTRIBUTION,
  WEIGHTED_DISTRIBUTION, AVG_PRICE_UNIT, AVG_PRICE_ITEM,
  MENGE, MENGE_SA, MENGE_AF, UMSATZ_NETTO, UMSATZ_NETTO_SA,
  UMSATZ_NETTO_AF, DISTRIBUTION_NUMERISCH, DISTRIBUTION_GEWICHTET,
  ANZ_MAERKTE, DISTR_NUM_4_WO, DISTR_GEW_4_WO, TD_UPDATE, TD_INSERT
)
SELECT 
  MANDANT_ID, MAT_KJMO, FILE_NAME, MKT_TAG, PROD_TAG, PER_TAG,
  SALES_ITEM, SALES_UNIT, SALES_VALUE, NUMERIC_DISTRIBUTION,
  WEIGHTED_DISTRIBUTION, AVG_PRICE_UNIT, AVG_PRICE_ITEM,
  MENGE, MENGE_SA, MENGE_AF, UMSATZ_NETTO, UMSATZ_NETTO_SA,
  UMSATZ_NETTO_AF, DISTRIBUTION_NUMERISCH, DISTRIBUTION_GEWICHTET,
  ANZ_MAERKTE, DISTR_NUM_4_WO, DISTR_GEW_4_WO, TD_UPDATE, TD_INSERT
FROM ${TEMP_TABLE};

-- 5. Set MAT_KJMO in Market and Product tables
delete from dbp_etl.nielsen_mkt 
where (MANDANT_ID, MAT_KJMO) in (select mandant_id, kjmo from _check_nielsen_mat_kjmo group by 1, 2);

delete from dbp_etl.nielsen_prod 
where (MANDANT_ID, MAT_KJMO) in (select mandant_id, kjmo from _check_nielsen_mat_kjmo group by 1, 2);

update dbp_etl.nielsen_mkt from (select mandant_id, kjmo from _check_nielsen_mat_kjmo group by 1, 2) b
set MAT_KJMO = b.kjmo
where
  dbp_etl.nielsen_mkt.mandant_id = b.mandant_id and
  dbp_etl.nielsen_mkt.MAT_KJMO is null;

update dbp_etl.nielsen_prod from (select mandant_id, kjmo from _check_nielsen_mat_kjmo group by 1, 2) b
set MAT_KJMO = b.kjmo
where
  dbp_etl.nielsen_prod.mandant_id = b.mandant_id and
  dbp_etl.nielsen_prod.MAT_KJMO is null;
