--==============================================================
-- Table: amx_pruefung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_pruefung_2
   generated from Powerdesigner on Donnerstag, 1. April 2021 14:41:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.amx_pruefung_2 (
   pruefung_id                         NUMBER          NOT NULL COMMENT 'Die eindeutige ID einer Pruefung aus dem Quellfeld auditing.id',
   amx_system_id                       INTEGER         DEFAULT -1 NOT NULL COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruefung_nr                         VARCHAR(30)     collate 'en-ci' DEFAULT ' ' NOT NULL COMMENT 'Nummer der Pruefung, z.Bsp. 2014-00001 aus dem Quellfeld a_number',
   zustand_id                          NUMBER          DEFAULT -1 NOT NULL COMMENT 'Eindeutige ID eines Zustands aus dem Quellfeld  state. Referenz zu wal_state.nr',
   pruefung_bez                        VARCHAR(255)    collate 'en-ci' DEFAULT ' ' NOT NULL COMMENT 'Bezeichnung der Pruefung aus dem Quellfeld name',
   dat_start                           DATE            COMMENT 'Das Startdatum der Pruefung. Aus der Quellspalte start_date',
   dat_ende                            DATE            COMMENT 'Das Endedatum der Pruefung aus dem Quellfeld end_date',
   revisor_id                          NUMBER          DEFAULT -1 NOT NULL COMMENT 'Revisor wurde aus Datenschutzgruenden ausgebaut und darf nicht ohne Ruecksprache mit SBIT wieder eingebaut werden. Default-Wert -1. Eindeutige ID des Pruefers aus dem Quellfeld leading_autitor_id. Referenz zur Tabelle amx_revisor_2',
   pruefung_typ_id                     NUMBER          DEFAULT -1 NOT NULL COMMENT 'Eindeutige ID des Pruefungstyps aus dem Quellfeld auditing_type_id',
   pruefung_klasse_id                  NUMBER          DEFAULT -1 NOT NULL COMMENT 'Eindeutige ID der Pruefungsklasse aus dem Quellfeld auditing_class_id',
   pruefung_ergebnis_wert              NUMBER          DEFAULT -1 NOT NULL COMMENT 'Ergebniswert aus Quellfeld numeric_result',
   business_unit_id                    NUMBER          COMMENT 'ID der organisatorischen Einheit.Verweis auf ein Prueffeld mit dem Typ Stelle.  Aus dem Quellfeld business_unit_id bzw. audit_universe.id',
   mandant_id                          NUMBER          COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER          COMMENT 'Marktnummer aus t001w.werks',
   zeitspanne                          VARCHAR(80)     DEFAULT '?' COMMENT 'Tageszeit bspw. frueh bis 12 Uhr'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'VIS audimex - Die Tabelle amx_pruefung_2 enthaelt die  Pruefungen. Aus der Quelle audimex.auditing';

