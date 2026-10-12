--==============================================================
-- Table: t_ref_transshipment_point_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_transshipment_point_type
   generated from Powerdesigner on Freitag, 3. Mai 2024 08:58:37
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_TRANSSHIPMENT_POINT_TYPE (
   transpoint_type_cd                  VARCHAR(20)     NOT NULL COMMENT 'The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.',
   transpoint_type_descr               VARCHAR(100)    NOT NULL COMMENT 'A textual description for the transpoint_type_cd written out in group language (German).',
   transpoint_type_descr_de            VARCHAR(100)    COMMENT 'A textual description for the transpoint_type_cd written out in German.',
   transpoint_type_descr_en            VARCHAR(100)    COMMENT 'A textual description for the transpoint_type_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_TRANSSHIPMENT_POINT_TYPE PRIMARY KEY (transpoint_type_cd) NOT ENFORCED 
)  COMMENT = 'This entity defines  type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.';
