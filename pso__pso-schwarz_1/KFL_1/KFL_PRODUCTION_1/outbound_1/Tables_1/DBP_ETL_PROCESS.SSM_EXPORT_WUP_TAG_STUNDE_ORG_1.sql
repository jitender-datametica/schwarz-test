CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ssm_export_wup_tag_stunde_org_1 (
axisid BIGNUMERIC(38,0),
timetype STRING(6),
xrefcode BIGNUMERIC(38,0),
dayid DATE,
kpixrefcode STRING(50) COLLATE 'und:ci',
ticxrefcode STRING(50) COLLATE 'und:ci',
minuteid DATETIME,
value BIGNUMERIC(38,4)
);