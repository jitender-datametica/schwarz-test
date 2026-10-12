CREATE TABLE DBP_DATA.TRANSPORTAUFTRAG_2 CLUSTER BY (mandant_id, dat_quittierung)(
	MANDANT_ID NUMBER(38,0) NOT NULL,
	TRANSPORT_BELEG_ID NUMBER(18,0) NOT NULL,
	LAGERNUMMER_ID VARCHAR(3) NOT NULL COLLATE 'en-ci',
	WUP_ID NUMBER(38,0) NOT NULL,
	NB_ID NUMBER(38,0) NOT NULL,
	DAT_ERSTELLUNG DATE,
	ZEIT_ERSTELLUNG NUMBER(38,0),
	DAT_QUITTIERUNG DATE,
	TRANSPORTART_ID VARCHAR(1) COLLATE 'en-ci',
	SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT 14,
	LVS_BEWART_ID NUMBER(38,0),
	LIEF_BELEG_ID NUMBER(18,0) NOT NULL DEFAULT 0,
	TA_PRIO NUMBER(38,0) NOT NULL DEFAULT 0,
	DAT_PRIO_UPD DATE,
	ZEIT_PRIO_UPD NUMBER(38,0),
	KJ_LIEF_BELEG NUMBER(38,0),
    ANZ_POS_TA                          VARCHAR(4)      COMMENT 'Aktuelle Anzahl Positionen im TA',
    DATZEIT_START_TA                    TIMESTAMP_LTZ   COMMENT 'Zeitstempel Beginn TA',
    DATZEIT_END_TA                      TIMESTAMP_LTZ   COMMENT 'Zeitstempel Ende TA',
    REFERENZNUMMER                      NUMBER(18,0)    COMMENT 'Referenznummer',
    DAT_BEREITSTELLUNG                  DATE            COMMENT 'Bereitstelldatum',
    DATZEIT_BEREITSTELLUNG              TIMESTAMP_LTZ   COMMENT 'Bereitstellzeit',
    WG_VERKETT_ID                       NUMBER(38,0)    COMMENT 'Warengruppenverkettungskennzeichen',
    WERBEWARE_ID                        VARCHAR(1)  COLLATE 'en-ci'    COMMENT 'Werbung/Normalware',
    LIEF_PAL_TYP_ID                     VARCHAR(1)  COLLATE 'en-ci'    COMMENT 'Palettentyp der Lieferung',
    DAT_LIEF_SOLL                       DATE            COMMENT 'Lieferdatum',
    TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
    TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'TP408_LVS - In dieser Tabelle sind die Transportaufträge aus der SAP Quelle LTAK enthalten. - MULTISET';

    











