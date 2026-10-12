/* --------------------------------------------------------------------------------
   DDL for table: t_payment_line_type_1
   generated from Powerdesigner on Mittwoch, 15. Mai 2024 12:01:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PAYMENT_LINE_TYPE_1 (
   paym_line_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   paym_line_type_descr                VARCHAR(250)    NOT NULL COMMENT 'A textual description for the subtype discriminator for payment lines.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PAYMENT_LINE_TYPE PRIMARY KEY (paym_line_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the subtye discriminators for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.';
