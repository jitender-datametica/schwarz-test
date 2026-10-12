CREATE TABLE dbp_msi_view_scm.USER_PRJ_WRG_TYP_ZU_1 (
USER_ID VARCHAR(120) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
WRG_TYP_ID INTEGER NOT NULL COMMENT 'Es gibt zwei Typen der Währung - Land_1 = 1 und Euro = 0',
TD_UPDATE TIMESTAMP_LTZ(9),
TD_INSERT TIMESTAMP_LTZ(9),
UNIQUE (USER_ID)
)COMMENT='Zuordnung des FrontEnd-Users zu einem Währungstyp fuer das SCM MSTR-Projekt - über FrontEnd einstellbar'
;