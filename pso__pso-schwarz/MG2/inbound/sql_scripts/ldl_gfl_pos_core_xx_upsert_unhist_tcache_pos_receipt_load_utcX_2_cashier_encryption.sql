!SET exit_on_error=True;

MERGE INTO core_app_fraud_detection.t_cashier_encryption AS tgt
USING 
  (
    ( SELECT bic_zmlila, receipt_business_date, orig_store_nr, checker_hash, checker_id,
      FROM etl.t_tcache_pos_receipt_load_utca
      WHERE checker_id IS NOT NULL and checker_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receipt_authority_hash AS checker_hash, receipt_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utca
      WHERE receipt_authority_id IS NOT NULL and receipt_authority_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receiptline_authority_hash AS checker_hash, receiptline_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utca
      WHERE receiptline_authority_id IS NOT NULL and receiptline_authority_hash <> '@'
    )
    UNION
    ( SELECT bic_zmlila, receipt_business_date, orig_store_nr, checker_hash, checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb1
      WHERE checker_id IS NOT NULL and checker_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receipt_authority_hash AS checker_hash, receipt_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb1
      WHERE receipt_authority_id IS NOT NULL and receipt_authority_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receiptline_authority_hash AS checker_hash, receiptline_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb1
      WHERE receiptline_authority_id IS NOT NULL and receiptline_authority_hash <> '@'
    )
    UNION
    ( SELECT bic_zmlila, receipt_business_date, orig_store_nr, checker_hash, checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb2
      WHERE checker_id IS NOT NULL and checker_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receipt_authority_hash AS checker_hash, receipt_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb2
      WHERE receipt_authority_id IS NOT NULL and receipt_authority_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receiptline_authority_hash AS checker_hash, receiptline_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb2
      WHERE receiptline_authority_id IS NOT NULL and receiptline_authority_hash <> '@'
    )
    UNION
    ( SELECT bic_zmlila, receipt_business_date, orig_store_nr, checker_hash, checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb3
      WHERE checker_id IS NOT NULL and checker_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receipt_authority_hash AS checker_hash, receipt_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb3
      WHERE receipt_authority_id IS NOT NULL and receipt_authority_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receiptline_authority_hash AS checker_hash, receiptline_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcb3
      WHERE receiptline_authority_id IS NOT NULL and receiptline_authority_hash <> '@'
    )
    UNION
    ( SELECT bic_zmlila, receipt_business_date, orig_store_nr, checker_hash, checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcc
      WHERE checker_id IS NOT NULL and checker_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receipt_authority_hash AS checker_hash, receipt_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcc
      WHERE receipt_authority_id IS NOT NULL and receipt_authority_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receiptline_authority_hash AS checker_hash, receiptline_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcc
      WHERE receiptline_authority_id IS NOT NULL and receiptline_authority_hash <> '@'
    )
    UNION
    ( SELECT bic_zmlila, receipt_business_date, orig_store_nr, checker_hash, checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcd
      WHERE checker_id IS NOT NULL and checker_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receipt_authority_hash AS checker_hash, receipt_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcd
      WHERE receipt_authority_id IS NOT NULL and receipt_authority_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receiptline_authority_hash AS checker_hash, receiptline_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utcd
      WHERE receiptline_authority_id IS NOT NULL and receiptline_authority_hash <> '@'
    )
    UNION
    ( SELECT bic_zmlila, receipt_business_date, orig_store_nr, checker_hash, checker_id,
      FROM etl.t_tcache_pos_receipt_load_utce
      WHERE checker_id IS NOT NULL and checker_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receipt_authority_hash AS checker_hash, receipt_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utce
      WHERE receipt_authority_id IS NOT NULL and receipt_authority_hash <> '@'
      UNION
      SELECT bic_zmlila, receipt_business_date, orig_store_nr, receiptline_authority_hash AS checker_hash, receiptline_authority_id AS checker_id,
      FROM etl.t_tcache_pos_receipt_load_utce
      WHERE receiptline_authority_id IS NOT NULL and receiptline_authority_hash <> '@'
    )
   ) AS src
      ON ( tgt.cashier_hash=src.checker_hash )
WHEN NOT MATCHED
THEN INSERT 
  (
   cashier_hash, 
   bus_dt, 
   store_nr, 
   country_org_cd, 
   cashier_nr, 
   dwh_created_tmsp, 
   dwh_updated_tmsp, 
   dwh_load_id, 
   dwh_node_cd   
   )
VALUES 
  (
   src.checker_hash, 
   src.receipt_business_date, 
   src.orig_store_nr, 
   src.bic_zmlila, 
   src.checker_id, 
   CURRENT_TIMESTAMP, 
   CURRENT_TIMESTAMP, 
   ${LOAD_ID},
   'EJR'
  )
;
