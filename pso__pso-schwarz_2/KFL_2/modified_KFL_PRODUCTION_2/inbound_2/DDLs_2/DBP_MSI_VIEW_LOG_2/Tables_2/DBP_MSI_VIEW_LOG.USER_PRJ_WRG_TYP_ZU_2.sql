CREATE TABLE DBP_MSI_VIEW_LOG.USER_PRJ_WRG_TYP_ZU_2 (
USER_ID VARCHAR(120) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
WRG_TYP_ID INTEGER NOT NULL COMMENT 'Es gibt zwei Typen der Währung - Land_2 = 1 und Euro = 0',
TD_UPDATE TIMESTAMP_LTZ(9),
TD_INSERT TIMESTAMP_LTZ(9),
UNIQUE (USER_ID)
)COMMENT='Zuordnung des FrontEnd-Users zu einem Währungstyp fuer das LOG MSTR-Projekt - über FrontEnd einstellbar'
;