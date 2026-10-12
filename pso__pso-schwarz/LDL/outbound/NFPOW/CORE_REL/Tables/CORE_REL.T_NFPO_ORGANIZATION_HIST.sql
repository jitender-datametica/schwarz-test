CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_organization_hist (
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key internal organisation
            CBX: CNT_CODELIST.NAME (code list \'LIDL_COUNTRY\')'''),
display_seq BIGNUMERIC(38,0)
OPTIONS(description='''defines the order of NFPO\'s in reports
            CBX: CNT_CODELIST.seq_no (code list \'LIDL_COUNTRY\')'''),
active_fg BOOL
OPTIONS(description='''indicates whether an NFPO is no longer usable in the system
            CBX: CNT_CODELIST.disabled (code list \'LIDL_COUNTRY\')
            '''),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status angenommen.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='''Thist table contains historised information about non food puchase organization units.
             CBX:CNT_CODELIST (code list \'LIDL_COUNTRY\')
             ''');