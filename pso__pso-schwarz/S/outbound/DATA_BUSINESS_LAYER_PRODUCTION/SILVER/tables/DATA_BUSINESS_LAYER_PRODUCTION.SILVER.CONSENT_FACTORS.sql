CREATE OR REPLACE TABLE data_business_layer_production_silver.consent_factors (
date DATE,
country STRING(16777216),
web_app STRING(16777216),
ga_sessions_qty BIGNUMERIC(38,0),
ga_transactions_qty BIGNUMERIC(38,0),
ga_product_revenue_euro_net_val FLOAT64,
ga_revenue_euro_net_val FLOAT64,
sap_orders_bc_br_qty BIGNUMERIC(38,0),
sap_orders_ac_br_qty BIGNUMERIC(38,0),
sap_revenue_bc_br_net_euro_val FLOAT64,
sap_revenue_ac_br_net_euro_val FLOAT64,
factor_transactions_bc_br FLOAT64,
factor_transactions_ac_br FLOAT64,
factor_revenue_bc_br FLOAT64,
factor_revenue_ac_br FLOAT64,
sessions_explorated_qty FLOAT64,
update_date DATE
);