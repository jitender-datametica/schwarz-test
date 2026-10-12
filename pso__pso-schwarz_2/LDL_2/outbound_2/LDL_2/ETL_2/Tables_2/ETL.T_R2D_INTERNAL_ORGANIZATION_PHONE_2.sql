CREATE TABLE IF NOT EXISTS ldl_etl.t_r2d_internal_organization_phone_2 (
int_org_sid BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
phone_nr STRING(100)
);