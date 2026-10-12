--==============================================================
-- Table: ereignistyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignistyp_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EREIGNISTYP_1 (
   ereignistyp_id                      NUMBER(38,0)     NOT NULL COMMENT 'Ereignistyp_1 ID. Ereignistypen sind lokale Feiertage, automatisch generierte Feiertage etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EREIGNISTYP PRIMARY KEY (ereignistyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Typen von Ereignissen, die auf die Öffnung eines Warenumschlagsplatzes Einfluss haben';

