UPDATE dbp_etl_process.sap_ret_mkpf_mseg_2 SET
    td_insert = CURRENT_TIMESTAMP(),
    td_update = CURRENT_TIMESTAMP()
FROM ${TEMP_TABLE} a
WHERE
    sap_ret_mkpf_mseg.td_insert IS NULL AND sap_ret_mkpf_mseg.avro_file_name =
    a.avro_file_name AND sap_ret_mkpf_mseg.country_code =
    a.country_code AND sap_ret_mkpf_mseg.mblnr =
    a.mblnr AND sap_ret_mkpf_mseg.mjahr =
    a.mjahr AND sap_ret_mkpf_mseg.zeile =
    a.zeile;
