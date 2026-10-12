CREATE OR REPLACE TABLE ldl_data_production_etl.scm_gtin_1 (
extraction_timestamp DATETIME,
excel_rownum INTEGER,
col_int_liefnr_verhandlungspart STRING(100),
col_bezeichnung_verhandlungspart STRING(500),
col_eks_nummer STRING(100),
col_artikelbez STRING(500),
col_gebinde STRING(100),
col_order_gtin STRING(100),
col_kolli_gtin STRING(100),
col_kolliinhalt STRING(100),
col_land STRING(100)
);