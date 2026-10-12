CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.akt_msi_user (
user_id STRING(240) NOT NULL,
session_id INTEGER DEFAULT - 1
) OPTIONS(description='GT-Tabelle zur Übermittlung des aktuellen MSI-Users');