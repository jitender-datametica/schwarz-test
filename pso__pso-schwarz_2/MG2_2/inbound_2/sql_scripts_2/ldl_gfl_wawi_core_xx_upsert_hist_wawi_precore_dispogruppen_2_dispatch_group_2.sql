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
       ctrcode AS party_nat_key_nr,
       'COUNTRY_2' AS int_org_key_type_cd,
       dispogrupnr AS dispatch_grp_nr,
       CASE 
         WHEN ctrcode in ('DE','CY','CZ','GR','CH','AT','BG','HR','HU','LT','PT','RO') THEN 'DE'  
         WHEN ctrcode in ('GB','IE','NIE','LV','EE') THEN 'EN'
         WHEN ctrcode in ('CS','ES') THEN 'ES'
         WHEN ctrcode in ('CZ') THEN 'CS'
         WHEN ctrcode in ('DK') THEN  'DA'
         WHEN ctrcode in ('FI') THEN 'FI'
         WHEN ctrcode in ('IT') THEN 'IT'
         WHEN ctrcode in ('NL','BE') THEN 'NL'
         WHEN ctrcode in ('PL') THEN 'PL'
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
FROM etl.t_wawi_precore_dispogruppen_2
;
