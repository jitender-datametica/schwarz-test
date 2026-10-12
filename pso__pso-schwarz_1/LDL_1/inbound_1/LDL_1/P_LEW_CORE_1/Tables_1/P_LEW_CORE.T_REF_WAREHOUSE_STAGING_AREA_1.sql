/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_staging_area_1
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 11:35:08
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_WAREHOUSE_STAGING_AREA_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT.',
   wh_loc_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Warehouse; FK auf LOCATION.',
   wh_staging_area_cd                  VARCHAR(100)     NOT NULL COMMENT 'Code for the warehouse staging area to which the docking gate belongs.',
   wh_staging_area_descr               VARCHAR(250)     COMMENT 'Description of the warehouse staging area to which the docking area belongs.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_WAREHOUSE_STAGING_AREA PRIMARY KEY (wh_loc_sid, wh_staging_area_cd) NOT ENFORCED 
)  COMMENT = 'Table contains the staging areas in a warehouse. Staging areas connect docking gates with the warehouse. They are an intermediate storage and processing area.
             Source:
             WAWI table T170_GINGATETYPES_1
             EWM table T301';
