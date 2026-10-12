CREATE TABLE IF NOT EXISTS ldl_etl.t_r2d_internal_organization_status (
int_org_sid BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
int_org_status_cd STRING(20),
int_org_status_descr_de STRING(250)
);