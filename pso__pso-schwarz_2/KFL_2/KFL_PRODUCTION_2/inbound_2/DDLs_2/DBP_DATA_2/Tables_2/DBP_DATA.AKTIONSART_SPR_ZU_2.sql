--==============================================================
-- Table: aktionsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktionsart_spr_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTIONSART_SPR_ZU_2 (
   aktionsart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Kommt aus der Tabelle WAKH_2
            Angabe, die eine_2 Aktion_2 nach technischen Gesichtspunkten klassifiziert.
            Die Aktionsart umfaßt folgende Werte:
            ZF: 	Food
            ZFI: 	Fisch
            ZFL: 	Fleisch
            ZNF:	Nonfood
            ZWG:	Wurst und Geflügel
            ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache. Ganzzahliger Wert > 0',
   aktionsart_bez                      VARCHAR(18)      COLLATE 'en-ci' COMMENT 'Kommt aus der SAP Tabelle TWAAT
            Langbezeichnung der Aktionsart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTIONSART_SPR_ZU PRIMARY KEY (aktionsart_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'Enthält die Bezeichnungen für Aktionsarten
             Diese Tabelle ist noch nicht realisiert';

