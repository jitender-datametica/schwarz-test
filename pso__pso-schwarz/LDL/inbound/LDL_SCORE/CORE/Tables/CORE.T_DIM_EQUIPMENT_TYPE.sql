--==============================================================
-- Table: t_dim_equipment_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_equipment_type
   generated from Powerdesigner on Donnerstag, 25. Juli 2024 09:24:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_EQUIPMENT_TYPE (
   equipment_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The type discriminator for this equipment, i.e. vehicle(truck)',
   equipment_type_descr                VARCHAR(100)    COMMENT 'Description for this equipment code, i.e. vehicle(truck) e.g.Jumbo/Megas,Planen-LKW, Kühl-LKW,Seecontainer 45`pw reefer',
   equipment_type_descr_de             VARCHAR(100)    COMMENT 'Description in German for this equipment code',
   equipment_type_descr_en             VARCHAR(100)    COMMENT 'Description in English  for this equipment code',
   equipment_type_external_id          NUMBER          COMMENT 'External system numeric code',
   equipment_capacity_ep_pallet_cnt    NUMBER          COMMENT 'Number of EP pallets that can fit in the vehicle',
   equipment_capacity_dd_pallet_cnt    NUMBER          COMMENT 'Number of DD pallets that can fit in the vehicle',
   means_of_transport_cd               VARCHAR(20)     COMMENT 'Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_EQUIPMENT_TYPE PRIMARY KEY (equipment_type_cd) NOT ENFORCED 
)  COMMENT = 'Type of vehicle i.e. Koffer';
