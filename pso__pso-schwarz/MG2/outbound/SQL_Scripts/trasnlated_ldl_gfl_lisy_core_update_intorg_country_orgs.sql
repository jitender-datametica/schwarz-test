BEGIN TRANSACTION;
-- Note: any record for the previous country organiation that started after the new organization become active should have its flag set to FALSE.
-- records for previous Country Orgs that started before but end after the new organization becomes active should have their end-date adjusted and the gap should be filled with a record for the previous organization with flag FALSE (the insert in ""M5"")
MERGE INTO core_rel.t_internal_organization AS trg USING (
  WITH prev AS (
    SELECT
        -- all country organization for given country from the prev loads for this country (excl the last load)
        *
      FROM
        core_rel.t_internal_organization
      WHERE is_country_org_fg = true
       AND int_org_type_cd = 'COMPANY'
      QUALIFY numeric '1' = numeric '1'
       AND count(DISTINCT int_org_sid) OVER (PARTITION BY country_org_cd) > numeric '1'
       AND rank() OVER (PARTITION BY country_org_cd ORDER BY IF(dwh_load_id IS NULL, 0, 1), dwh_load_id DESC) > numeric '1'
  ), curr AS (
    SELECT
        -- if we have more than one SID as country org for a country
        -- all country organization for given country from the last load for this country
        *
      FROM
        core_rel.t_internal_organization
      WHERE is_country_org_fg = true
       AND int_org_type_cd = 'COMPANY'
      QUALIFY numeric '1' = numeric '1'
       AND count(DISTINCT int_org_sid) OVER (PARTITION BY country_org_cd) > numeric '1'
       AND rank() OVER (PARTITION BY country_org_cd ORDER BY IF(dwh_load_id IS NULL, 0, 1), dwh_load_id DESC) = numeric '1'
  )
  SELECT
      -- if we have more than one SID as country org for a country
      prev.int_org_sid,
      prev.dwh_valid_from_tmsp AS prev_valid_from,
      prev.dwh_valid_to_tmsp AS prev_valid_to,
      CASE
        WHEN prev.dwh_valid_from_tmsp >= MIN(curr.dwh_valid_from_tmsp) THEN 'UPD FLAG'
        ELSE 'UPD TMSP'
      END AS action_type,
      MIN(curr.dwh_valid_from_tmsp) AS curr_valid_from,
      DATE_SUB(MIN(curr.dwh_valid_from_tmsp), INTERVAL 1 Nanosecond) AS new_valid_to,
      prev.country_org_cd
    FROM
      prev
      INNER JOIN curr ON prev.country_org_cd = curr.country_org_cd
       AND prev.dwh_valid_to_tmsp > curr.dwh_valid_from_tmsp
    GROUP BY 1, 2, 3, 7
) AS src
ON trg.int_org_sid = src.int_org_sid
 AND trg.dwh_valid_from_tmsp = src.prev_valid_from
WHEN MATCHED THEN UPDATE SET
    is_country_org_fg = CASE
       src.action_type
      WHEN 'UPD FLAG' THEN false
      ELSE true
    END, 
    dwh_valid_to_tmsp = CASE
       src.action_type
      WHEN 'UPD TMSP' THEN src.new_valid_to
      ELSE src.prev_valid_to
    END, 
    dwh_updated_tmsp = CURRENT_TIMESTAMP(), 
    dwh_load_id = '${LOAD_ID}'
;

INSERT INTO core_rel.t_internal_organization (
  int_org_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg,
  int_org_type_cd, int_org_nr, int_org_name, open_dt, planned_open_dt,
  close_dt, curr_cd, holiday_store_fg, legal_name, vat_nr, country_org_cd,
  comment_txt, is_sales_company_fg, is_deliv_company_fg, is_country_org_fg,
  is_expansion_company_fg, is_bal_sheet_company_fg, is_owner_company_fg,
  is_trust_fg, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd
)
WITH other_gaps AS (
  SELECT
      io.*,
      CASE
        WHEN io.dwh_valid_to_tmsp < CAST('9999-12-31 23:59:59.999' AS datetime)
          THEN DATETIME_ADD(io.dwh_valid_to_tmsp, INTERVAL 1 Nanosecond)
        ELSE io.dwh_valid_to_tmsp
      END AS adj_valid_to_tmsp,
      LEAD(io.dwh_valid_from_tmsp, numeric '1', CAST('9999-12-31 23:59:59.999' AS datetime))
        OVER (PARTITION BY io.int_org_sid ORDER BY IF(io.dwh_valid_from_tmsp IS NULL, 0, 1) DESC, io.dwh_valid_from_tmsp)
        AS next_valid_from_tsmp
    FROM
      core_rel.t_internal_organization AS io
    WHERE io.int_org_type_cd = 'COMPANY'
    -- To have a gap, the current row must end more than 1ns before next row begins
    QUALIFY adj_valid_to_tmsp < next_valid_from_tsmp
     AND io.is_country_org_fg = true
)
SELECT
    io.int_org_sid,
    io.adj_valid_to_tmsp AS dwh_valid_from_tmsp,
    calc_dwh_valid_to_tmsp AS calc_dwh_valid_to_tmsp,
    CURRENT_TIMESTAMP() BETWEEN io.adj_valid_to_tmsp AND calc_dwh_valid_to_tmsp AS dwh_valid_fg,
    io.int_org_type_cd,
    io.int_org_nr,
    io.int_org_name,
    io.open_dt,
    io.planned_open_dt,
    io.close_dt,
    io.curr_cd,
    io.holiday_store_fg,
    io.legal_name,
    io.vat_nr,
    io.country_org_cd,
    io.comment_txt,
    io.is_sales_company_fg,
    io.is_deliv_company_fg,
    false AS is_country_org_fg,
    io.is_expansion_company_fg,
    io.is_bal_sheet_company_fg,
    io.is_owner_company_fg,
    io.is_trust_fg,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    io.dwh_load_id,
    'LISY'
  FROM
    other_gaps AS io
    CROSS JOIN UNNEST(ARRAY[
      CASE
        WHEN io.next_valid_from_tsmp < CAST('9999-12-31 23:59:59.999' AS datetime)
          THEN DATETIME_SUB(io.next_valid_from_tsmp, INTERVAL 1 Nanosecond)
        ELSE io.next_valid_from_tsmp
      END
    ]) AS calc_dwh_valid_to_tmsp
;

COMMIT TRANSACTION;
