CREATE TABLE META.T_SRG_INTERNAL_COMPANY_SID(
  internal_company_sid NUMBER AUTOINCREMENT,
  internal_company_cd VARCHAR(5),
  src_table_name VARCHAR(250),
  dwh_created_tmsp TIMESTAMP_LTZ(9)
);