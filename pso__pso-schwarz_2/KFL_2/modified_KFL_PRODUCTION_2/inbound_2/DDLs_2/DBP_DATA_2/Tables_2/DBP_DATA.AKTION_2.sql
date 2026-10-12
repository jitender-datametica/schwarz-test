--==============================================================
-- Table: aktion_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_2 (
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   aktionsart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Kommt aus der Tabelle WAKH.akart
            Angabe, die eine_2 Aktion_2 nach technischen Gesichtspunkten klassifiziert.
            Die Aktionsart umfaßt folgende Werte:
            ZF: 	Food
            ZFI: 	Fisch
            ZFL: 	Fleisch
            ZNF:	Nonfood
            ZWG:	Wurst und Geflügel
            ',
   werbe_kat_id                        INTEGER     COMMENT 'Surrogate Key für die SAP Werbekategorie. Managed Änderungen in der Bezeichnung',
   dat_von                             DATE             COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM_2-TT
            ',
   dat_bis                             DATE             COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT
            ',
   preisaktiviert_fg                   INTEGER     COMMENT 'abgeleitet WAKH_2-VKGST (wird auf 1 gesetzt, wenn WAKH_2-VKGST = A oder B, sonst 0) für KMO aus Tabelle ZACT2_2',
   kjwo_von                            INTEGER     NOT NULL COMMENT 'Start-Kalenderwoche der Aktion_2 entsprechend dat_von. Redundant, zur Steigerung der Performance',
   aktion_typ_id                       VARCHAR(4)       COLLATE 'en-ci' COMMENT 'aus WAKH.CUSTOMER_ID, null bei allgemeinem Angebot_2, KDN bei Loyaltypromotion, KDP bei Couponaktion',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION PRIMARY KEY (aktion_id, mandant_id, bewart_id) NOT ENFORCED
)  COMMENT = 'AIS -  Kopfdaten der zentralen Aktionen';

