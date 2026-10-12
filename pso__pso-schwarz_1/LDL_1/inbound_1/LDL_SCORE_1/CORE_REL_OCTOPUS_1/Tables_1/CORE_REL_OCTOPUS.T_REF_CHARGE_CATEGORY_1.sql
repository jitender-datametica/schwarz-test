CREATE TABLE CORE_REL_OCTOPUS.T_REF_CHARGE_CATEGORY_1 (
   charge_categ_cd                     VARCHAR(20)     NOT NULL COMMENT 'This is a code, which defines the charge categories. Charge Category group a charge type.',
   charge_categ_name                   VARCHAR(100)    NOT NULL COMMENT 'This is a name, which defines the charge categories. Charge Category group a charge type.',
   charge_categ_name_de                VARCHAR(100)    COMMENT 'This is a name, which defines the charge categories. Charge Category group a charge type (in German).',
   charge_categ_name_en                VARCHAR(100)    COMMENT 'This is a name, which defines the charge categories. Charge Category group a charge type (in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_CHARGE_CATEGORY PRIMARY KEY (charge_categ_cd) NOT ENFORCED 
)  COMMENT = 'This table defines the charge categories, Charge Category is a grouping of several charge types.';
