CREATE OR REPLACE TABLE core_dim.t_dim_invoice_record_type_2 (
record_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
record_type_bez STRING(100) OPTIONS(description='Manuell befüllt'),
PRIMARY KEY (record_type_id) NOT ENFORCED
) OPTIONS(description='Invoice Eintrag Typen.\n             0 = Rechnung\n             1 = Nachbelastung');