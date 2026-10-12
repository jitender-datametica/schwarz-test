CREATE OR REPLACE TABLE kfl_production_dbp_ods.kasse_typ_spr_zu_1 (
kasse_typ_id INTEGER NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
kasse_typ_bez STRING(20) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Kassentyps (z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
kasse_name_bez STRING(6) OPTIONS(description='Kassekurzbezeichnung. Z.B. POS, SCO, …')
)
OPTIONS(description='ODS - Sprachabhaengige Bezeichnungen fuer den Kassentyp (DE: z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)');