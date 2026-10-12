--==============================================================
-- Table: linbew_prog_hc_org_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: linbew_prog_hc_org_2
   generated from Powerdesigner on Dienstag, 18. März 2025 10:03:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LINBEW_PROG_HC_ORG_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   hr_objekt_id                        NUMBER(38,0)     NOT NULL COMMENT 'ID der Organisation, 8-stellige Zahl',
   dat                                 DATE             NOT NULL COMMENT 'Datum Vortag der Lieferung in Beladung gesetzt, im Format JJJJ-MM_2-TT',
   anz_prg_beendet                     NUMBER(38,0)     COMMENT 'Anzahl abgeschlossene Programme',
   anz_prg_faellig                     NUMBER(38,0)     COMMENT 'Anzahl fälligen Programme',
   anz_prg_gesamt                      NUMBER(38,0)     COMMENT 'Anzahl zu erledigende Programme Gesamt',
   anz_prg_bearbeitung                 NUMBER(38,0)     COMMENT 'Anzahl Progamme in Bearbeitung (auch fällige)',
   anz_prg_ausstehend                  NUMBER(38,0)     COMMENT 'Anzahl nicht begonnene Programme (auch fällige)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LINBEW_PROG_HC_ORG PRIMARY KEY (mandant_id, hr_objekt_id, dat) NOT ENFORCED
)  COMMENT = 'Einarbeitungskennzahlen programmbasiert je OrganizationID';
