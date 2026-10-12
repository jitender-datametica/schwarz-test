--==============================================================
-- Table: t_dim_logistics_agreement_area_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistics_agreement_area_1
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:37:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LOGISTICS_AGREEMENT_AREA_1 (
   logistics_agmt_area_cd              VARCHAR(20)     NOT NULL COMMENT 'Code of Logistics agreement area, for example: IMP/LOG.',
   logistics_agmt_area_descr           VARCHAR(100)    COMMENT 'Description of logistics agreement area, for example: Import/Logistik.',
   logistics_agmt_area_descr_de        VARCHAR(100)    COMMENT 'Description of logistics agreement area in English.',
   logistics_agmt_area_descr_en        VARCHAR(100)    COMMENT 'Description of logistics agreement area in German.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_LOGISTICS_AGREEMENT_AREA PRIMARY KEY (logistics_agmt_area_cd) NOT ENFORCED 
)  COMMENT = 'This table defines areas of logistics agreement. For example Logistics and Import.';
