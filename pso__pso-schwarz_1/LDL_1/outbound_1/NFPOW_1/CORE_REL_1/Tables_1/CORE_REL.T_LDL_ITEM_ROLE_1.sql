CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_item_role_1 (
ldl_item_role_cd STRING(100) NOT NULL,
ldl_item_role_name STRING(100) NOT NULL,
ldl_sys_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_item_role_cd) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $ Item_1 role in client;             SAP : ZBA_0 : Bestellartikel - Konfigurationsmaterial             SAP : ZBA_1 : Bestellartikel - Verkaufsvariante             SAP : ZBA_2 : Bestellartikel - Logistische Variante             SAP : ZSK : Sortierkarton - Stucklistenkopf             SAP : ZEA : Einzelartikel             WAWI : WAWI_SK : Sortierkarton');