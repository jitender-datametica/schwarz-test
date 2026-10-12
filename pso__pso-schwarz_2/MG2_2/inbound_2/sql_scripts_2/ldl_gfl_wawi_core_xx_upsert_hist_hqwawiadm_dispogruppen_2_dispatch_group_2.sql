INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(              
        party_nat_key_nr,
        int_org_key_type_cd,
        dispatch_grp_nr,
        lang_cd,
        dispatch_grp_descr,
        source_system,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
SELECT 
       CASE WHEN wawi_instanz_kzl='CS' THEN 'ES' ELSE LEFT(wawi_instanz_kzl,2) END AS party_nat_key_nr,
       'COUNTRY_2' AS int_org_key_type_cd,
       dispogrupnr AS dispatch_grp_nr,
       CASE 
         WHEN wawi_instanz_kzl in ('DE','CY','CZ','GR','CH','AT','BG','HR','HU','LT','PT','RO') THEN 'DE'  
         WHEN wawi_instanz_kzl in ('GB','IE','NIE','LV','EE') THEN 'EN'
         WHEN wawi_instanz_kzl in ('CS','ES') THEN 'ES'
         WHEN wawi_instanz_kzl in ('CZ') THEN 'CS'
         WHEN wawi_instanz_kzl in ('DK') THEN  'DA'
         WHEN wawi_instanz_kzl in ('FI') THEN 'FI'
         WHEN wawi_instanz_kzl in ('IT') THEN 'IT'
         WHEN wawi_instanz_kzl in ('NL','BE') THEN 'NL'
         WHEN wawi_instanz_kzl in ('PL') THEN 'PL'
         ELSE 'DE'
       END AS lang_cd,
       dispogrupbez AS dispatch_grp_descr,
      'WAWI' source_system,
       extraction_tmsp extraction_dt,
       extraction_tmsp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       'wawi_precore_dispogruppen' filename,
       'WAWI_HQ' dwh_node_cd,
       ${LOAD_ID} dwh_load_id
FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.dispogruppen_2
WHERE delete_fg IS NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY party_nat_key_nr,dispogrupnr ORDER BY extraction_tmsp DESC ) = 1;
;
