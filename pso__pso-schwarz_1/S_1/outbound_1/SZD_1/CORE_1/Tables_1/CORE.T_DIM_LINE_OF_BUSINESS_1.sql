CREATE TABLE IF NOT EXISTS szd_core.t_dim_line_of_business_1 (
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kauflandlob=line os business'),
lob_name STRING(100) NOT NULL
OPTIONS(description='The name for the line of business within the Schwarz Group, i.e.Lidl or Kauflandlob=line os business'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (lob_cd) NOT ENFORCED
) OPTIONS(description='Lines of business within the Schwarz Group, i.e. Lidl and Kaufland');