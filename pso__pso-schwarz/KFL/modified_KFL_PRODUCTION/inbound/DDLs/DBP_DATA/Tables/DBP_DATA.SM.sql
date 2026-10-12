--==============================================================
-- Table: sm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sm
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:54:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SM (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   sm_id                               INTEGER     NOT NULL COMMENT 'Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   sap_sm_id                           VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Originalinhalt aus SAP. Für KMO kann die bisherige Regel für die Vergabe der sm_id nicht angewendet werden. Daher erfolgt bei SAP-Char-Formaten eine Umsetzung auf ein numerisches Format',
   sm_bez                              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sortimentsmodul',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SM PRIMARY KEY (sm_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sortimentsmodul (=Sortimentsstufe). Inhalt DE: 1,2,3,4,5. Für KMO können auch negative Werte vorkommen';

