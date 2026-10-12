--==============================================================
-- Table: kasse_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kasse_typ_spr_zu
   generated from Powerdesigner on Donnerstag, 29. Juli 2021 16:55:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.kasse_typ_spr_zu (
   kasse_typ_id                        INTEGER    NOT NULL COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt',
   spr_id                              INTEGER    NOT NULL COMMENT 'ID der Sprache',
   kasse_typ_bez                       VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Kassentyps (z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)',
   kasse_name_bez                      VARCHAR(6)      COMMENT 'Kassekurzbezeichnung. Z.B. POS, SCO, …'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'ODS - Sprachabhaengige Bezeichnungen fuer den Kassentyp (DE: z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)';