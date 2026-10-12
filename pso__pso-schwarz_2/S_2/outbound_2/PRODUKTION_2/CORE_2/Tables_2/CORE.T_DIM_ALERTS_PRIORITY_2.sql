--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.03.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_DIM_ALERTS_PRIORITY_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ALERTS_PRIORITY_2
   generated from Powerdesigner on Mittwoch, 17. März 2021 15:26:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_alerts_priority_2 (
alerts_priority_id BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier for the alarm priorities (also containing inactive components)'),
alerts_priority_desc STRING(16777216) NOT NULL
OPTIONS(description='A textual default description for the arlarm priority in German'),
alerts_priority_desc_de STRING(16777216) NOT NULL
OPTIONS(description='A textual description for the arlarm priority in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (alerts_priority_id) NOT ENFORCED
) OPTIONS(description='Dimension table for all translations regarding alarm priority codeing.');