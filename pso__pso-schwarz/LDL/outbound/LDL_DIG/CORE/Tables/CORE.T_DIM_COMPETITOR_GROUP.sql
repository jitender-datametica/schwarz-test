/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COMPETITOR_GROUP
   GENERATED FROM POWERDESIGNER ON Donnerstag, 25. Juli 2024 11:06:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_competitor_group (
competitor_group_cd STRING(20) NOT NULL
OPTIONS(description='The unqiue code that identifies different Competitor Groups.'),
competitor_group_name STRING(100) OPTIONS(description='The name of the competitor group.'),
competitor_group_class_name STRING(100)
OPTIONS(description='Classification of the Competitor Group, based on the characteristics of the competitors e.g. Generalist or Specialist'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (competitor_group_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension that contains details for the competitor groups. A competitor group is a group of competitor IDs (competitor_cd) that represent the same business e.g. Amazon.de and Amazon-marketplace.de having different competitor_cd will be grouped together under the same competitor_group_cd such as Amazon.                           The Names of the Competitor groups and which Competitors belong to them is decided by business users in Lidl and is based on the way Lild Users need to group competitors for reporting and comparison. It is not strictly based on legal entities and/or Holding Company - Subsidiary relationships ');