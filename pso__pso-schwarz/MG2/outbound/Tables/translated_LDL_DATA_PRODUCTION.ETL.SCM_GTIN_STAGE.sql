CREATE OR REPLACE TABLE ldl_data_production_etl.scm_gtin_stage (
extraction_timestamp DATETIME,
excel_rownum INTEGER,
col_int_liefnr_verhandlungspart INTEGER,
col_bezeichnung_verhandlungspart STRING(500),
col_eks_nummer INTEGER,
col_artikelbez STRING(500),
col_gebinde STRING(100),
col_order_gtin INTEGER,
col_kolli_gtin INTEGER,
col_kolliinhalt INTEGER,
col_land STRING(100)
);