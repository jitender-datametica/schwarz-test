CREATE TABLE CORE_REL.T_REF_PALLET_TYPE_2 (
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'A code for the pallet that indicates the storage occupation for transportation.',
   pallet_type_descr                   VARCHAR(100)    NOT NULL COMMENT 'A textual description for the pallet_type_cd written out in group language (German).',
   pallet_type_descr_de                VARCHAR(100)    COMMENT 'A textual description for the pallet_type_cd written out in German.',
   pallet_type_descr_en                VARCHAR(100)    COMMENT 'A textual description for the pallet_type_cd written out in English.',
   pallet_type_factor                  NUMBER(38, 5)   COMMENT 'Space requirement of the pallet type compared to space requirement of Euro Pallet. eg. 1DD = 0,5 EP ',
   octopus_pallet_type_id              NUMBER          COMMENT 'External system numeric code',
   elm_pallet_type_id                  NUMBER          COMMENT 'ELM: elm_pallettypeid',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_PALLET_TYPE PRIMARY KEY (pallet_type_cd) NOT ENFORCED 
)  COMMENT = 'Lists the types of pallets used for transportation. Euro pallet or Düsseldorf pallet';
