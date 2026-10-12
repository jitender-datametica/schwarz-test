--==============================================================
-- Table: kasse_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kasse_typ_spr_zu_2
   generated from Powerdesigner on Donnerstag, 29. Juli 2021 16:55:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.kasse_typ_spr_zu_2 (
kasse_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kasse_typ_bez STRING(20) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Kassentyps (z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)'),
kasse_name_bez STRING(6) OPTIONS(description='Kassekurzbezeichnung. Z.B. POS, SCO, …'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='ODS - Sprachabhaengige Bezeichnungen fuer den Kassentyp (DE: z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)');