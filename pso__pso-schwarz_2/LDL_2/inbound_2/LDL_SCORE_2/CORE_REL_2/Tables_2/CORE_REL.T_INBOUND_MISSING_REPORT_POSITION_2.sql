--==============================================================
-- Table: t_inbound_missing_report_position_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_inbound_missing_report_position_2
   generated from Powerdesigner on Mittwoch, 4. September 2024 14:16:22
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INBOUND_MISSING_REPORT_POSITION_2 (
   report_dt                           DATE             COMMENT 'date when the missing quantity was reported (e.g. sent by mail)',
   report_party_sid                    NUMBER           COMMENT 'unique identifier of the party that reported the missing quantity (e.g. Cross-Dock operator)',
   inbound_dispo_order_pos_sid         NUMBER           NOT NULL COMMENT 'unique identifier of the order position that is transported',
   receive_site_sid                    NUMBER           COMMENT 'unique identifier of the site that (was expected to) receive the delivery of the product',
   logistic_unit_cd                    VARCHAR(20)      COMMENT 'code for the logistic unit_2 in which the quantity is declared, e.g. pallets,cases, or piece',
   missing_qty                         NUMBER(38, 5)    COMMENT 'which quantity was missing at delivery',
   missing_reason_cd                   VARCHAR(20)      COMMENT 'A code defining why a (part of) a dispo order position was declared as being missing',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_INBOUND_MISSING_REPORT_POSITION PRIMARY KEY (inbound_dispo_order_pos_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'The entity contains the reported missing quantities of order positions.';
