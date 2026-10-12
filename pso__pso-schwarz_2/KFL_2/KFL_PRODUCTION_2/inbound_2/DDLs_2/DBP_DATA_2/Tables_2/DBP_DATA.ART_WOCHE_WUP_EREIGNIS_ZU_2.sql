--==============================================================
-- Table: art_woche_wup_ereignis_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_woche_wup_ereignis_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WOCHE_WUP_EREIGNIS_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   kjwo                                NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   ereignis_id                         NUMBER(38,0)     NOT NULL COMMENT 'Ereignis_2 ID (fortlaufende Nummer)',
   ereignistyp_id                      NUMBER(38,0)     NOT NULL COMMENT 'Ereignistyp_2 ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WOCHE_WUP_EREIGNIS_ZU PRIMARY KEY (mandant_id, art_id, kjwo, wup_id, nb_id, ereignis_id, ereignistyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Vom Markt getroffene Maßnahmen z.Bsp.bei hohen Abschriften. Wird im DWH intern per TS und Makro  befüllt';

