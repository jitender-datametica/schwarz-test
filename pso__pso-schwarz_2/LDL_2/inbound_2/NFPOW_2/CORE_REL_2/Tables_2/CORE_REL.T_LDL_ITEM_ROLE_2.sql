CREATE TABLE CORE_REL.T_LDL_ITEM_ROLE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_item_role_cd                    VARCHAR(100)     NOT NULL,
   ldl_item_role_name                  VARCHAR(100)     NOT NULL,
   ldl_sys_name                        VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_ITEM_ROLE PRIMARY KEY (ldl_item_role_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Item_2 role in client;
             SAP : ZBA_0 : Bestellartikel - Konfigurationsmaterial
             SAP : ZBA_1 : Bestellartikel - Verkaufsvariante
             SAP : ZBA_2 : Bestellartikel - Logistische Variante
             SAP : ZSK : Sortierkarton - Stucklistenkopf
             SAP : ZEA : Einzelartikel
             WAWI : WAWI_SK : Sortierkarton';