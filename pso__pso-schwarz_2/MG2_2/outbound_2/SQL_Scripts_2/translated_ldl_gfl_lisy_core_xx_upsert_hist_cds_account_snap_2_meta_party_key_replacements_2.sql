/* 
This process is designed to allocate the same orginal SID to all descendant stores of that original store.

This is because of a blurring of the definition of logical stores and physical stores.
For example, LIDL Berlin may originally be identified as store100, however if that physical building is demolished
and replaced by a newly constructed building then it is a different physical store (building) called store200, 
but it is really still LIDL Berlin.

Business reports should show KPIs against the one 'original' store100 consistently, not the different buildings (store 100, 200, etc etc).
Therefore, in data terms, all stores should eb assigned the same original SID.
 
The ETL framework does not currently facilitate this; the framework is designed to simply allocate a new SID for any new NK.

The cds_Account(store 3) worksheet in the t_internal_organization_2 mapping spec, specifies this process and is implemented
here.

*/ 

BEGIN TRANSACTION;


DELETE FROM ldl_data_production_meta.t_party_key_2   -- Prevent any concurrent access to this keyspace
WHERE 1 = 2;

INSERT INTO `ldl_data_production_meta.t_party_key_2` (
  party_sid,
  party_key_type_cd,
  party_nat_key_nr,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  dwh_node_cd,
  dwh_load_id
)
WITH RECURSIVE stores AS (
  SELECT 
    *,
    SUBSTR(igl_number, 1, 2) || '|' || CAST(CAST(SUBSTR(igl_number, 3) AS INT64) AS STRING) AS formatted_nk
  FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_2
  WHERE igl_accounttypecode IN (285540000, 285540009)
    AND (igl_neodate IS NOT NULL OR igl_closingdate IS NOT NULL OR igl_expectedopeningdate IS NOT NULL)
    AND igl_number IS NOT NULL
), 
recur_base AS (

    -- followers/next/replacement stores taken using "IGL_REPLACEMENTID" of the previous
	-- "root store" is replaced by "next store"
  SELECT 
    r.accountid,
    r.igl_number,
    r.formatted_nk,
    r.igl_substituteforid,
    ns.accountid AS ns_account_id,
    ns.igl_number AS ns_igl_number,
    ns.formatted_nk AS ns_formatted_nk,
    ns.igl_neodate AS ns_open_dt,
    ns.igl_closingdate AS ns_close_dt
  FROM stores AS r
  INNER JOIN stores AS ns ON r.igl_replacementid = ns.accountid
  
  UNION DISTINCT
   
    -- followers/next/replacement stores taken using their "IGL_SUBSTITUTEFORID"
	-- "next store" is substitute for the ROOT
  SELECT 
    r.accountid,
    r.igl_number,
    r.formatted_nk,
    r.igl_substituteforid,
    ns.accountid AS ns_account_id,
    ns.igl_number AS ns_igl_number,
    ns.formatted_nk AS ns_formatted_nk,
    ns.igl_neodate AS ns_open_dt,
    ns.igl_closingdate AS ns_close_dt
  FROM stores AS r
  INNER JOIN stores AS ns ON r.accountid = ns.igl_substituteforid
), 
recur AS (
      -- root stores
  SELECT 
    accountid,
    igl_number,
    formatted_nk,
    igl_substituteforid,
    ns_account_id,
    ns_igl_number,
    ns_formatted_nk,
    ns_open_dt,
    ns_close_dt,
    1 AS level
  FROM recur_base
  WHERE igl_substituteforid IS NULL
    AND accountid NOT IN (SELECT igl_replacementid FROM stores WHERE igl_replacementid IS NOT NULL)

  UNION ALL

  SELECT 
    rec.accountid,
    rec.igl_number,
    rec.formatted_nk,
    rec.igl_substituteforid,
    base.ns_account_id,
    base.ns_igl_number,
    base.ns_formatted_nk,
    base.ns_open_dt,
    base.ns_close_dt,
    rec.level + 1 AS level
  FROM recur AS rec
  INNER JOIN recur_base AS base ON rec.ns_account_id = base.accountid
)
SELECT DISTINCT
  keys.party_sid,    -- Original Store SID
  keys.party_key_type_cd,
  r.ns_formatted_nk, -- Descendent Store NK
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  TIMESTAMP '9999-12-31 23:59:59',
  TRUE,
  'LISY',
  722569 AS dwh_load_id 
FROM recur AS r
INNER JOIN ldl_data_production_meta.t_party_key_2 AS keys 
  ON keys.party_nat_key_nr = r.formatted_nk      -- Original Store NK
WHERE keys.party_key_type_cd = 'STORE'
  AND keys.dwh_valid_fg = TRUE
  AND r.ns_formatted_nk NOT IN (
    SELECT party_nat_key_nr
    FROM ldl_data_production_meta.t_party_key_2
    WHERE party_key_type_cd = 'STORE'
      AND CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
);

COMMIT TRANSACTION;