/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_zone
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:00:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_WAREHOUSE_ZONE (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   wh_loc_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Warehouse; FK auf LOCATION',
   wh_zone_nr                          VARCHAR(100)     NOT NULL COMMENT 'Code for the WH area of activity.',
   wh_zone_descr                       VARCHAR(250)              COMMENT 'Description of the WH area of activity.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_WAREHOUSE_ZONE PRIMARY KEY (wh_loc_sid, wh_zone_nr) NOT ENFORCED 
)  COMMENT = 'Table contains the warehouse area where the activity is to be performed.';
