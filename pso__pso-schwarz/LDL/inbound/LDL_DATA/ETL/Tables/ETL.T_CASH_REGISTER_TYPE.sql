CREATE TABLE ETL.T_CASH_REGISTER_TYPE (
   cash_register_type_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   cash_register_type_descr            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of cash register. (standard cash register, self-checkout system, vending machine)',
   CONSTRAINT PK_T_CASH_REGISTER_TYPE PRIMARY KEY (cash_register_type_cd, lang_cd) NOT ENFORCED
)  COMMENT= 'This minor entity defines the cash register type. It distinguishes between standard cash registers, self-checkout systems and vending machines.'
;