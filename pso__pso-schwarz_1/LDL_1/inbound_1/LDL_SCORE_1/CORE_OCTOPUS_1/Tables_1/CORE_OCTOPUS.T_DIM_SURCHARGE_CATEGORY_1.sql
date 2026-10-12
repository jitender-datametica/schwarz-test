CREATE TABLE CORE_OCTOPUS.T_DIM_SURCHARGE_CATEGORY_1 (
   surcharge_categ_cd                  VARCHAR(20)     NOT NULL COMMENT 'This is a code, which defines the charge categories. Charge Category group a charge type.',
   surcharge_categ_name                VARCHAR(100)    NOT NULL COMMENT 'This is a name, which defines the charge categories. Charge Category group a charge type.',
   surcharge_categ_name_de             VARCHAR(100)    COMMENT 'This is a name, which defines the charge categories. Charge Category group a charge type (in German).',
   surcharge_categ_name_en             VARCHAR(100)    COMMENT 'This is a name, which defines the charge categories. Charge Category group a charge type (in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_SURCHARGE_CATEGORY PRIMARY KEY (surcharge_categ_cd) NOT ENFORCED 
)  COMMENT = 'This dimension defines the surcharge categories, Surcharge Category is a grouping of several Surcharge types.';
