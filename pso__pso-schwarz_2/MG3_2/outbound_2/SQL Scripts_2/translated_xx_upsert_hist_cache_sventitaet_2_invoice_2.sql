
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, invoice_nr, finance_key_type_cd,
 consignee_party_id, finance_id, consignee_party_key_type_cd, receipt_txt, booking_type_cd, invoice_type_cd,
 consignor_stream_cd, invoice_reference_nr)
(SELECT MAX(ct.dwh_src_file_name),
  0 AS tf_error_fg,
  MAX(ct.dwh_src_1_tmsp),
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  MAX(ct.filename),
  ct.invoice_nr,
  ct.finance_key_type_cd,
  ct.consignee_party_id,
  CAST(ct.finance_id AS STRING) AS finance_id,
  ct.consignee_party_key_type_cd,
  ct.receipt_txt,
  ct.booking_type_cd,
  ct.invoice_type_cd,
  ct.consignor_stream_cd,
  ct.invoice_reference_nr
 FROM (SELECT DISTINCT 'INVOICE' AS finance_key_type_cd,
    t0.rechid AS finance_id,
    'CONSIGNEE_INVOICE' AS invoice_type_cd,
    'CONSIGNEE' AS consignee_party_key_type_cd,
    UPPER(TRIM(eg.entitaetsnr)) AS consignee_party_id,
     CASE
     WHEN eb.mutterid = 193
     THEN 'LST'
     WHEN eb.mutterid = 23761979
     THEN 'OWIM'
     ELSE '-1'
     END AS consignor_stream_cd,
    TRIM(ea.entitaetsnr) AS invoice_nr,
    TRIM(eb.entitaetsnr) AS booking_type_cd,
    TRIM(t0.referenz) AS invoice_reference_nr,
    SUBSTR(TRIM(tx.freitext), 1, 1000) AS receipt_txt,
    t0.dwh_src_file_name,
    t0.dwh_src_1_tmsp,
    t0.aenddatum AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    t0.dwh_src_file_name AS filename
   FROM (SELECT rechid,
      gpid,
      buchungskzid,
      referenz,
      aenddatum,
      dwh_src_file_name,
      dwh_src_1_tmsp
     FROM szd_production_etl.t_cache_abrech_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY rechid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) = 1) AS
    t0
    INNER JOIN (SELECT entitaetsid,
      entitaetsnr
     FROM szd_production_etl.t_cache_sventitaet_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) =
       1) AS eg ON t0.gpid = eg.entitaetsid
    INNER JOIN (SELECT entitaetsid,
      entitaetsnr,
      mutterid
     FROM szd_production_etl.t_cache_sventitaet_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) =
       1) AS eb ON t0.buchungskzid = eb.entitaetsid
    INNER JOIN (SELECT entitaetsid,
      entitaetsnr
     FROM szd_production_etl.t_cache_sventitaet_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) =
       1) AS ea ON t0.rechid = ea.entitaetsid
    LEFT JOIN (SELECT entitaetsid,
      freitext,
      sprid,
      textnr
     FROM szd_production_etl.t_cache_svtext_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) =
       1) AS tx ON t0.rechid = tx.entitaetsid AND tx.sprid = 165 AND tx.textnr = 1) AS ct
  LEFT JOIN szd_production_meta.t_finance_key_2 AS fk ON ct.finance_key_type_cd = fk.finance_key_type_cd AND ct.finance_id
     = CAST(fk.finance_nat_key_nr AS FLOAT64)
  LEFT JOIN szd_production_core_rel.t_invoice_2 AS i ON fk.finance_sid = i.finance_sid
  LEFT JOIN szd_production_meta.t_party_key_2 AS pak ON ct.consignee_party_key_type_cd = pak.party_key_type_cd AND ct.consignee_party_id
     = pak.party_nat_key_nr
  LEFT JOIN szd_production_core_rel.t_invoice_2 AS ip1 ON pak.party_sid = ip1.consignee_party_sid
 GROUP BY ct.finance_key_type_cd,
  ct.finance_id,
  ct.invoice_type_cd,
  ct.consignee_party_key_type_cd,
  ct.consignee_party_id,
  ct.consignor_stream_cd,
  ct.invoice_nr,
  ct.booking_type_cd,
  ct.invoice_reference_nr,
  ct.receipt_txt,
  ct.dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id);