CREATE OR REPLACE TABLE idq_production_dq_reports.eks_exclude (
exclude_id BIGNUMERIC(38,0) NOT NULL,
rule_id BIGNUMERIC(38,0),
rule_short_description STRING(100),
country_id BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
listingoverviewid BIGNUMERIC(38,0),
exclude_flag BIGNUMERIC(38,0)
);