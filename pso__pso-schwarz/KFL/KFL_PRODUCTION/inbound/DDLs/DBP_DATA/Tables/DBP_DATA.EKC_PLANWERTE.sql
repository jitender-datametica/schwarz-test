--==============================================================
-- Table: ekc_planwerte
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ekc_planwerte
   generated from Powerdesigner on Wednesday, April 6, 2022 10:41:22 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EKC_PLANWERTE (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   hwg_id                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Hauptwarengruppe',
   arthiertyp_id                       NUMBER(38,0)    NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen handelt',
   dat                                 DATE            NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' DEFAULT 'EUR' NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   abschriftsbetrag_werbung_netto      NUMBER(18,3)    COMMENT 'Planwert für Werbeabschriften netto',
   umsatz_netto_sa                     NUMBER(18,3)    COMMENT 'Planwert für Umsatz SA netto',
   umsatz_netto_af                     NUMBER(18,3)    COMMENT 'Planwert für Umsatz AF netto',
   abschriftsbetrag_ohne_werbung_netto NUMBER(18,3)    COMMENT 'Planwert Abschriften ohne Werbung netto',
   wa_kalk_netto                       NUMBER(18,3)    COMMENT 'Planwert WA Kalk netto',
   wa_kalk_netto_af                    NUMBER(18,3)    DEFAULT 0 COMMENT 'Planwert WA Kalk netto AF',
   wa_kalk_netto_sa                    NUMBER(18,3)    DEFAULT 0 COMMENT 'Planwert WA Kalk netto SA',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EKC_PLANWERTE PRIMARY KEY (mandant_id, hwg_id, arthiertyp_id, dat) NOT ENFORCED
)  COMMENT = 'EK INT - COI bereitgestellte Planwerte für das EK Cockpit';
