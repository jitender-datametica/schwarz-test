/* --------------------------------------------------------------------------------
   DDL for table: t_plan_by_month
   generated from Powerdesigner on Dienstag, 16. Januar 2024 10:55:10
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PLAN_BY_MONTH (
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   int_org_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   cal_month                           NUMBER(38, 0)   NOT NULL COMMENT 'The identifier of a calendar month in the form YYYYMM. E.g. 202101 für January 2021.',
   planned_val_type_sid                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.',
   plan_pos_nr                         VARCHAR(20)     NOT NULL COMMENT 'The planning position is identified in the operational planning system by a number. As several positions may be planned for the same Planned Value Type, this attribute is part of the key. In particular, the planning position number is used for plan values for stores, which have not been opened yet. A dummy number is assigned for these stores, and the planned value is related to the related internal company. (Once the real store number is known, the plan value for the internal company is expired in history, and a new plan value is added for the store.)',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   planned_kpi_meas                    NUMBER(38, 5)   NOT NULL COMMENT 'The planned value.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PLAN_BY_MONTH PRIMARY KEY (planned_val_type_sid, real_estate_sid, cal_month, int_org_sid, plan_pos_nr, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'Certain KPIs (such as revenue or customer count) get planned ahead of time. This entity tracks values which are planned on monthly level. The kind of KPI is defined by the Planned Value Type Code.';
