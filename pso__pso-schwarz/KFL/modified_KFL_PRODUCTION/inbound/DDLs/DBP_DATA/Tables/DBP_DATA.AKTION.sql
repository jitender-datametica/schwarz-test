--==============================================================
-- Table: aktion
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION (
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   aktionsart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Kommt aus der Tabelle WAKH.akart
            Angabe, die eine Aktion nach technischen Gesichtspunkten klassifiziert.
            Die Aktionsart umfaßt folgende Werte:
            ZF: 	Food
            ZFI: 	Fisch
            ZFL: 	Fleisch
            ZNF:	Nonfood
            ZWG:	Wurst und Geflügel
            ',
   werbe_kat_id                        INTEGER     COMMENT 'Surrogate Key für die SAP Werbekategorie. Managed Änderungen in der Bezeichnung',
   dat_von                             DATE             COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM-TT
            ',
   dat_bis                             DATE             COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM-TT
            ',
   preisaktiviert_fg                   INTEGER     COMMENT 'abgeleitet WAKH-VKGST (wird auf 1 gesetzt, wenn WAKH-VKGST = A oder B, sonst 0) für KMO aus Tabelle ZACT2',
   kjwo_von                            INTEGER     NOT NULL COMMENT 'Start-Kalenderwoche der Aktion entsprechend dat_von. Redundant, zur Steigerung der Performance',
   aktion_typ_id                       VARCHAR(4)       COLLATE 'en-ci' COMMENT 'aus WAKH.CUSTOMER_ID, null bei allgemeinem Angebot, KDN bei Loyaltypromotion, KDP bei Couponaktion',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION PRIMARY KEY (aktion_id, mandant_id, bewart_id) NOT ENFORCED
)  COMMENT = 'AIS -  Kopfdaten der zentralen Aktionen';

