CREATE TABLE CORE_REL_OCTOPUS.T_ROUTE_SEGMENT_SUPPLIER_COST (
   route_segment_agmt_elem_sid         NUMBER          NOT NULL COMMENT 'Surrogate identifier for Agreement element',
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'The type of pallet (Euro-palllet or Duesseldorfer pallet) on which this item variant is typically transported.',
   validity_period_from_tmsp           TIMESTAMP_TZ(9) NOT NULL COMMENT 'Validity start',
   validity_period_to_tmsp             TIMESTAMP_TZ(9) NOT NULL COMMENT 'Valid to',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   pallet_net_price                    NUMBER(38, 5)   NOT NULL COMMENT 'Agreed netto price per pallet including service charge',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_ROUTE_SEGMENT_SUPPLIER_COST PRIMARY KEY (route_segment_agmt_elem_sid, dwh_valid_from_tmsp, pallet_type_cd, validity_period_from_tmsp, validity_period_to_tmsp, curr_cd) NOT ENFORCED 
)  COMMENT = 'Table contains cost, which supplier pays to the hauler for a specific agreement element. The cost depends on pallet type. The cost is negotiated for validity period, contracts type ''Logistik'', route segment agreement element.';
