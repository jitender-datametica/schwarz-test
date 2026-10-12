CREATE TABLE DBP_DATA.TRANSPORTAUFTRAG CLUSTER BY (mandant_id, dat_quittierung)(
	MANDANT_ID INTEGER NOT NULL,
	TRANSPORT_BELEG_ID INTEGER NOT NULL,
	LAGERNUMMER_ID VARCHAR(3) NOT NULL COLLATE 'en-ci',
	WUP_ID INTEGER NOT NULL,
	NB_ID INTEGER NOT NULL,
	DAT_ERSTELLUNG DATE,
	ZEIT_ERSTELLUNG INTEGER,
	DAT_QUITTIERUNG DATE,
	TRANSPORTART_ID VARCHAR(1) COLLATE 'en-ci',
	SYSTEM_ID INTEGER NOT NULL DEFAULT 14,
	LVS_BEWART_ID INTEGER,
	LIEF_BELEG_ID INTEGER NOT NULL DEFAULT 0,
	TA_PRIO INTEGER NOT NULL DEFAULT 0,
	DAT_PRIO_UPD DATE,
	ZEIT_PRIO_UPD INTEGER,
	KJ_LIEF_BELEG INTEGER,
    ANZ_POS_TA                          VARCHAR(4)      COMMENT 'Aktuelle Anzahl Positionen im TA',
    DATZEIT_START_TA                    TIMESTAMP_LTZ   COMMENT 'Zeitstempel Beginn TA',
    DATZEIT_END_TA                      TIMESTAMP_LTZ   COMMENT 'Zeitstempel Ende TA',
    REFERENZNUMMER                      INTEGER    COMMENT 'Referenznummer',
    DAT_BEREITSTELLUNG                  DATE            COMMENT 'Bereitstelldatum',
    DATZEIT_BEREITSTELLUNG              TIMESTAMP_LTZ   COMMENT 'Bereitstellzeit',
    WG_VERKETT_ID                       INTEGER    COMMENT 'Warengruppenverkettungskennzeichen',
    WERBEWARE_ID                        VARCHAR(1)  COLLATE 'en-ci'    COMMENT 'Werbung/Normalware',
    LIEF_PAL_TYP_ID                     VARCHAR(1)  COLLATE 'en-ci'    COMMENT 'Palettentyp der Lieferung',
    DAT_LIEF_SOLL                       DATE            COMMENT 'Lieferdatum',
    TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
    TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'TP408_LVS - In dieser Tabelle sind die Transportaufträge aus der SAP Quelle LTAK enthalten. - MULTISET';

    











