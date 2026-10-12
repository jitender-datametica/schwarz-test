CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_NIELSEN_WUG_ZU_PFLEGE_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ART_NIELSEN_ID INTEGER NOT NULL OPTIONS(description='Artikel_1-ID aus Nielsen'),
ART_NIELSEN_BEZ STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Artikelbezeichnung aus Nielsen '),
FB_PFLEGE_WG_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='ID der Warengruppe wie sie vom Fachbereich vorgeschlagen wurde.'),
FB_PFLEGE_WUG_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='ID der Warenuntergruppe (WGI) wie sie vom Fachbereich vorgeschlagen wurde.'),
NIELSEN_ABTEILUNG_BEZ STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Abteilung'),
NIELSEN_WG_BEZ STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Warengruppen'),
NIELSEN_UWG1_BEZ STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 1'),
NIELSEN_UWG2_BEZ STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 2'),
KALK_VORSCHL_WG_ID INTEGER
OPTIONS(description='Im Beladeprozess ermmittelte Warengruppe-ID (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_1 mit der gleichen Nielsen-UWG2)'),
KALK_VORSCHL_WUG_ID INTEGER
OPTIONS(description='Im Beladeprozess ermmittelte Warenuntergruppe-ID (WGI) (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_1 mit der gleichen Nielsen-UWG2).'),
DATZEIT_LETZTE_EINTRAGUNG_FB_PFLEGE TIMESTAMP
OPTIONS(description='Zeitpunkt der letzten Eintragung für Pflege durch Fachbereich.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_NIELSEN_ID) NOT ENFORCED
) OPTIONS(description='EK-SORT - TS Zuordnung Artikel_1 zu Artikelhierarchie');