BEGIN TRANSACTION;


DELETE FROM ldl_data_production_core_rel.t_internal_organization_1
WHERE int_org_type_cd = 'STORE' AND UPPER(dwh_node_cd) <> 'LISY' AND int_org_sid IN (SELECT k.party_sid
   FROM ldl_data_production_meta.t_party_key_1 AS k
    INNER JOIN ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_1 AS s ON SUBSTR(s.igl_number, 1, 2) || '|'
      || CAST(ROUND(CAST(SUBSTR(s.igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING) = UPPER(k.party_nat_key_nr)
   WHERE s.igl_accounttypecode IN (285540000, 285540009)
    AND (s.igl_neodate IS NOT NULL OR s.igl_closingdate IS NOT NULL)
    AND s.igl_number IS NOT NULL);


COMMIT;