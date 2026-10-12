INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, invoice_finance_key_type_cd,
 invoice_finance_id, invoice_status_type_cd)
(SELECT DISTINCT MAX(ct.dwh_src_file_name),
  ct.tf_error_fg,
  MAX(ct.dwh_src_1_tmsp),
   ct.deleted_fg <> 0 AS deleted_fg,
  CAST(ct.record_id AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  MAX(ct.filename),
  ct.invoice_finance_key_type_cd,
  CAST(ct.invoice_finance_id AS STRING) AS invoice_finance_id,
  ct.invoice_status_type_cd
 FROM (SELECT DISTINCT 'INVOICE' AS invoice_finance_key_type_cd,
    t0.rechid AS invoice_finance_id,
     CASE
     WHEN t0.stornokz = 'Y'
     THEN 'CANCEL_INVOICE'
     WHEN t0.stornokz = 'G'
     THEN 'CREDIT_INVOICE'
     WHEN e.inarbeit = 'S'
     THEN 'CANCELLED'
     WHEN e.inarbeit = 'Y'
     THEN 'CHARGED'
     ELSE 'UNCHARGED'
     END AS invoice_status_type_cd,
    t0.dwh_src_file_name,
    t0.dwh_src_1_tmsp,
    t0.aenddatum AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    t0.dwh_src_file_name AS filename
   FROM (SELECT rechid,
      stornokz,
      aenddatum,
      dwh_src_file_name,
      dwh_src_1_tmsp
     FROM szd_production_etl.t_cache_abrech_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY rechid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) = 1) AS
    t0
    INNER JOIN (SELECT entitaetsid,
      inarbeit
     FROM szd_production_etl.t_cache_sventitaet_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) =
       1) AS e ON t0.rechid = e.entitaetsid) AS ct
  LEFT JOIN szd_production_meta.t_finance_key_2 AS fk ON ct.invoice_finance_key_type_cd = fk.finance_key_type_cd AND ct.invoice_finance_id
     = CAST(fk.finance_nat_key_nr AS FLOAT64)
  LEFT JOIN szd_production_core_rel.t_invoice_status_2 AS i ON fk.finance_sid = i.invoice_finance_sid
 GROUP BY ct.invoice_finance_key_type_cd,
  ct.invoice_finance_id,
  ct.invoice_status_type_cd,
  ct.dwh_mapping_tmsp,
  ct.tf_error_fg,
  ct.deleted_fg,
  ct.record_id);
