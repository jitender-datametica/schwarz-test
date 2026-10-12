CREATE OR REPLACE TABLE ugs_aris_production_core.t_dim_tenant_1 (
dwh_tenant_cd STRING(8) NOT NULL OPTIONS(description='The code for the data warehoue tenant.'),
dwh_tenant_name STRING(100) NOT NULL
OPTIONS(description='The name for the data warehouse tenant in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.')
)
OPTIONS(description='In terms of a multi-tenancy concept a tenant is the\"high-level\" client, defining the major line of business. Currently these are:\n                                     - Kaufland\n                                     - Lidl\n                                     - Greencycle\n                                     - Production companies (e.g. MEG)\n                                     - SDL / SZD (S-Gesellschaften)');