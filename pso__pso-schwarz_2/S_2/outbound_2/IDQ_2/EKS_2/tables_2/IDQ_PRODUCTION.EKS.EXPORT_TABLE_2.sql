CREATE OR REPLACE TABLE idq_production_eks.export_table_2 (
exporttableid INTEGER NOT NULL,
exporttypeid INTEGER,
crdate DATETIME,
exportdate DATETIME,
cruser STRING(35),
tablename_from STRING(80),
tablename_to STRING(80),
counted_rows INTEGER,
checksum BIGNUMERIC(38,0),
whereclause STRING(4000),
PRIMARY KEY (exporttableid) NOT ENFORCED
);