TRUNCATE TABLE ldl_data_production_etl.t_tmp_full_int_org_hierarchy_2;

INSERT INTO ldl_data_production_etl.t_tmp_full_int_org_hierarchy_2
(
    child_org_sid,
    child_org_type_cd,
    child_org_nr,
    child_org_name,
    levels_above_leaf,
    top_hierarchy_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    parent_org_sid,
    parent_org_type_cd,
    parent_org_nr,
    parent_org_name,
    int_org_hierachy_path,
    parent_country_org_cd
)
WITH RECURSIVE ort AS (
    SELECT 
    'store' AS child_org_type_cd, 
    'sales_manager' AS parent_org_type_cd, 
    'sales_store' AS int_org_hierarchy_type_cd, 
    'account_sales' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'sales_manager' AS child_org_type_cd, 
    'account_manager' AS parent_org_type_cd, 
    'account_sales' AS int_org_hierarchy_type_cd, 
    'company_account' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'account_manager' AS child_org_type_cd, 
    'company' AS parent_org_type_cd, 
    'company_account' AS int_org_hierarchy_type_cd, 
    'region_company' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'store' AS child_org_type_cd, 
    'company' AS parent_org_type_cd, 
    'delivcmp_store' AS int_org_hierarchy_type_cd, 
    'region_company' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'store' AS child_org_type_cd, 
    'company' AS parent_org_type_cd, 
    'ownercmp_store' AS int_org_hierarchy_type_cd, 
    'x' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'store' AS child_org_type_cd, 
    'company' AS parent_org_type_cd, 
    'expcmp_store' AS int_org_hierarchy_type_cd, 
    'x' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'store' AS child_org_type_cd, 
    'company' AS parent_org_type_cd, 
    'balshcmp_store' AS int_org_hierarchy_type_cd, 
    'x' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'store' AS child_org_type_cd, 
    'company' AS parent_org_type_cd, 
    'cntry_org_store' AS int_org_hierarchy_type_cd, 
    'cntry_grp_cntry_org' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'company' AS child_org_type_cd, 
    'region_2' AS parent_org_type_cd, 
    'region_company' AS int_org_hierarchy_type_cd, 
    'cntry_org_region' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'region_2' AS child_org_type_cd, 
    'company' AS parent_org_type_cd, 
    'cntry_org_region' AS int_org_hierarchy_type_cd, 
    'cntry_grp_cntry_org' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'company' AS child_org_type_cd, 
    'country_grp' AS parent_org_type_cd, 
    'cntry_grp_cntry_org' AS int_org_hierarchy_type_cd, 
    'trust_country_grp' AS next_int_org_hierarchy_type_cd
    UNION ALL 
    SELECT 
    'country_grp' AS child_org_type_cd, 
    'trust' AS parent_org_type_cd, 
    'trust_country_grp' AS int_org_hierarchy_type_cd, 
    'x' AS next_int_org_hierarchy_type_cd
),

fht AS (
    -- Base Query for fht
    SELECT 
        GREATEST(c.dwh_valid_from_tmsp, h.dwh_valid_from_tmsp, p.dwh_valid_from_tmsp) AS dwh_valid_from_tmsp,
        LEAST(c.dwh_valid_to_tmsp, h.dwh_valid_to_tmsp, p.dwh_valid_to_tmsp) AS dwh_valid_to_tmsp,

        c.int_org_sid AS child_org_sid,
        c.int_org_type_cd AS child_org_type_cd,  -- Make sure this column is selected
        c.int_org_nr AS child_org_nr,
        c.int_org_name AS child_org_name,

        p.int_org_sid AS parent_org_sid,
        p.int_org_type_cd AS parent_org_type_cd,  -- Make sure this column is selected
        p.int_org_nr AS parent_org_nr,
        p.int_org_name AS parent_org_name,
        p.country_org_cd AS parent_country_org_cd,

        ort.int_org_hierarchy_type_cd AS top_hierarchy_type_cd,
        ort.next_int_org_hierarchy_type_cd AS next_int_org_hierarchy_type_cd,

        1 AS levels_above_leaf,
        CAST(ort.int_org_hierarchy_type_cd AS STRING) AS int_org_hierachy_path

    FROM ldl_data_production_core_rel.t_internal_organization_2 c
    JOIN ort ON c.int_org_type_cd = ort.child_org_type_cd
    JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy_2 h
        ON h.int_org_sid = c.int_org_sid
        AND h.dwh_valid_from_tmsp <= c.dwh_valid_to_tmsp
        AND h.dwh_valid_to_tmsp >= c.dwh_valid_from_tmsp
        AND h.int_org_hierarchy_type_cd = ort.int_org_hierarchy_type_cd
    JOIN ldl_data_production_core_rel.t_internal_organization_2 p
        ON p.int_org_sid = h.parent_int_org_sid
        AND p.dwh_valid_from_tmsp <= LEAST(c.dwh_valid_to_tmsp, h.dwh_valid_to_tmsp)
        AND p.dwh_valid_to_tmsp >= GREATEST(c.dwh_valid_from_tmsp, h.dwh_valid_from_tmsp)

    UNION ALL

    -- Recursive Query for fht
    SELECT 
        GREATEST(c.dwh_valid_from_tmsp, h.dwh_valid_from_tmsp, p.dwh_valid_from_tmsp),
        LEAST(c.dwh_valid_to_tmsp, h.dwh_valid_to_tmsp, p.dwh_valid_to_tmsp),

        c.child_org_sid,
        c.child_org_type_cd,  -- Make sure this column is selected in the recursive part
        c.child_org_nr,
        c.child_org_name,

        p.int_org_sid,
        p.int_org_type_cd AS parent_org_type_cd,  -- Ensure this column is selected in the recursive part
        p.int_org_nr AS parent_org_nr,
        p.int_org_name AS parent_org_name,
        p.country_org_cd,

        h.int_org_hierarchy_type_cd,
        ort.next_int_org_hierarchy_type_cd,

        c.levels_above_leaf + 1 AS levels_above_leaf,

        CONCAT(c.int_org_hierachy_path, ' | ', h.int_org_hierarchy_type_cd)

    FROM fht c
    JOIN ort 
        ON c.parent_org_type_cd = ort.child_org_type_cd
        AND c.next_int_org_hierarchy_type_cd = ort.int_org_hierarchy_type_cd
    JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy_2 h
        ON h.int_org_sid = c.parent_org_sid
        AND h.dwh_valid_from_tmsp <= c.dwh_valid_to_tmsp
        AND h.dwh_valid_to_tmsp >= c.dwh_valid_from_tmsp
        AND h.int_org_hierarchy_type_cd = ort.int_org_hierarchy_type_cd
    JOIN ldl_data_production_core_rel.t_internal_organization_2 p
        ON p.int_org_sid = h.parent_int_org_sid
        AND p.dwh_valid_from_tmsp <= LEAST(c.dwh_valid_to_tmsp, h.dwh_valid_to_tmsp)
        AND p.dwh_valid_to_tmsp >= GREATEST(c.dwh_valid_from_tmsp, h.dwh_valid_from_tmsp)
)

SELECT 
     child_org_sid
    ,child_org_type_cd
    ,child_org_nr
    ,child_org_name
    ,levels_above_leaf
    ,top_hierarchy_type_cd
    ,dwh_valid_from_tmsp
    ,dwh_valid_to_tmsp
    ,parent_org_sid
    ,parent_org_type_cd
    ,parent_org_nr
    ,parent_org_name
    ,int_org_hierachy_path
    ,parent_country_org_cd
     FROM fht;

TRUNCATE TABLE ldl_data_production_etl.t_r2d_full_internal_organization_hierarchy_2;


INSERT INTO ldl_data_production_etl.t_r2d_full_internal_organization_hierarchy_2 (child_org_sid, child_org_type_cd,
 child_org_nr, child_org_name, levels_above_leaf, top_hierarchy_type_cd, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 parent_org_sid, parent_org_type_cd, parent_org_nr, parent_org_name, int_org_hierachy_path, parent_country_org_cd)
WITH fh_with_change_fg AS (SELECT child_org_sid,
    child_org_type_cd,
    child_org_nr,
    child_org_name,
    levels_above_leaf,
    top_hierarchy_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    parent_org_sid,
    parent_org_type_cd,
    parent_org_nr,
    parent_org_name,
    int_org_hierachy_path,
    parent_is_sales_company_fg,
    parent_is_deliv_company_fg,
    parent_is_owner_company_fg,
    parent_is_expansion_company_fg,
    parent_is_bal_sheet_company_fg,
    parent_is_country_org_fg,
    parent_is_trust_fg,
    parent_country_org_cd,
    TO_HEX(CAST(SHA256(IFNULL(LOWER(child_org_nr), '@') || '#&#' || IFNULL(LOWER(child_org_name), '@') || '#&#' ||
              IFNULL(CAST(parent_org_sid AS STRING), '-1') || '#&#' || IFNULL(LOWER(parent_org_nr), '-1') || '#&#' ||
          IFNULL(LOWER(parent_org_name), '-1') || '#&#' || IFNULL(parent_country_org_cd, '@')) AS BYTES)) AS
    row_hash_for_diff,
    LAG(TO_HEX(CAST(SHA256(IFNULL(LOWER(child_org_nr), '@') || '#&#' || IFNULL(LOWER(child_org_name), '@') || '#&#' ||
               IFNULL(CAST(parent_org_sid AS STRING), '-1') || '#&#' || IFNULL(LOWER(parent_org_nr), '-1') || '#&#' ||
           IFNULL(LOWER(parent_org_name), '-1') || '#&#' || IFNULL(parent_country_org_cd, '@')) AS BYTES))) OVER (PARTITION BY
       child_org_sid, levels_above_leaf, top_hierarchy_type_cd ORDER BY dwh_valid_from_tmsp IS NULL, dwh_valid_from_tmsp
       ) AS prev_row_hash_for_diff,
     CASE
     WHEN TO_HEX(CAST(SHA256(IFNULL(LOWER(child_org_nr), '@') || '#&#' || IFNULL(LOWER(child_org_name), '@') || '#&#' ||
                IFNULL(CAST(parent_org_sid AS STRING), '-1') || '#&#' || IFNULL(LOWER(parent_org_nr), '-1') || '#&#' ||
            IFNULL(LOWER(parent_org_name), '-1') || '#&#' || IFNULL(parent_country_org_cd, '@')) AS BYTES)) = (LAG(TO_HEX(CAST(SHA256(IFNULL(LOWER(child_org_nr
                       ), '@') || '#&#' || IFNULL(LOWER(child_org_name), '@') || '#&#' || IFNULL(CAST(parent_org_sid AS STRING)
                   , '-1') || '#&#' || IFNULL(LOWER(parent_org_nr), '-1') || '#&#' || IFNULL(LOWER(parent_org_name),
               '-1') || '#&#' || IFNULL(parent_country_org_cd, '@')) AS BYTES))) OVER (PARTITION BY child_org_sid,
          levels_above_leaf, top_hierarchy_type_cd ORDER BY dwh_valid_from_tmsp IS NULL, dwh_valid_from_tmsp))
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_etl.t_tmp_full_int_org_hierarchy_2 AS x), fh_with_groups AS (SELECT child_org_sid,
    child_org_type_cd,
    child_org_nr,
    child_org_name,
    levels_above_leaf,
    top_hierarchy_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    parent_org_sid,
    parent_org_type_cd,
    parent_org_nr,
    parent_org_name,
    int_org_hierachy_path,
    parent_is_sales_company_fg,
    parent_is_deliv_company_fg,
    parent_is_owner_company_fg,
    parent_is_expansion_company_fg,
    parent_is_bal_sheet_company_fg,
    parent_is_country_org_fg,
    parent_is_trust_fg,
    parent_country_org_cd,
    row_hash_for_diff,
    prev_row_hash_for_diff,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY child_org_sid, levels_above_leaf, top_hierarchy_type_cd ORDER BY
       dwh_valid_from_tmsp IS NULL, dwh_valid_from_tmsp, has_change_fg IS NULL DESC, has_change_fg DESC ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM fh_with_change_fg AS x) (SELECT child_org_sid,
    child_org_type_cd,
    child_org_nr,
    child_org_name,
    levels_above_leaf,
    top_hierarchy_type_cd,
    MIN(dwh_valid_from_tmsp) AS dwh_valid_from_tmsp,
    MAX(dwh_valid_to_tmsp) AS dwh_valid_to_tmsp,
    parent_org_sid,
    parent_org_type_cd,
    parent_org_nr,
    parent_org_name,
    int_org_hierachy_path,
    parent_country_org_cd
   FROM fh_with_groups
   GROUP BY child_org_sid,
    child_org_type_cd,
    child_org_nr,
    child_org_name,
    levels_above_leaf,
    top_hierarchy_type_cd,
    parent_org_sid,
    parent_org_type_cd,
    parent_org_nr,
    parent_org_name,
    int_org_hierachy_path,
    parent_country_org_cd,
    group_id);