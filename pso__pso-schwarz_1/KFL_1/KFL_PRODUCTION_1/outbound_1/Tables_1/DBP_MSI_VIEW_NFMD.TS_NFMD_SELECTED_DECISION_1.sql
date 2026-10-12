CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_selected_decision_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
markdown_decision_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of price reduction (markdown) decision'),
user_id STRING(255) NOT NULL OPTIONS(description='AD name of the user who created the record')
)
OPTIONS(description='When user selects a decision in the fronted for Massenbarbeitung - JF Verwertung, the decision_id is inserted here.');