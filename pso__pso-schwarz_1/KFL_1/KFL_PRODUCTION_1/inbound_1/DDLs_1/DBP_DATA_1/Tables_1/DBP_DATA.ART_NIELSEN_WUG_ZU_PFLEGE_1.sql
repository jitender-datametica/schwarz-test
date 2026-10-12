--==============================================================
-- Table: art_nielsen_wug_zu_pflege_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_wug_zu_pflege_1
   generated from Powerdesigner on Freitag, 28. April 2023 16:49:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_WUG_ZU_PFLEGE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_nielsen_id                      NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1-ID aus Nielsen',
   art_nielsen_bez                     VARCHAR(1024)    NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Artikelbezeichnung aus Nielsen ',
   fb_pflege_wg_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'ID der Warengruppe wie sie vom Fachbereich vorgeschlagen wurde.',
   fb_pflege_wug_id                    NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'ID der Warenuntergruppe (WGI) wie sie vom Fachbereich vorgeschlagen wurde.',
   nielsen_abteilung_bez               VARCHAR(1024)    NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Abteilung',
   nielsen_wg_bez                      VARCHAR(1024)    NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Warengruppen',
   nielsen_uwg1_bez                    VARCHAR(1024)    NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Unterwarengruppe 1',
   nielsen_uwg2_bez                    VARCHAR(1024)    NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Unterwarengruppe 2',
   kalk_vorschl_wg_id                  NUMBER(38,0)     COMMENT 'Im Beladeprozess ermmittelte Warengruppe-ID (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_1 mit der gleichen Nielsen-UWG2)',
   kalk_vorschl_wug_id                 NUMBER(38,0)     COMMENT 'Im Beladeprozess ermmittelte Warenuntergruppe-ID (WGI) (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_1 mit der gleichen Nielsen-UWG2).',
   datzeit_letzte_eintragung_fb_pflege TIMESTAMP_LTZ(9) COMMENT 'Zeitpunkt der letzten Eintragung für Pflege durch Fachbereich.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_WUG_ZU_PFLEGE PRIMARY KEY (mandant_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-SORT - TS Zuordnung Artikel_1 zu Artikelhierarchie'
;
