/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_rating_score_type_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:30:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_rating_score_type_1 (
nfpo_rating_score_type_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO RATING SCORE TYPE            LDL: p_lew_core.t_ref_rating_score_type.rating_score_type_sid'),
nfpo_rating_score_type_name STRING(100) NOT NULL
OPTIONS(description='Name of the nfpo rating score type            LDL: p_lew_core.t_ref_rating_score_type.rating_score_type_name'),
nfpo_rating_score_type_descr STRING(250) NOT NULL
OPTIONS(description='Description of the nfpo rating score type            LDL: p_lew_core.t_ref_rating_score_type.raqting_score_type_descr'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: p_lew_core.t_ref_rating_score_type..DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: p_lew_core.t_ref_rating_score_type..DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_rating_score_type_sid) NOT ENFORCED
)
OPTIONS(description='This table contains rating score types. A rating score type is a certain well defined calculation which will be calculated if a rating model is applied. The result will be stored as an intermediate or final result to allow the assignement of entities to rating classes.             LDL: p_lew_core.t_ref_rating_score_type_1');