--==============================================================
-- Table: aktion
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion (
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
aktionsart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kommt aus der Tabelle WAKH.akart            Angabe, die eine Aktion nach technischen Gesichtspunkten klassifiziert.            Die Aktionsart umfaßt folgende Werte:            ZF: 	Food            ZFI: 	Fisch            ZFL: 	Fleisch            ZNF:	Nonfood            ZWG:	Wurst und Geflügel            '),
werbe_kat_id BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key für die SAP Werbekategorie. Managed Änderungen in der Bezeichnung'),
dat_von DATE OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM-TT            '),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT            '),
preisaktiviert_fg BIGNUMERIC(38,0)
OPTIONS(description='abgeleitet WAKH-VKGST (wird auf 1 gesetzt, wenn WAKH-VKGST = A oder B, sonst 0) für KMO aus Tabelle ZACT2'),
kjwo_von BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Start-Kalenderwoche der Aktion entsprechend dat_von. Redundant, zur Steigerung der Performance'),
aktion_typ_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='aus WAKH.CUSTOMER_ID, null bei allgemeinem Angebot, KDN bei Loyaltypromotion, KDP bei Couponaktion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bewart_id) NOT ENFORCED
) OPTIONS(description='AIS -  Kopfdaten der zentralen Aktionen');