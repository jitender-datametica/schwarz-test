CREATE OR REPLACE TABLE kfl_production_dbp_data.aktion (
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
bewart_id INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
aktionsart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kommt aus der Tabelle WAKH.akart\n            Angabe, die eine Aktion nach technischen Gesichtspunkten klassifiziert.\n            Die Aktionsart umfaßt folgende Werte:\n            ZF:\tFood\n            ZFI:\tFisch\n            ZFL:\tFleisch\n            ZNF:\tNonfood\n            ZWG:\tWurst und Geflügel\n            '),
werbe_kat_id INTEGER
OPTIONS(description='Surrogate Key für die SAP Werbekategorie. Managed Änderungen in der Bezeichnung'),
dat_von DATE OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM-TT\n            '),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT\n            '),
preisaktiviert_fg INTEGER
OPTIONS(description='abgeleitet WAKH-VKGST (wird auf 1 gesetzt, wenn WAKH-VKGST = A oder B, sonst 0) für KMO aus Tabelle ZACT2'),
kjwo_von INTEGER NOT NULL
OPTIONS(description='Start-Kalenderwoche der Aktion entsprechend dat_von. Redundant, zur Steigerung der Performance'),
aktion_typ_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='aus WAKH.CUSTOMER_ID, null bei allgemeinem Angebot, KDN bei Loyaltypromotion, KDP bei Couponaktion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bewart_id) NOT ENFORCED
) OPTIONS(description='AIS -  Kopfdaten der zentralen Aktionen');