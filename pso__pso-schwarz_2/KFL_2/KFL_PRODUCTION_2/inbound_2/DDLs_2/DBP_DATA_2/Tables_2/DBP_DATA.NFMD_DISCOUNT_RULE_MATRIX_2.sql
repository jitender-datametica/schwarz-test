--==============================================================
-- Table: nfmd_discount_rule_matrix_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_discount_rule_matrix_2
   generated from Powerdesigner on 2023-01-09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NFMD_DISCOUNT_RULE_MATRIX_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   price_class_cd                      VARCHAR(20)     NOT NULL COMMENT 'grouping of original price for classification (ex "A: 1 -2")',
   hwg_id                              NUMBER(38,0)    NOT NULL COMMENT 'Hauptwarengruppenid',
   curve_type_cd                       NUMBER(38,0)    NOT NULL COMMENT 'Type of model curve for this Store and Article',
   experiment_group_cd                 VARCHAR(10)     NOT NULL COMMENT 'For A/B testing this shows if this is the "A" group or the "B" group',
   rule_created_dt                     DATE            NOT NULL COMMENT 'creation date of the rule matrix for this Store and Article',
   sell_wk34_from_wk3_rate_min         NUMBER(38,5)    DEFAULT 0.0 NOT NULL COMMENT 'minimum sell ratio of week 3 and 4 based on stock of week 3 (as a number between 0.0 and 1.0)',
   sell_wk34_from_wk3_rate_max         NUMBER(38,5)    DEFAULT 1.0 NOT NULL COMMENT 'maximum sell ratio of week 3 and 4 based on stock of week 3 (as a number between 0.0 and 1.0)',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   suggested_discount_rate             NUMBER(38,5)    COMMENT 'Suggested discount rate (value between 0.0 and 1.0)',
   rule_decision_record                VARCHAR(100)    COMMENT 'the four dimentions of a rule matrix concatenated as a string (curve_type_cd, hwg_id, price_class_cd, sell_wk34_from_wk3_rate)',
   rule_status                         VARCHAR(20)     COMMENT 'Status_2 if this rule is still active. Group A rule is deactivated if they are overwritten by a group B rule. Group B rule is deactivated if the experiment is finished.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_NFMD_DISCOUNT_RULE_MATRIX PRIMARY KEY (mandant_id, price_class_cd, hwg_id, curve_type_cd, experiment_group_cd, rule_created_dt, sell_wk34_from_wk3_rate_min, sell_wk34_from_wk3_rate_max) NOT ENFORCED
)  COMMENT = 'This table shows which discount is suggested. This is determined based on the price, HWG and the sales_2 ratio';
