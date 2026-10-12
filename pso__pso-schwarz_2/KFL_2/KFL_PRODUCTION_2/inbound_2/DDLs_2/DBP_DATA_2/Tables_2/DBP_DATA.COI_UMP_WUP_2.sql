--==============================================================
-- Table: coi_ump_wup_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_wup_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_WUP_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   gj_plan                             NUMBER(38,0)     NOT NULL COMMENT 'Plan-Geschäftsjahr, Format JJJJ
            ',
   version_id                          NUMBER(38,0)     NOT NULL COMMENT 'Die Planversion eines Geschäftsjahres (1-9)
            ',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer
            ',
   planfiliale_fg                      NUMBER(38,0)     NOT NULL COMMENT 'Flag für neue Filialen, welche noch keine Filialnummer erhalten haben
            ',
   land_level                          VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Landes-Kategorisierung (1-3 Stellen) z.B HRK für Kroatien Küste und HRL für Kroatien Land_2
            ',
   wup_standort                        VARCHAR(40)      COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Filial-Ort/Bezeichnung (u.a. notwendig für neue Filialen (Plan) ohne konkrete FilialNr
            (wird in der Planung vergeben))',
   dat_eroeffnung                      DATE             COMMENT 'Eröffnungs-Datum,  für Planung überschreibbar und daher separat gespeichert
            ',
   dat_schliessung                     DATE             COMMENT 'Schließungs-Datum, für Planung überschreibbar und daher separat gespeichert
            ',
   vs_id                               NUMBER(38,0)     COMMENT 'ID der Vertriebsschiene. Wird vorgefüllt aus Tabelle vs. Wird beim Einlesen des Excel über Filiale gezogen und bei Neufilialen über Excel-Eingabe
            ',
   wup_id_referenz                     NUMBER(38,0)     COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   faktor_wup_referenz                 NUMBER(9,6)      NOT NULL DEFAULT 0 COMMENT 'Faktor für Referenzfiliale
            ',
   faktor_basis                        NUMBER(9,6)      NOT NULL DEFAULT 0 COMMENT 'Faktor für die den Basiswert (Filiale/Referenzfilial-Wert)
            ',
   dat_fleisch_theke                   DATE             COMMENT 'Eröffnungsdatum der Theke. Kann auch leer sein.
            ',
   dat_wurst_theke                     DATE             COMMENT 'Eröffnungsdatum der Theke. Kann auch leer sein.
            ',
   dat_kaese_theke                     DATE             COMMENT 'Eröffnungsdatum der Theke. Kann auch leer sein.
            ',
   dat_gefluegel_theke                 DATE             COMMENT 'Eröffnungsdatum der Theke. Kann auch leer sein.
            ',
   dat_feinkost_theke                  DATE             COMMENT 'Eröffnungsdatum der Theke. Kann auch leer sein.
            ',
   dat_fisch_theke                     DATE             COMMENT 'Eröffnungsdatum der Theke. Kann auch leer sein.
            ',
   dat_wup_ref_von                     DATE             COMMENT 'Datum von dem ab der Referenzmarkt für die Ist-Umsätze herangezogen werden soll (im Format JJJJ-MM_2-TT)',
   dat_wup_ref_bis                     DATE             COMMENT 'Datum bis zu dem der Referenzmarkt für die Ist-Umsätze herangezogen werden soll (im Format JJJJ-MM_2-TT)',
   referenzgrund_id                    NUMBER(38,0)     COMMENT 'Die ID für den Grund warum eine_2 Referenzfiliale herangezogen wurde',
   bereinigt_fg                        NUMBER(38,0)     DEFAULT 0 COMMENT 'Das FG gibt an, ob eine_2 Filiale noch im Expansionszeitraum liegt (Start GJ_plan-1)
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_WUP PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Pflege der Filialen (inkl. Planfilialen) - Planversion abhaengig - manueller Upload';

