CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.STUECKLISTE_DET (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
STUECKLISTE_ID INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Stückliste'),
STUECKLISTE_POS_ID INTEGER NOT NULL OPTIONS(description='Nummer der Position der Stücklistenkomponente'),
DAT_VON DATE NOT NULL
OPTIONS(description='Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'),
ART_ID INTEGER NOT NULL OPTIONS(description='Artikelnummer der Stücklistenkomponente'),
STUECKLISTE_TYP_ID STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die Stücklistentypen.'),
KOMPONENTENMENGE NUMERIC(18,4) NOT NULL OPTIONS(description='Menge der Stücklistenkomponente'),
KOMPONENTENMENGE_EINH_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant und Artikel eine alternative Mengeneinheit eindeutig identifiziert.Aus meinh'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, STUECKLISTE_ID, STUECKLISTE_POS_ID, DAT_VON) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Die Tabelle stueckliste_det enthält die Stücklistenpositionen aus der SAP Tabelle STPO. Eine Stückliste besteht aus einer oder mehreren Komponenten.');