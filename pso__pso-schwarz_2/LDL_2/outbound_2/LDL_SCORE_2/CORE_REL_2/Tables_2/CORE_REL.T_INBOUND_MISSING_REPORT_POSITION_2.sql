--==============================================================
-- Table: t_inbound_missing_report_position_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_inbound_missing_report_position_2
   generated from Powerdesigner on Mittwoch, 4. September 2024 14:16:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_inbound_missing_report_position_2 (
report_dt DATE OPTIONS(description='date when the missing quantity was reported (e.g. sent by mail)'),
report_party_sid BIGNUMERIC
OPTIONS(description='unique identifier of the party that reported the missing quantity (e.g. Cross-Dock operator)'),
inbound_dispo_order_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='unique identifier of the order position that is transported'),
receive_site_sid BIGNUMERIC
OPTIONS(description='unique identifier of the site that (was expected to) receive the delivery of the product'),
logistic_unit_cd STRING(20)
OPTIONS(description='code for the logistic unit_2 in which the quantity is declared, e.g. pallets,cases, or piece'),
missing_qty BIGNUMERIC(38,5) OPTIONS(description='which quantity was missing at delivery'),
missing_reason_cd STRING(20)
OPTIONS(description='A code defining why a (part of) a dispo order position was declared as being missing'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (inbound_dispo_order_pos_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The entity contains the reported missing quantities of order positions.');