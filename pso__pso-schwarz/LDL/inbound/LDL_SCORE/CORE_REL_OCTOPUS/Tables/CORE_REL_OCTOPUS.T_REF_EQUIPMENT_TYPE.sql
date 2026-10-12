CREATE TABLE CORE_REL_OCTOPUS.T_REF_EQUIPMENT_TYPE (
   equipment_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The type discriminator for this equipment, i.e. vehicle(truck)',
   equipment_type_descr                VARCHAR(100)    COMMENT 'Description for this equipment code, i.e. vehicle(truck) e.g.Jumbo/Megas,Planen-LKW, Kühl-LKW,Seecontainer 45`pw reefer',
   equipment_type_descr_de             VARCHAR(100)    COMMENT 'Description in German for this equipment code',
   equipment_type_descr_en             VARCHAR(100)    COMMENT 'Description in English  for this equipment code',
   equipment_type_external_id          NUMBER          COMMENT 'External system numeric code',
   means_of_transport_cd               VARCHAR(20)     COMMENT 'Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_EQUIPMENT_TYPE PRIMARY KEY (equipment_type_cd) NOT ENFORCED 
)  COMMENT = 'Defines a type of vehicle i.e. Sprinter, Seecontainer.';
