CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_user_role_2 (
nfpo_user_role_cd STRING(100) NOT NULL OPTIONS(description='PK Role Type;'),
nfpo_user_role_name STRING(100) NOT NULL OPTIONS(description='Mutable name;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_user_role_cd) NOT ENFORCED
)
OPTIONS(description='NFPO user role type;             Static reference data:             1: EKL: Purchasing Manager             2: SE: Category Manager (Hardware only)             3: KVW: Contract Manager             4: KP: Contract Approver');