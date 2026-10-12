MERGE INTO ldl_data_production_core_rel.t_internal_organization_2 AS trg
USING (
  SELECT
    int_org.*,
    CASE
      WHEN SUBSTR(int_org.int_org_nr, 1, 2) = 'NI' THEN 'Nordirland'
      ELSE cntry.country_name
    END AS new_country_name
  FROM ldl_data_production_core_rel.t_internal_organization_2 AS int_org
    LEFT OUTER JOIN ldl_data_production_core_rel.t_country_2 AS cntry
      ON cntry.iso_country_cd = SUBSTR(int_org.int_org_nr, 1, 2)
      AND cntry.dwh_valid_fg = TRUE
  WHERE 1 = 1
    AND int_org.int_org_type_cd = 'REGION_2'
    AND int_org.dwh_valid_fg = TRUE
) AS src
ON trg.int_org_sid = src.int_org_sid
   AND trg.dwh_valid_from_tmsp = src.dwh_valid_from_tmsp
WHEN MATCHED 
  AND NOT CAST(trg.country_org_name AS BIGNUMERIC) IS NOT DISTINCT FROM CAST(src.new_country_name AS BIGNUMERIC)
THEN UPDATE
  SET country_org_name = src.new_country_name
;
