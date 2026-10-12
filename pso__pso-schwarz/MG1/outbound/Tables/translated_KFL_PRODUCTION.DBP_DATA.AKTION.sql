CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.AKTION (
AKTION_ID STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
AKTIONSART_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kommt aus der Tabelle WAKH.akart\n            Angabe, die eine Aktion nach technischen Gesichtspunkten klassifiziert.\n            Die Aktionsart umfaßt folgende Werte:\n            ZF:\tFood\n            ZFI:\tFisch\n            ZFL:\tFleisch\n            ZNF:\tNonfood\n            ZWG:\tWurst und Geflügel\n            '),
WERBE_KAT_ID INTEGER
OPTIONS(description='Surrogate Key für die SAP Werbekategorie. Managed Änderungen in der Bezeichnung'),
DAT_VON DATE OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM-TT\n            '),
DAT_BIS DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT\n            '),
PREISAKTIVIERT_FG INTEGER
OPTIONS(description='abgeleitet WAKH-VKGST (wird auf 1 gesetzt, wenn WAKH-VKGST = A oder B, sonst 0) für KMO aus Tabelle ZACT2'),
KJWO_VON INTEGER NOT NULL
OPTIONS(description='Start-Kalenderwoche der Aktion entsprechend dat_von. Redundant, zur Steigerung der Performance'),
AKTION_TYP_ID STRING(4) COLLATE 'und:ci'
OPTIONS(description='aus WAKH.CUSTOMER_ID, null bei allgemeinem Angebot, KDN bei Loyaltypromotion, KDP bei Couponaktion'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, BEWART_ID) NOT ENFORCED
) OPTIONS(description='AIS -  Kopfdaten der zentralen Aktionen');