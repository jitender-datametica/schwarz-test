CREATE OR REPLACE VIEW ldl_dig_core.v_dim_customer_1 (cust_sid, cust_type_cd, cust_nr, cust_org_type_cd,
cust_birth_cy_month, cust_lan_cd, cust_sso_id, cust_blocked_reason_cd, cust_creation_dt, cust_registration_dt,
cust_acct_id, is_cust_adv_blocked_fg, dwh_created_tmsp, dwh_updated_tmsp) AS SELECT cust_sid,
 cust_type_cd,
 cust_nr,
 cust_org_type_cd,
 FORMAT_DATE('%Y-%m', cust_birth_dt) AS cust_birth_cy_month,
 cust_lan_cd,
 cust_sso_id,
 cust_blocked_reason_cd,
 cust_creation_dt,
 cust_registration_dt,
 cust_acct_id,
 is_cust_adv_blocked_fg,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_dig_core.t_dim_customer_1
WHERE dwh_valid_fg;