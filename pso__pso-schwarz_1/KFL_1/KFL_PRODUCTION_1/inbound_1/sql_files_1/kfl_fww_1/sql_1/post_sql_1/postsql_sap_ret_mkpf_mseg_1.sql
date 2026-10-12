UPDATE dbp_etl_process.sap_ret_mkpf_mseg_1
   SET sap_ret_mkpf_mseg.td_insert =CURRENT_TIMESTAMP
      ,sap_ret_mkpf_mseg.td_update =CURRENT_TIMESTAMP
FROM ${TEMP_TABLE}

WHERE sap_ret_mkpf_mseg.td_insert is null
  AND sap_ret_mkpf_mseg.avro_file_name = ${TEMP_TABLE}.avro_file_name
  AND sap_ret_mkpf_mseg.country_code   = ${TEMP_TABLE}.country_code
  AND sap_ret_mkpf_mseg.mblnr   = ${TEMP_TABLE}.mblnr
  AND sap_ret_mkpf_mseg.mjahr   = ${TEMP_TABLE}.mjahr
  AND sap_ret_mkpf_mseg.zeile   = ${TEMP_TABLE}.zeile
