CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.STUECKLISTE (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
STUECKLISTE_ID INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Stückliste'),
DAT_VON DATE NOT NULL
OPTIONS(description='Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'),
ART_ID INTEGER NOT NULL OPTIONS(description='Artikelnummer der Stückliste'),
STUECKLISTE_VERWENDUNG_ID INTEGER NOT NULL OPTIONS(description='Eindeutiger Schlüssel für die Stücklistenverwendung'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, STUECKLISTE_ID, DAT_VON) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Die Tabelle stueckliste enthält die Stücklisten aus der SAP Tabelle MAST. Aktuell werden nur die Vollgutstücklisten in das DWH übertragen');