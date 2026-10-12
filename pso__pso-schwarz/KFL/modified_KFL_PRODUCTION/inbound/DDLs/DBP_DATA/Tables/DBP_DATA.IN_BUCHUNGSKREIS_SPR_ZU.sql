--==============================================================
-- Table: in_buchungskreis_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_buchungskreis_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_BUCHUNGSKREIS_SPR_ZU (
   buchungskreis_id                    INTEGER     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   buchungskreis_bez                   VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Buchungskreises aus butxt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_BUCHUNGSKREIS_SPR_ZU PRIMARY KEY (buchungskreis_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnungen der Buchungskreise aus SAP Industrie. Quelle ist t001';
