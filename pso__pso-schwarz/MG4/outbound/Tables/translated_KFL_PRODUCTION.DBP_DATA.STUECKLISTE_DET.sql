CREATE OR REPLACE TABLE kfl_production_dbp_data.stueckliste_det (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
stueckliste_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Stückliste'),
stueckliste_pos_id INTEGER NOT NULL OPTIONS(description='Nummer der Position der Stücklistenkomponente'),
dat_von DATE NOT NULL
OPTIONS(description='Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'),
dat_bis DATE NOT NULL
OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'),
art_id INTEGER NOT NULL OPTIONS(description='Artikelnummer der Stücklistenkomponente'),
stueckliste_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die Stücklistentypen.'),
komponentenmenge NUMERIC(18,4) NOT NULL OPTIONS(description='Menge der Stücklistenkomponente'),
komponentenmenge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant und Artikel eine alternative Mengeneinheit eindeutig identifiziert.Aus meinh'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, stueckliste_id, stueckliste_pos_id, dat_von) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Die Tabelle stueckliste_det enthält die Stücklistenpositionen aus der SAP Tabelle STPO. Eine Stückliste besteht aus einer oder mehreren Komponenten.');