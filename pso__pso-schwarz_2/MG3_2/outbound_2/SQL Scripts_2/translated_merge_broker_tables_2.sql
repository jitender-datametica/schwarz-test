MERGE INTO szd_production_etl.t_cache_ceva_2 AS n
USING (SELECT job_ref,
  mrn,
  job_type_code,
  SUM(ROUND(SAFE_CAST(item_excise_payment_amount AS BIGNUMERIC), 6)) AS excise_payment_amount,
  SUM(ROUND(SAFE_CAST(item_excise_tax_assessed_amount AS BIGNUMERIC), 6)) AS excise_tax_assessed_amount,
  SUM(ROUND(SAFE_CAST(item_value_for_duty AS BIGNUMERIC), 6)) AS value_for_duty,
  SUM(ROUND(SAFE_CAST(item_duty_payment_amount AS BIGNUMERIC), 6)) AS duty_payment_amount,
  SUM(ROUND(SAFE_CAST(item_duty_tax_assessed_amount AS BIGNUMERIC), 6)) AS duty_tax_assessed_amount,
  SUM(ROUND(SAFE_CAST(item_value_for_vat AS BIGNUMERIC), 6)) AS value_for_vat,
  SUM(ROUND(SAFE_CAST(item_vat_payment_amount AS BIGNUMERIC), 6)) AS vat_payment_amount,
  SUM(ROUND(SAFE_CAST(item_vat_tax_assessed_amount AS BIGNUMERIC), 6)) AS vat_tax_assessed_amount
 FROM szd_production_etl.t_cache_ceva_2
 GROUP BY job_ref,
  mrn,
  job_type_code) AS a
ON n.job_ref = a.job_ref AND n.mrn = a.mrn AND n.job_type_code = a.job_type_code
WHEN MATCHED THEN UPDATE SET
 excise_payment_amount = CAST(a.excise_payment_amount AS STRING),
 excise_tax_assessed_amount = CAST(a.excise_tax_assessed_amount AS STRING),
 value_for_duty = CAST(a.value_for_duty AS STRING),
 duty_payment_amount = CAST(a.duty_payment_amount AS STRING),
 duty_tax_assessed_amount = CAST(a.duty_tax_assessed_amount AS STRING),
 value_for_vat = CAST(a.value_for_vat AS STRING),
 vat_payment_amount = CAST(a.vat_payment_amount AS STRING),
 vat_taxassessed_amount = CAST(a.vat_tax_assessed_amount AS STRING);


MERGE INTO szd_production_etl.t_cache_maersk_lgb_2 AS n
USING (SELECT job_ref,
  mrn,
  job_type_code,
  SUM(ROUND(SAFE_CAST(item_excise_payment_amount AS BIGNUMERIC), 6)) AS excise_payment_amount,
  SUM(ROUND(SAFE_CAST(item_excise_tax_assessed_amount AS BIGNUMERIC), 6)) AS excise_tax_assessed_amount,
  SUM(ROUND(SAFE_CAST(item_value_for_duty AS BIGNUMERIC), 6)) AS value_for_duty,
  SUM(ROUND(SAFE_CAST(item_duty_payment_amount AS BIGNUMERIC), 6)) AS duty_payment_amount,
  SUM(ROUND(SAFE_CAST(item_duty_tax_assessed_amount AS BIGNUMERIC), 6)) AS duty_tax_assessed_amount,
  SUM(ROUND(SAFE_CAST(item_value_for_vat AS BIGNUMERIC), 6)) AS value_for_vat,
  SUM(ROUND(SAFE_CAST(item_vat_payment_amount AS BIGNUMERIC), 6)) AS vat_payment_amount,
  SUM(ROUND(SAFE_CAST(item_vat_tax_assessed_amount AS BIGNUMERIC), 6)) AS vat_tax_assessed_amount
 FROM szd_production_etl.t_cache_maersk_lgb_2
 GROUP BY job_ref,
  mrn,
  job_type_code) AS a
ON n.job_ref = a.job_ref AND n.mrn = a.mrn AND n.job_type_code = a.job_type_code
WHEN MATCHED THEN UPDATE SET
 excise_payment_amount = CAST(a.excise_payment_amount AS STRING),
 excise_tax_assessed_amount = CAST(a.excise_tax_assessed_amount AS STRING),
 value_for_duty = CAST(a.value_for_duty AS STRING),
 duty_payment_amount = CAST(a.duty_payment_amount AS STRING),
 duty_tax_assessed_amount = CAST(a.duty_tax_assessed_amount AS STRING),
 value_for_vat = CAST(a.value_for_vat AS STRING),
 vat_payment_amount = CAST(a.vat_payment_amount AS STRING),
 vat_taxassessed_amount = CAST(a.vat_tax_assessed_amount AS STRING);


MERGE INTO szd_production_etl.t_cache_maersk_lukt_2 AS n
USING (SELECT job_ref,
  mrn,
  job_type_code,
  SUM(ROUND(SAFE_CAST(item_excise_payment_amount AS BIGNUMERIC), 6)) AS excise_payment_amount,
  SUM(ROUND(SAFE_CAST(item_excise_tax_assessed_amount AS BIGNUMERIC), 6)) AS excise_tax_assessed_amount,
  SUM(ROUND(SAFE_CAST(item_value_for_duty AS BIGNUMERIC), 6)) AS value_for_duty,
  SUM(ROUND(SAFE_CAST(item_duty_payment_amount AS BIGNUMERIC), 6)) AS duty_payment_amount,
  SUM(ROUND(SAFE_CAST(item_duty_tax_assessed_amount AS BIGNUMERIC), 6)) AS duty_tax_assessed_amount,
  SUM(ROUND(SAFE_CAST(item_value_for_vat AS BIGNUMERIC), 6)) AS value_for_vat,
  SUM(ROUND(SAFE_CAST(item_vat_payment_amount AS BIGNUMERIC), 6)) AS vat_payment_amount,
  SUM(ROUND(SAFE_CAST(item_vat_tax_assessed_amount AS BIGNUMERIC), 6)) AS vat_tax_assessed_amount
 FROM szd_production_etl.t_cache_maersk_lukt_2
 GROUP BY job_ref,
  mrn,
  job_type_code) AS a
ON n.job_ref = a.job_ref AND n.mrn = a.mrn AND n.job_type_code = a.job_type_code
WHEN MATCHED THEN UPDATE SET
 excise_payment_amount = CAST(a.excise_payment_amount AS STRING),
 excise_tax_assessed_amount = CAST(a.excise_tax_assessed_amount AS STRING),
 value_for_duty = CAST(a.value_for_duty AS STRING),
 duty_payment_amount = CAST(a.duty_payment_amount AS STRING),
 duty_tax_assessed_amount = CAST(a.duty_tax_assessed_amount AS STRING),
 value_for_vat = CAST(a.value_for_vat AS STRING),
 vat_payment_amount = CAST(a.vat_payment_amount AS STRING),
 vat_taxassessed_amount = CAST(a.vat_tax_assessed_amount AS STRING);