CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_internal_company_partner (internal_company_partner_sid,
internal_company_partner_nr, internal_company_partner_name) AS SELECT internal_company_partner_sid,
  CASE
  WHEN internal_company_partner_nr = ''
  THEN '-1'
  ELSE IFNULL(internal_company_partner_nr, '-1')
  END AS internal_company_partner_nr,
 internal_company_partner_name
FROM ldl_dig_lec_share.v_dim_internal_company_partner
WHERE dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '-1',
 '-1';