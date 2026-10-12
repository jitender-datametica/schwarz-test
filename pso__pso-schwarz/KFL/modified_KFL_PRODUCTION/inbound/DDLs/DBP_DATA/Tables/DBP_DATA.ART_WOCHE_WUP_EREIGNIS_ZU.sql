--==============================================================
-- Table: art_woche_wup_ereignis_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_woche_wup_ereignis_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WOCHE_WUP_EREIGNIS_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   ereignis_id                         INTEGER     NOT NULL COMMENT 'Ereignis ID (fortlaufende Nummer)',
   ereignistyp_id                      INTEGER     NOT NULL COMMENT 'Ereignistyp ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WOCHE_WUP_EREIGNIS_ZU PRIMARY KEY (mandant_id, art_id, kjwo, wup_id, nb_id, ereignis_id, ereignistyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Vom Markt getroffene Maßnahmen z.Bsp.bei hohen Abschriften. Wird im DWH intern per TS und Makro  befüllt';

