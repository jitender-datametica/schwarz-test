CREATE TABLE CORE.T_FACT_TRUCK_DELIVERIES_1 (
   SUPPLIER_PARTY_SID   NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the supplier.',
   HAULER_PARTY_SID     NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the hauler.',
   RECIPIENT_PARTY_SID  NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the recipient.',
   DISPOWEEK_DT         DATE             NOT NULL COMMENT 'The date of the first day of the dispo week.',
   OUTBOUND_DT          DATE             NOT NULL COMMENT 'The date on which the goods were dispatched.',
   ARRIVAL_DT           DATE             NOT NULL COMMENT 'The date when the goods arrived at the recipient.',
   PROMOTION_DT         DATE             NOT NULL COMMENT 'The promotion date.',
   PLANNED_DELIVERY_DT  DATE             NOT NULL COMMENT 'The planned delivery date.',
   DELIVERY_DT          DATE             NOT NULL COMMENT 'The delivery date.',
   DELIVERY_NOTE_NR     VARCHAR(50)      NOT NULL COMMENT 'The business identification number of the delivery note.',
   DELIVERY_DATE_FIXED_FG BOOLEAN        NOT NULL COMMENT 'Flag indicating that the delivery date is fixed.',
   TOTAL_CNT            NUMBER(38,0)     NOT NULL COMMENT 'Fact - additive - The total count of delivery trucks.',
   OUTBOUND_CNT         NUMBER(38,0)     NOT NULL COMMENT 'Fact - additive - The count of trucks that has started.',
   ARRIVED_CNT          NUMBER(38,0)     NOT NULL COMMENT 'Fact - additive - The count of trucks that arrived at the recipient.',
   DWH_CREATED_TMSP     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_FACT_TRUCK_DELIVERIES PRIMARY KEY (SUPPLIER_PARTY_SID, HAULER_PARTY_SID, RECIPIENT_PARTY_SID, DISPOWEEK_DT, OUTBOUND_DT, ARRIVAL_DT, PROMOTION_DT, PLANNED_DELIVERY_DT, DELIVERY_DT, DELIVERY_DATE_FIXED_FG) 
) COMMENT = 'Fact table - Analytical - Granularity - by week, supplier_1, hauler, recipient - Aggregate - Contains analytical facts regarding the count of trucks delivering goods to a recipient. - Source - LExIS';
