--==============================================================
-- Table: wbs_referenzartikel_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_referenzartikel_2
   generated from Powerdesigner on Montag, 19. September 2022 10:58:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_referenzartikel_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
ref_art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2-ID des Referenzartikels'),
ref_anz_maerkte BIGNUMERIC(38,0) OPTIONS(description='ref_anz_maerkte'),
avg_vk_brutto BIGNUMERIC(38,4) OPTIONS(description='Preis (avg) des Fokusartikels'),
avg_ref_vk_brutto BIGNUMERIC(38,4) OPTIONS(description='Preis (avg) des Referenzartikels'),
ref_score_rang BIGNUMERIC(38,0) OPTIONS(description='Rang der Ähnlichkeit.'),
ref_score BIGNUMERIC(38,4)
OPTIONS(description='Referenzscore aus Formel,  bei TYP=\"Missing\" werden Ähnlichkeit & Absatzdifferenz nicht verwendet.'),
diff_vk BIGNUMERIC(38,4) OPTIONS(description='Preisdifferenz der Mittleren Preise von Ref- & Fokusartikel'),
diff_absatz BIGNUMERIC(38,4) OPTIONS(description='Differenz mittlerer Absatz'),
diff_absatz_absolut BIGNUMERIC(38,4) OPTIONS(description='Differenz mittlerer Absatz (Absolut)'),
diff_absatz_kennz STRING(1) OPTIONS(description='Kennzeichen, ob Absatzdifferenz Positiv / negativ ist.'),
diff_cosinus BIGNUMERIC(38,4) OPTIONS(description='Cosinusähnlichkeit, aus W2V-Modell'),
diff_gewicht BIGNUMERIC(38,4) OPTIONS(description='Differenz Gewicht'),
diff_wug BIGNUMERIC(38,4) OPTIONS(description='Differenz Warenuntergruppe'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr'),
ref_ltz_dat_von DATE OPTIONS(description='Start letzte Promowoche des Referenzartikels'),
dat_von DATE NOT NULL OPTIONS(description='YYYY-MM_2-DD // Aktion_2 gültig (von)'),
ltz_dat_von DATE OPTIONS(description='Start letzte Promowoche des Fokusartikels'),
berechnung_typ STRING(100)
OPTIONS(description='Kennzeichnung, der Berechnungsgrundlage zu Evaluation: missing == nicht im W2V-Modell vorhandensearch == extrahiert aus W2V-Modell'),
dat_berechnung TIMESTAMP OPTIONS(description='Berechnungszeitpunkt des Berichts'),
selektor_fg BIGNUMERIC(38,0) OPTIONS(description='Artikel_2 für Report geeignet.'),
berechnung_subtyp STRING(100) OPTIONS(description='Subtyp'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, ref_art_id, dat_von) NOT ENFORCED
)
OPTIONS(description='table is used in WBS-context. It contains information of promotional articles and the reference-articles which are used to calculate and adjust promotional amounts');