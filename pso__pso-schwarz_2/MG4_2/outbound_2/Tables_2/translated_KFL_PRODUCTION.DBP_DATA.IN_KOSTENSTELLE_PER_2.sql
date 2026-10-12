CREATE OR REPLACE TABLE kfl_production_dbp_data.in_kostenstelle_per_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle aus kostl'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
dat_von DATE NOT NULL OPTIONS(description='Beginn des Gültigkeitszeitraums aus datab'),
dat_bis DATE NOT NULL
OPTIONS(description='Ende des Gültigkeitszeitraums aus datbi, bei offenen Datensätzen ist dies 31.12.9999'),
pc_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Eindeutiger Fachschluessel fuer die Profitcenter'),
buchungskreis_id INTEGER
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
geschaeftsbereich_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Der Geschaeftsbereich ist eine_2 interne Organisationseinheit, fuer den eine_2 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber'),
kostenstellenart_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kostenstellenart aus kosar, z.Bsp A=Zentr. International, B=Zentr. National, F=Fleischwerk, I=Immo,V=Vertrieb'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_von) NOT ENFORCED
) OPTIONS(description='IMS - Kostenstellentabelle aus Industrie aus csks');