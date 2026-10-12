--==============================================================
-- Table: art_nielsen_wug_zu_pflege_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_wug_zu_pflege_2
   generated from Powerdesigner on Freitag, 28. April 2023 16:49:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_nielsen_wug_zu_pflege_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2-ID aus Nielsen'),
art_nielsen_bez STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Artikelbezeichnung aus Nielsen '),
fb_pflege_wg_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='ID der Warengruppe wie sie vom Fachbereich vorgeschlagen wurde.'),
fb_pflege_wug_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='ID der Warenuntergruppe (WGI) wie sie vom Fachbereich vorgeschlagen wurde.'),
nielsen_abteilung_bez STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Abteilung'),
nielsen_wg_bez STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Warengruppen'),
nielsen_uwg1_bez STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 1'),
nielsen_uwg2_bez STRING(1024) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Nielsen Bezeichnung der Unterwarengruppe 2'),
kalk_vorschl_wg_id BIGNUMERIC(38,0)
OPTIONS(description='Im Beladeprozess ermmittelte Warengruppe-ID (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_2 mit der gleichen Nielsen-UWG2)'),
kalk_vorschl_wug_id BIGNUMERIC(38,0)
OPTIONS(description='Im Beladeprozess ermmittelte Warenuntergruppe-ID (WGI) (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_2 mit der gleichen Nielsen-UWG2).'),
datzeit_letzte_eintragung_fb_pflege TIMESTAMP
OPTIONS(description='Zeitpunkt der letzten Eintragung für Pflege durch Fachbereich.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_nielsen_id) NOT ENFORCED
) OPTIONS(description='EK-SORT - TS Zuordnung Artikel_2 zu Artikelhierarchie');