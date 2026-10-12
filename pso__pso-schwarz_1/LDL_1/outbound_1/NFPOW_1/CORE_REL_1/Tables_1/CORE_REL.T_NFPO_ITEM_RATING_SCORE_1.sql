/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating_score_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:31:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_rating_score_1 (
nfpo_item_rating_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for rating of an item_1            LDL: p_lew_core.t_item_rating_score.item_rating_sid'),
nfpo_rating_score_type_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO RATING SCORE TYPE            LDL: p_lew_core.t_item_rating_score.rating_score_type_sid'),
nfpo_rating_score_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Value of the calculated rating score.            LDL: p_lew_core.t_item_rating_score.item_rating_score_meas'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: LDL: p_lew_core.t_item_rating.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: LDL: p_lew_core.t_item_rating.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_rating_sid, nfpo_rating_score_type_sid) NOT ENFORCED
)
OPTIONS(description='This table contains the rating scores calculated for a certain item_1 rating using a model.             LDL: p_lew_core.t_item_rating_score_1');