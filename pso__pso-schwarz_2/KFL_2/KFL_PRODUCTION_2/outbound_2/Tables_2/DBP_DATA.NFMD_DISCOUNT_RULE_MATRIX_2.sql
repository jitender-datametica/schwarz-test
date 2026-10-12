--==============================================================
-- Table: nfmd_discount_rule_matrix_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_discount_rule_matrix_2
   generated from Powerdesigner on 2023-01-09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nfmd_discount_rule_matrix_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
price_class_cd STRING(20) NOT NULL OPTIONS(description='grouping of original price for classification (ex "A: 1 -2")'),
hwg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Hauptwarengruppenid'),
curve_type_cd BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Type of model curve for this Store and Article'),
experiment_group_cd STRING(10) NOT NULL
OPTIONS(description='For A/B testing this shows if this is the "A" group or the "B" group'),
rule_created_dt DATE NOT NULL OPTIONS(description='creation date of the rule matrix for this Store and Article'),
sell_wk34_from_wk3_rate_min BIGNUMERIC(38,5) DEFAULT 0.0 NOT NULL
OPTIONS(description='minimum sell ratio of week 3 and 4 based on stock of week 3 (as a number between 0.0 and 1.0)'),
sell_wk34_from_wk3_rate_max BIGNUMERIC(38,5) DEFAULT 1.0 NOT NULL
OPTIONS(description='maximum sell ratio of week 3 and 4 based on stock of week 3 (as a number between 0.0 and 1.0)'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
suggested_discount_rate BIGNUMERIC(38,5) OPTIONS(description='Suggested discount rate (value between 0.0 and 1.0)'),
rule_decision_record STRING(100)
OPTIONS(description='the four dimentions of a rule matrix concatenated as a string (curve_type_cd, hwg_id, price_class_cd, sell_wk34_from_wk3_rate)'),
rule_status STRING(20)
OPTIONS(description='Status_2 if this rule is still active. Group A rule is deactivated if they are overwritten by a group B rule. Group B rule is deactivated if the experiment is finished.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, price_class_cd, hwg_id, curve_type_cd, experiment_group_cd, rule_created_dt,
 sell_wk34_from_wk3_rate_min, sell_wk34_from_wk3_rate_max) NOT ENFORCED
)
OPTIONS(description='This table shows which discount is suggested. This is determined based on the price, HWG and the sales_2 ratio');