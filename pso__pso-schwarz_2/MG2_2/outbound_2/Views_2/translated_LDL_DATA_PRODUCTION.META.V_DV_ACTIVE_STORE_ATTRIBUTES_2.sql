CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_active_store_attributes_2 (int_org_sid, dwh_valid_from_tmsp,
dwh_valid_to_tmsp, dwh_valid_fg, curr_int_org_nr, init_int_org_nr, int_org_name, int_org_status_cd, int_org_status_descr
, open_dt, planned_open_dt, close_dt, iso_country_cd, country_name, city_name, district_name, zip, street_name, house_nr
, lon, lat, po_box_nr, phone_nr, fax_nr, email_addr_txt, reporting_country_cd, sales_mgr_district_sid,
sales_mgr_district_nr, sales_mgr_district_name, sales_mgr_emp_sid, sales_mgr_emp_nr, sales_mgr_name,
acct_mgr_district_sid, acct_mgr_district_nr, acct_mgr_district_name, acct_mgr_emp_sid, acct_mgr_emp_nr, acct_mgr_name,
sales_company_sid, sales_company_nr, sales_company_name, sales_company_director_emp_sid, sales_company_director_emp_nr,
sales_company_director_name, deliv_company_sid, deliv_company_nr, deliv_company_name, deliv_company_director_emp_sid,
deliv_company_director_emp_nr, deliv_company_director_name, expansion_company_sid, expansion_company_nr,
expansion_company_name, bal_sheet_company_sid, bal_sheet_company_nr, bal_sheet_company_name, owner_company_sid,
owner_company_nr, owner_company_name, sales_region_sid, sales_region_nr, sales_region_name, sales_region_mgr_emp_sid,
sales_region_mgr_emp_nr, sales_region_mgr_name, deliv_region_sid, deliv_region_nr, deliv_region_name,
deliv_region_mgr_emp_sid, deliv_region_mgr_emp_nr, deliv_region_mgr_name, country_org_sid, country_org_cd,
country_org_nr, country_org_name, country_org_mgr_emp_sid, country_org_mgr_emp_nr, country_org_mgr_name,
country_grp_org_sid, country_grp_org_nr, country_grp_org_name, country_grp_org_mgr_emp_sid, country_grp_org_mgr_emp_nr,
country_grp_org_mgr_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd, sc_sales_company_sid,
sc_sales_company_name, cntr_country_org_sid, cntr_country_org_name, oh_store_sid, real_estate_sid, real_estate_nr,
real_estate_name, real_estate_status_cd, real_estate_type_cd, failed_sales_manager_valid, failed_account_manager_valid,
failed_sales_company_valid, failed_sales_company_consistent, failed_country_org_valid, failed_country_org_consistent,
failed_real_estate_terminated, failed_real_estate_missing, failed_missing_opening_hours, total)
OPTIONS(DESCRIPTION = `ACTIVE STORES FROM LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2 AND RELATED ATTRIBUTES (MANAGERS, SALES_2 COMPANY, COUNTRY_2, OPENING_HOURS, ESTATE_TYPE_CD..)\\NINPUT DATASETS:\\NCORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2\\NCORE_DIM.T_DIM_REAL_ESTATE_2\\NCORE_REL.T_STORE_OPENING_HOURS_2`)
AS SELECT store.int_org_sid,
 store.dwh_valid_from_tmsp,
 store.dwh_valid_to_tmsp,
 store.dwh_valid_fg,
 store.curr_int_org_nr,
 store.init_int_org_nr,
 store.int_org_name,
 store.int_org_status_cd,
 store.int_org_status_descr,
 store.open_dt,
 store.planned_open_dt,
 store.close_dt,
 store.iso_country_cd,
 store.country_name,
 store.city_name,
 store.district_name,
 store.zip,
 store.street_name,
 store.house_nr,
 store.lon,
 store.lat,
 store.po_box_nr,
 store.phone_nr,
 store.fax_nr,
 store.email_addr_txt,
 store.reporting_country_cd,
 store.sales_mgr_district_sid,
 store.sales_mgr_district_nr,
 store.sales_mgr_district_name,
 store.sales_mgr_emp_sid,
 store.sales_mgr_emp_nr,
 store.sales_mgr_name,
 store.acct_mgr_district_sid,
 store.acct_mgr_district_nr,
 store.acct_mgr_district_name,
 store.acct_mgr_emp_sid,
 store.acct_mgr_emp_nr,
 store.acct_mgr_name,
 store.sales_company_sid,
 store.sales_company_nr,
 store.sales_company_name,
 store.sales_company_director_emp_sid,
 store.sales_company_director_emp_nr,
 store.sales_company_director_name,
 store.deliv_company_sid,
 store.deliv_company_nr,
 store.deliv_company_name,
 store.deliv_company_director_emp_sid,
 store.deliv_company_director_emp_nr,
 store.deliv_company_director_name,
 store.expansion_company_sid,
 store.expansion_company_nr,
 store.expansion_company_name,
 store.bal_sheet_company_sid,
 store.bal_sheet_company_nr,
 store.bal_sheet_company_name,
 store.owner_company_sid,
 store.owner_company_nr,
 store.owner_company_name,
 store.sales_region_sid,
 store.sales_region_nr,
 store.sales_region_name,
 store.sales_region_mgr_emp_sid,
 store.sales_region_mgr_emp_nr,
 store.sales_region_mgr_name,
 store.deliv_region_sid,
 store.deliv_region_nr,
 store.deliv_region_name,
 store.deliv_region_mgr_emp_sid,
 store.deliv_region_mgr_emp_nr,
 store.deliv_region_mgr_name,
 store.country_org_sid,
 store.country_org_cd,
 store.country_org_nr,
 store.country_org_name,
 store.country_org_mgr_emp_sid,
 store.country_org_mgr_emp_nr,
 store.country_org_mgr_name,
 store.country_grp_org_sid,
 store.country_grp_org_nr,
 store.country_grp_org_name,
 store.country_grp_org_mgr_emp_sid,
 store.country_grp_org_mgr_emp_nr,
 store.country_grp_org_mgr_name,
 store.dwh_created_tmsp,
 store.dwh_updated_tmsp,
 store.dwh_load_id,
 store.dwh_node_cd,
 sales_company.int_org_sid AS sc_sales_company_sid,
 sales_company.int_org_name AS sc_sales_company_name,
 country_org.int_org_sid AS cntr_country_org_sid,
 country_org.country_name AS cntr_country_org_name,
 oh.store_sid AS oh_store_sid,
 re.real_estate_sid,
 re.real_estate_nr,
 re.real_estate_name,
 re.real_estate_status_cd,
 re.real_estate_type_cd,
  CASE
  WHEN LOWER(store.sales_mgr_name) = 'unbekannt'
  THEN 1
  ELSE 0
  END AS failed_sales_manager_valid,
  CASE
  WHEN LOWER(store.acct_mgr_name) = 'unbekannt'
  THEN 1
  ELSE 0
  END AS failed_account_manager_valid,
  CASE
  WHEN LOWER(store.sales_company_name) = 'unbekannt'
  THEN 1
  ELSE 0
  END AS failed_sales_company_valid,
  CASE
  WHEN sales_company.int_org_name IS NULL OR store.sales_company_name <> sales_company.int_org_name
  THEN 1
  ELSE 0
  END AS failed_sales_company_consistent,
  CASE
  WHEN LOWER(store.country_org_name) = 'unbekannt'
  THEN 1
  ELSE 0
  END AS failed_country_org_valid,
  CASE
  WHEN country_org.country_name IS NULL OR store.country_org_name <> country_org.country_name
  THEN 1
  ELSE 0
  END AS failed_country_org_consistent,
  CASE
  WHEN re.real_estate_status_cd = 'TE'
  THEN 1
  ELSE 0
  END AS failed_real_estate_terminated,
  CASE
  WHEN re.real_estate_status_cd IS NULL
  THEN 1
  ELSE 0
  END AS failed_real_estate_missing,
  CASE
  WHEN re.real_estate_type_cd = 'STORE' AND oh.store_sid IS NULL
  THEN 1
  ELSE 0
  END AS failed_missing_opening_hours,
 1 AS total
FROM ldl_data_production_core_dim.t_dim_internal_organization_2 AS store
 LEFT JOIN (SELECT int_org_sid,
   int_org_name
  FROM ldl_data_production_core_dim.t_dim_internal_organization_2
  WHERE dwh_valid_fg
   AND int_org_type_cd = 'COMPANY'
   AND LOWER(int_org_status_cd) = 'active'
   AND is_sales_company_fg) AS sales_company ON store.sales_company_sid = sales_company.int_org_sid
 LEFT JOIN (SELECT int_org_sid,
   country_name
  FROM ldl_data_production_core_dim.t_dim_internal_organization_2
  WHERE dwh_valid_fg
   AND int_org_type_cd = 'COMPANY'
   AND LOWER(int_org_status_cd) = 'active'
   AND is_country_org_fg) AS country_org ON store.country_org_sid = country_org.int_org_sid
 LEFT JOIN (SELECT DISTINCT store_sid
  FROM ldl_data_production_core_rel.t_store_opening_hours_2
  WHERE dwh_valid_fg) AS oh ON store.int_org_sid = oh.store_sid
 LEFT JOIN ldl_data_production_core_dim.t_dim_real_estate_2 AS re_2 ON store.int_org_sid = re.int_org_sid AND store.dwh_valid_from_tmsp
   BETWEEN re.dwh_valid_from_tmsp AND re.dwh_valid_to_tmsp
WHERE store.dwh_valid_fg
 AND store.int_org_type_cd = 'STORE'
 AND LOWER(store.int_org_status_cd) = 'active';