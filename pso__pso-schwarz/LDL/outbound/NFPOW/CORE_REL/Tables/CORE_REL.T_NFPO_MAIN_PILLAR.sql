CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_main_pillar (
nfpo_main_pillar_cd STRING(100) NOT NULL
OPTIONS(description='''code of the main pillar
            CBX: CNT_CODELIST.CODE (code list \'PRODUCT_CATEGORY\')'''),
nfpo_main_pillar_name STRING(100)
OPTIONS(description='''name  of the main pillar
            CBX: CNT_CODELIST.NAME (code list \'PRODUCT_CATEGORY\')'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_main_pillar_cd) NOT ENFORCED
)
OPTIONS(description='''Obersäule (HG/TX) as product catagory for non food items defined by the central Lidl NFPO
             CBX: CNT_CODELIST (code list \'PRODUCT_CATEGORY\')''');