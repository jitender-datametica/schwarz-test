--==============================================================
-- Table: t_dim_transshipment_point_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_transshipment_point_type
   generated from Powerdesigner on Dienstag, 2. April 2024 09:29:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_transshipment_point_type (
transpoint_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.'),
transpoint_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the transpoint_type_cd written out in group language (German).'),
transpoint_type_descr_de STRING(100)
OPTIONS(description='A textual description for the transpoint_type_cd written out in German.'),
transpoint_type_descr_en STRING(100)
OPTIONS(description='A textual description for the transpoint_type_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (transpoint_type_cd) NOT ENFORCED
) OPTIONS(description='This dimension defines  type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.');