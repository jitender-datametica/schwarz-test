--==============================================================
-- Table: aktion_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_2 (
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
aktionsart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kommt aus der Tabelle WAKH.akart            Angabe, die eine_2 Aktion_2 nach technischen Gesichtspunkten klassifiziert.            Die Aktionsart umfaßt folgende Werte:            ZF: 	Food            ZFI: 	Fisch            ZFL: 	Fleisch            ZNF:	Nonfood            ZWG:	Wurst und Geflügel            '),
werbe_kat_id BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key für die SAP Werbekategorie. Managed Änderungen in der Bezeichnung'),
dat_von DATE OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM_2-TT            '),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT            '),
preisaktiviert_fg BIGNUMERIC(38,0)
OPTIONS(description='abgeleitet WAKH_2-VKGST (wird auf 1 gesetzt, wenn WAKH_2-VKGST = A oder B, sonst 0) für KMO aus Tabelle ZACT2_2'),
kjwo_von BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Start-Kalenderwoche der Aktion_2 entsprechend dat_von. Redundant, zur Steigerung der Performance'),
aktion_typ_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='aus WAKH.CUSTOMER_ID, null bei allgemeinem Angebot_2, KDN bei Loyaltypromotion, KDP bei Couponaktion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bewart_id) NOT ENFORCED
) OPTIONS(description='AIS -  Kopfdaten der zentralen Aktionen');