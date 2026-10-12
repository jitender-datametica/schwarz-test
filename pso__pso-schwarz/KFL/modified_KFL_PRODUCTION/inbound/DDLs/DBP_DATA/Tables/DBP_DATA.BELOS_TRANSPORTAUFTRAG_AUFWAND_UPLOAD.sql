--==============================================================
-- Table: belos_transportauftrag_aufwand_upload
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_transportauftrag_aufwand_upload
   generated from Powerdesigner on Friday, May 6, 2022 4:01:33 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_TRANSPORTAUFTRAG_AUFWAND_UPLOAD (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   belos_vorgang_id                    INTEGER    NOT NULL COMMENT 'Im DWH generierte eindeutige ID für die Belos Vorgaenge. Ein Belos Vorgang setzt sich zusammen aus einem Transportauftrag (Logistikdaten) und einer Sendung (Abrechnungsdaten).',
   transportauftrag_id                 VARCHAR(30)     COLLATE 'en-ci' NOT NULL COMMENT 'Fachschluessel des referenzierten BELOS Transportauftrags der diesem Vorgang zugeodnet ist (nur eindeutige, keine Zusatztouren).',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   aufwand_vorlauf                     NUMBER(29,3)   COMMENT 'Kosten fuer den Vorlauf vom Verteilzentrum, Warenanlieferung vom Spediteur fuer den spaeteren Hauptlauf.',
   aufwand_hauptlauf                   NUMBER(29,3)   COMMENT 'Kosten fuer den Hauptlauf. Der Haupttransportweg fuer die Ware.',
   aufwand_umschlag                    NUMBER(29,3)   COMMENT 'Kosten fuer Nebenfahrten, z.B. wenn der Transporter Paletten fuer andere Auftraege mit transportiert und waehrend der Fahrt fuer diese einen Umweg vom Hauptlauf macht.',
   aufwand_diesel                      NUMBER(29,3)   COMMENT 'Kosten fuer Diesel zu dem Transportauftrag.',
   aufwand_gesamt                      NUMBER(29,3)   COMMENT 'Gesamtkosten fuer den Transportauftrag.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_TRANSPORTAUFTRAG_AUFWAND_UPLOAD PRIMARY KEY (mandant_id, belos_vorgang_id) NOT ENFORCED
)  COMMENT = 'Kosten fuer BELOS Transportauftraege. Diese Tabelle wird ueber einen SharePoint-Upload versorgt. Die Daten kommen aus manuell befuellten Excel-Dateien die auf dem SharePoint liegen.';
