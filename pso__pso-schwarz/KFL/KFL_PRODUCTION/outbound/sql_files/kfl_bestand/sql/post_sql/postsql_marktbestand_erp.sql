CREATE OR REPLACE TABLE dbp_etl.marktbestand_erp_temp AS
SELECT *
FROM ${TEMP_TABLE};
