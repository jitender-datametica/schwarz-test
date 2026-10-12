CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_zlet_parcel_trk_2 (
zzewmrefdoc STRING(20) NOT NULL,
zzewmtraid STRING(100) NOT NULL,
zzewmrefdoctype STRING(20) NOT NULL,
zzewmcntry STRING(6) NOT NULL,
zzewmcarrier STRING(70) NOT NULL,
zzewmscandatecarrier BIGNUMERIC(32) NOT NULL,
zzewmdeptdatecarrier BIGNUMERIC(32) NOT NULL,
zzewmarrivaldatedest BIGNUMERIC(32) NOT NULL,
zzewmlastupdate BIGNUMERIC(32) NOT NULL,
zzewmtraurl STRING(400) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);