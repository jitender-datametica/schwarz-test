/*
Summary: We insert Store records in CORE_REL for Store keys that exist in META but not in CORE_REL yet
*/



INSERT INTO ldl_data_production_core_rel.t_internal_organization_1 (int_org_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 dwh_valid_fg, int_org_type_cd, int_org_nr, int_org_name, open_dt, planned_open_dt, close_dt, curr_cd, holiday_store_fg
 , legal_name, vat_nr, country_org_cd, comment_txt, is_sales_company_fg, is_deliv_company_fg, is_country_org_fg,
 is_expansion_company_fg, is_bal_sheet_company_fg, is_owner_company_fg, is_trust_fg, dwh_created_tmsp, dwh_updated_tmsp
 , dwh_load_id, dwh_node_cd, int_org_short_name, country_org_name)
(SELECT DISTINCT int_org_sid,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  int_org_type_cd,
  int_org_nr,
  int_org_name,
  open_dt,
  planned_open_dt,
  close_dt,
  curr_cd,
  holiday_store_fg,
  legal_name,
  vat_nr,
  country_org_cd,
  comment_txt,
  is_sales_company_fg,
  is_deliv_company_fg,
  is_country_org_fg,
  is_expansion_company_fg,
  is_bal_sheet_company_fg,
  is_owner_company_fg,
  is_trust_fg,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd,
  int_org_short_name,
  country_org_name
 FROM (SELECT pk.party_sid AS int_org_sid,
    CAST('1900-01-01' AS TIMESTAMP) AS dwh_valid_from_tmsp,
    pk.dwh_valid_to_tmsp,
    pk.dwh_valid_fg,
    pk.party_key_type_cd AS int_org_type_cd,
    REPLACE(pk.party_nat_key_nr, '|', '') AS int_org_nr,
    'Unbekannt (Nicht in LISY)' AS int_org_name,
    CAST(NULL AS DATE) AS open_dt,
    CAST(NULL AS DATE) AS planned_open_dt,
    CAST(NULL AS DATE) AS close_dt,
    CAST(NULL AS STRING) AS curr_cd,
    CAST(NULL AS BOOL) AS holiday_store_fg,
    CAST(NULL AS STRING) AS legal_name,
    CAST(NULL AS STRING) AS vat_nr,
    CAST(NULL AS STRING) AS country_org_cd,
    'Default Record - created by NKC ' AS comment_txt,
    CAST(NULL AS BOOL) AS is_sales_company_fg,
    CAST(NULL AS BOOL) AS is_deliv_company_fg,
    CAST(NULL AS BOOL) AS is_country_org_fg,
    CAST(NULL AS BOOL) AS is_expansion_company_fg,
    CAST(NULL AS BOOL) AS is_bal_sheet_company_fg,
    CAST(NULL AS BOOL) AS is_owner_company_fg,
    CAST(NULL AS BOOL) AS is_trust_fg,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    pk.dwh_load_id,
    'MANUAL (NKC)' AS dwh_node_cd,
    CAST(NULL AS STRING) AS int_org_short_name,
    CAST(NULL AS STRING) AS country_org_name
   FROM ldl_data_production_meta.t_party_key_1 AS pk
    LEFT JOIN ldl_data_production_core_rel.t_internal_organization_1 AS io ON pk.party_sid = io.int_org_sid AND io.int_org_type_cd
       = 'STORE'
   WHERE pk.party_key_type_cd = 'STORE'
    AND io.int_org_sid IS NULL
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(pk.party_sid AS STRING) ORDER BY pk.dwh_created_tmsp IS NULL, pk.dwh_created_tmsp
         )) = 1) AS t2
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_rel.t_internal_organization_1
   WHERE int_org_sid = t2.int_org_sid
    AND dwh_valid_from_tmsp = t2.dwh_valid_from_tmsp)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY int_org_sid, dwh_valid_from_tmsp)) = 1);