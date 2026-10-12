CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_nfpo_organisation_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key internal organisation
            CBX: CNT_CODELIST.NAME (code list \'LIDL_COUNTRY\')'''),
display_seq BIGNUMERIC(38,0)
OPTIONS(description='''defines the order of NFPO\'s in reports
            CBX: CNT_CODELIST.seq_no (code list \'LIDL_COUNTRY\')'''),
active_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicates whether an NFPO is no longer usable in the system
            CBX: CNT_CODELIST.disabled (code list \'LIDL_COUNTRY\')
            '''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (int_org_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='''Thist table contains historised information about non food puchase organization units.
             CBX:CNT_CODELIST (code list \'LIDL_COUNTRY\')
             ''');