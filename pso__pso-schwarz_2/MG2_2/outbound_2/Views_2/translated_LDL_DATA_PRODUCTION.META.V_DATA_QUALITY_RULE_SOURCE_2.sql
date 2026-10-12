CREATE OR REPLACE VIEW ldl_data_production_meta.v_data_quality_rule_source_2 (dq_rule_src_cd
OPTIONS(description='The code identifying the origin of the data quality rule. A rule may be defined by business or by the data modelling team or because of a formal guideline, such as checking all foreign keys for referential integrity violations. (Note that the origin of a data quality rule is independent from the way how it is implemented, i.e. as a generated rule, a parametrized rule or as a business rule.)'),
dq_rule_src_descr OPTIONS(description='A textual description for the origin of the data quality rule.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE ORIGIN OF THE DATA QUALITY RULE. A RULE MAY BE DEFINED BY BUSINESS OR BY THE DATA MODELLING TEAM OR BECAUSE OF A FORMAL GUIDELINE, SUCH AS CHECKING ALL FOREIGN KEYS FOR REFERENTIAL INTEGRITY VIOLATIONS. (NOTE THAT THE ORIGIN OF A DATA QUALITY RULE IS INDEPENDENT FROM THE WAY HOW IT IS IMPLEMENTED, I.E. AS A GENERATED RULE, A PARAMETRIZED RULE OR AS A BUSINESS RULE.)`)
AS SELECT dq_rule_src_cd,
 dq_rule_src_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_data_quality_rule_source_2
UNION DISTINCT
SELECT '@',
 'Unknown source',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';