CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_scanning (wup_id
OPTIONS(description='WarenUmschlagsPlatz - hier der Markt'), mandant_id OPTIONS(description='Mandant im DWH'), bewart_id
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
gp_id OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), art_id
OPTIONS(description='DWH-Artikelnummer'), dat OPTIONS(description='Datum im Format JJJJ-MM-TT'), aktion_id
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Kassenschnittstelle. Referenz zur Tabelle aktion '),
promo_fg OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)'), gtin_kasse
OPTIONS(description='von den Kassensystemen gelieferte GTIN (früher EAN)'), kasse_typ_id
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.'),
vorgang_scanned OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel gescannt wurde'), vorgang_keyed
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel mauell erfasst wurde'), vorgang_scanned_einzeln
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel einzeln gescannt wurde'), vorgang_keyed_einzeln
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel einzeln nicht gescannt wurde'), anzahl_bon
OPTIONS(description='Anzahl der Bons, auf denen der Artikel vorkommt'), anzahl_registriert
OPTIONS(description='Summe aller Artikel, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.'))
OPTIONS(DESCRIPTION = `TP2_AIS - KLON DER ARTBEW MIT KENNZAHLEN ZU SCANNINGQUOTE UND BONDATEN`) AS SELECT wup_id,
 mandant_id,
 bewart_id,
 gp_id,
 nb_id,
 art_id,
 dat,
 aktion_id,
 promo_fg,
 gtin_kasse,
 kasse_typ_id,
 vorgang_scanned,
 vorgang_keyed,
 vorgang_scanned_einzeln,
 vorgang_keyed_einzeln,
 anzahl_bon,
 anzahl_registriert
FROM kfl_production_dbp_data.artbew_scanning;