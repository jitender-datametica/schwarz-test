--==============================================================
-- Table: t_ref_dispo_order_change_reason
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_dispo_order_change_reason
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 08:54:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_DISPO_ORDER_CHANGE_REASON (
   dispo_order_change_reason_cd        VARCHAR(20)     NOT NULL COMMENT 'The code which includes the changes in the order status (e.g. addition order, order quantity increase etc.)',
   dispo_order_change_reason_descr     VARCHAR(100)    NOT NULL COMMENT 'A textual description for the dispo_order_change_reason_cd  written out in group language (German).',
   dispo_order_change_reason_descr_de  VARCHAR(100)    COMMENT 'A textual description for the dispo_order_change_reason_cd written out in German.',
   dispo_order_change_reason_descr_en  VARCHAR(100)    COMMENT 'A textual description for thedispo_order_change_reason_cd written out in English.',
   elm_dispo_order_change_reason_id    NUMBER          COMMENT 'ELM: elm_corrtypeid, e.g. reason_id = 0 (keine Änderung), 1 = Neue Bestellposition etc . ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_DISPO_ORDER_CHANGE_REASON PRIMARY KEY (dispo_order_change_reason_cd) NOT ENFORCED 
)  COMMENT = 'Reason of the changes in the order status (e.g. addition order, order quantity increase etc.)';
