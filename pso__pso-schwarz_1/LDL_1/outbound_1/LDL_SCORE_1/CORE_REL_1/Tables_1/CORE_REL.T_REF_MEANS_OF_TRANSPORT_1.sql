--==============================================================
-- Table: t_ref_means_of_transport_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_means_of_transport_1
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 10:15:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_means_of_transport_1 (
means_of_transport_cd STRING(20) NOT NULL
OPTIONS(description='Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)'),
means_of_transport_descr STRING(100) NOT NULL
OPTIONS(description='Means of transport used in the delivery of goods:Includes:            LKW - truck            CONT - container            SCHIFF -ship            BAHN - train'),
means_of_transport_descr_de STRING(100)
OPTIONS(description='A textual description for the means_of_transport_cd written out in German.'),
means_of_transport_descr_en STRING(100)
OPTIONS(description='A textual description for the means_of_transport_cd written out in English.'),
elm_means_of_transport_id BIGNUMERIC OPTIONS(description='ELM: elm_transtypeid'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (means_of_transport_cd) NOT ENFORCED
)
OPTIONS(description='Means of transport describes the type of transport:  truck (LKW), Kühltrocken-LKW, Kühl_1-LKW, Waggon or Container. ');