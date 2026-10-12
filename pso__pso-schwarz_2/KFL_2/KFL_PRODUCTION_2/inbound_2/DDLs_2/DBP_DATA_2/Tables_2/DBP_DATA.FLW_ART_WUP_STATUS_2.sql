--==============================================================
-- Table: flw_art_wup_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_wup_status_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_WUP_STATUS_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dme_einh_id                         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Doppelte Mengeneinheit aus spmeat/dmein',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   beschaffungsart_id                  VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Beschaffungsart aus BESKZ',
   zerlege_gruppe_id                   NUMBER(38,0)     COMMENT 'Zerlegegruppe aus zgrup.',
   mat_gruppe_id                       NUMBER(38,0)     NOT NULL COMMENT 'Die Materialgruppe kann Fleisch, Wurst, Hawa oder Produktion sein. Wird aus Produkthierarchiestufe, Ausprägung der Stufe und der Beschaffungsart gebildet',
   loesch_id                           VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'MMSTA - Löschkennzeichen: Betriebsspezifischer Artikelstatus. Die möglichen Stati sind in artkz_loesch_2 hinterlegt. aus lvorm',
   dat_von_loesch_id                   DATE             COMMENT 'MMSTD - Datum, ab dem der btrbsspezifische Artikelstatus (DWH: loesch_id) gültig ist',
   indentifikation_fg                  NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Identifikation: Steuerung zur Prüfung der EXTNR',
   herkunftsnachweis_fg                NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Herkunftsnachweis (1=vorhanden)',
   hackfleischpruef_fg                 NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag Hackfleischprüfung (1=erfolgt)',
   herkunft_id                         NUMBER(38,0)     DEFAULT 0 COMMENT 'ID der Herkunft',
   tiergattung_id                      NUMBER(38,0)     COMMENT 'Eindeutige ID der Tiergattung, z.Bsp 1 = Schwein aus tgtky',
   tierkategorie_id                    NUMBER(38,0)     DEFAULT 0 COMMENT 'ID der Tierkategorie (Bsp. 1=Jungbulle;2=Rind)',
   toleranz_ueber_prozent              NUMBER(9,2)      COMMENT 'Toleranzprüfung WE-Menge Über Fert.auftragsmenge in Prozent aus SAP Quelle MARC./SPDGS/UETEH',
   toleranz_unter_prozent              NUMBER(9,2)      COMMENT 'Toleranzprüfung WE-Menge Unter Fert.auftragsmenge in Prozent aus SAP Quelle MARC./SPDGS/UNTEH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_WUP_STATUS PRIMARY KEY (flw_art_id, werk_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Artikel_2 - Werksbezogene Attribute aus marc_2';

