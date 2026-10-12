--==============================================================
-- Table: T_DIM_MACHINE_STATUS
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MACHINE_STATUS
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_machine_status (
machine_status_cd BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the status of the machine.'),
machine_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description of the code for the status of the machine.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (machine_status_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - for describing the status for different machines in a Plant - Source - Calculated Master Data (indirect). Extraction from production line parameter master data from defined sensor data. ');