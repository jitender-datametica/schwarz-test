CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_organization (
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key internal organisation'),
nfpo_org_type_cd STRING(100) NOT NULL OPTIONS(description='type code of the internal organisation'),
nfpo_org_nr STRING(100) NOT NULL OPTIONS(description='identifier of the internal organisation in the source system'),
nfpo_org_name STRING(100) OPTIONS(description='name of the internal organisation'),
nfpo_org_descr STRING(250) OPTIONS(description='description of the onternal organisation'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_sid) NOT ENFORCED
)
OPTIONS(description='Ths table contains the list of internal organizations of various types. This table is not replacing the already modeled tables containing ERP-related organisational units like client, store or warehouse. It contains organisation types on a level comparable to country or client, but having different business backgrounds and therefore different details.');