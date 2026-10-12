INSERT INTO ldl_data_production_core_rel.t_local_product_variant_1 (PROD_VARIANT_SID, INT_ORG_SID, DWH_VALID_FROM_TMSP, DWH_VALID_TO_TMSP, DWH_VALID_FG, LOCAL_PROD_VARIANT_NR, LOCAL_PROD_VARIANT_NAME, PROD_SID, DWH_CREATED_TMSP, DWH_UPDATED_TMSP, DWH_LOAD_ID, DWH_NODE_CD)
  SELECT
      PROD_VARIANT_SID,
      P.PARTY_SID AS INT_ORG_SID,
      cast ('1900-01-01 00:00:00' as timestamp) AS DWH_VALID_FROM_TMSP,
      cast ('9999-12-31 23:59:59.999999999' as timestamp) AS DWH_VALID_TO_TMSP,
      true AS DWH_VALID_FG,
      substr(PROD_VARIANT_NAT_KEY_NR, 4) AS LOCAL_PROD_VARIANT_NR,
      'Unbekannt' AS LOCAL_PROD_VARIANT_NAME,
      NULL AS PROD_SID,
      current_timestamp(),
      current_timestamp(),
      cast('${LOAD_ID}' as bignumeric) AS DWH_LOAD_ID,
      'MAN' AS DWH_NODE_CD
    FROM
      ldl_data_production_meta.t_product_variant_key_1 AS PV
      INNER JOIN ldl_data_production_meta.t_party_key_1 AS P ON P.PARTY_KEY_TYPE_CD = 'COUNTRY_1'
       AND P.PARTY_NAT_KEY_NR = substr(PV.PROD_VARIANT_NAT_KEY_NR, 0, 2)
       AND P.DWH_VALID_FG = PV.DWH_VALID_FG
    WHERE PROD_VARIANT_KEY_TYPE_CD = 'SLS_UNK'
     AND PV.DWH_VALID_FG
     AND PROD_VARIANT_SID NOT IN(
      SELECT
          PROD_VARIANT_SID
        FROM
          ldl_data_production_core_rel.t_local_product_variant_1
    )
     AND PROD_VARIANT_SID NOT IN(
      SELECT
          PROD_VARIANT_SID
        FROM
          ldl_data_production_meta.t_product_variant_key_1
        WHERE PROD_VARIANT_KEY_TYPE_CD <> 'SLS_UNK'
    )
;
