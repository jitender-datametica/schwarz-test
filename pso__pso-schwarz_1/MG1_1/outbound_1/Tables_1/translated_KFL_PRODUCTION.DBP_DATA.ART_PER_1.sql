CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_PER_1 (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
DAT_VON DATE NOT NULL
OPTIONS(description='Datum, von dem an der Zustand gilt. Initial wird das dat_von aus der Tabelle art_1 eingetragen'),
DAT_BIS DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, bis zu dem der Zustand gueltig war/ist. Bei aktuellen Eintraegen der 31.12.9999'),
MUTTER_WB_ID INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des fuehrenden Artikels (auch: Mutterartikel) hinterlegt'),
POSTEN_ID STRING(2) COLLATE 'und:ci' OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN'),
IPN_ID INTEGER OPTIONS(description='Internationale Produktnummer zum Artikel_1 (MAW1.ZZEK_IPN)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
MWST_ID INTEGER OPTIONS(description='Mehrwertsteuer-Kennzeichen historisiert'),
OUG_ID INTEGER OPTIONS(description='Kennzeichen Obst und Gemuese'),
IWT_ID STRING(1) DEFAULT ''
OPTIONS(description='IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country_1 for its own use (/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country_1 (I)'),
PRIMARY KEY (ART_ID, MANDANT_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Einzelne Attribute der Tabelle art_1 werden im DWH historisiert');