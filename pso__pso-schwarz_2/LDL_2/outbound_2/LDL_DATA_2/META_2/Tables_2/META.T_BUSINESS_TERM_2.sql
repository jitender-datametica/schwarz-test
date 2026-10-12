/* --------------------------------------------------------------------------------
   DDL for table: t_business_term_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_business_term_2 (
bus_term_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the business term.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
bus_term_name STRING(100) NOT NULL OPTIONS(description='The name by which the term is known to business.'),
bus_term_descr STRING(250) NOT NULL OPTIONS(description='The definition of the business term.'),
bus_term_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the subtype discriminator for business terms. It distinguishes between domain terms, object terms, attribute terms, value terms and KPI terms.'),
obj_term_type_cd STRING(20) OPTIONS(description='The code identifying the subtype discriminator for object terms.'),
attr_term_type_cd STRING(20) OPTIONS(description='The code identifying the subtype discriminator for attribute terms.'),
parent_term_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the upper level term in the hierarchy_2 of business terms.'),
domain_term_name STRING(100)
OPTIONS(description='If this term is a domain term, this column contains the name of the domain term. Otherwise, it is empty.'),
obj_term_name STRING(100)
OPTIONS(description='If this term is an object term, this column contains the name of the object term. If this term is an attribute term or a value term, this column contains the name of the related object term. Otherwise, it is empty.'),
attr_term_name STRING(100)
OPTIONS(description='If this term is an attribute term, this column contains the name of the attribute term. If this term is a value term, this column contains the name of the related attribute term. Otherwise, it is empty.'),
val_term_name STRING(100)
OPTIONS(description='If this term is a value term, this column contains the name of the value term. Otherwise, it is empty.'),
data_prot_lvl_cd STRING(20)
OPTIONS(description='The code identifying the way, how the data objects which represent this business term, need to be protected from unauthorized access. E.g. it labels personally identifiable information (PII) and data that needs to be protected for competitive reasons.'),
approval_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the approval status_2 for a business term.'),
data_steward_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the data steward, who is responsible for this business term.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_term_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A business term is a word or phrase that describes a concept that is used in one or several areas of the enterprise. E.g. customer, product, buying price, …  The conceptual data model (CDM) is a graphical representation of business terms. Business terms do not (necessarily) reflect the terminology that is used in operational systems, nor are they tailored towards any reporting requirements. Business terms may form a hierarchy_2 of the following form: Domain Term -> (multiple levels of) Object Terms -> Attribute Term -> Value Term');