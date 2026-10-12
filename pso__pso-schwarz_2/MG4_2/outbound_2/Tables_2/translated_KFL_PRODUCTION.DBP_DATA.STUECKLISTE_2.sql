CREATE OR REPLACE TABLE kfl_production_dbp_data.stueckliste_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
stueckliste_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Stückliste'),
dat_von DATE NOT NULL
OPTIONS(description='Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'),
dat_bis DATE NOT NULL
OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'),
art_id INTEGER NOT NULL OPTIONS(description='Artikelnummer der Stückliste'),
stueckliste_verwendung_id INTEGER NOT NULL OPTIONS(description='Eindeutiger Schlüssel für die Stücklistenverwendung'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, stueckliste_id, dat_von) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Die Tabelle stueckliste_2 enthält die Stücklisten aus der SAP Tabelle MAST. Aktuell werden nur die Vollgutstücklisten in das DWH übertragen');