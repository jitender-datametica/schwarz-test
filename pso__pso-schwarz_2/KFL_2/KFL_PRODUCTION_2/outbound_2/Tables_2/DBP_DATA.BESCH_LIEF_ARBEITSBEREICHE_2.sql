--==============================================================
-- Table: besch_lief_arbeitsbereiche_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_arbeitsbereiche_2
   generated from Powerdesigner on Montag, 19. September 2022 08:27:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_arbeitsbereiche_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kunde_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Als Format wurde bewusst Integer gewählt - ist kein Versehen'),
wtag_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag'),
dat_lief_soll DATE NOT NULL
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen.'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
disponent_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Disponent ID'),
wg_verkett_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Warengruppenverkettung ist artikelbezogen. Wird in SAP auf die Kopftabelle hochgezogen, die erste Position als Quelle. Stimmt also bei Mischpaletten nicht für alle Positionen. Referenziert auf die Tabelle l_wg_verkettung. Das SAP-Feld ist zzlwgrv'),
disposition_rhythmus_ltf_id STRING(3) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='ID für den Dispositionsrhythmus (wie oft, an welchen Wochentagen)'),
terminierungsgruppe_1_id STRING(3) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 1'),
terminierungsgruppe_2_id STRING(2) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 2'),
terminierungsgruppe_3_id STRING(2) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 3'),
auslieferungsgruppe_id STRING(4) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='ID der Auslieferungsgruppe'),
kunde_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Compress'),
disposition_rhythmus_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender'),
disponent_name STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Name des Disponenten'),
wup_standort STRING(40) COLLATE 'und:ci' OPTIONS(description='Ortsbezeichnung'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Bestellart (bsart)'),
lief_pal_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_2 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.'),
diff_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Wenn eine_2 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
menge_lief_ist_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Anzahl der Kollis der Lieferposition. Ermittlung bei der Kommisionierung'),
menge_lief_soll_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
betrag_lief_ist NUMERIC(18,2)
OPTIONS(description='redundantes Feld, um den CROSS JOIN zur art_gp_wup_zu_per_2 zu sparen, berechnet anzahl_kolli*ek_netto_bnk*komponentenmenge. Format NUMERIC(18,4)'),
betrag_lief_soll NUMERIC(18,2)
OPTIONS(description='redundantes Feld, um den CROSS JOIN zur art_gp_wup_zu_per_2 zu sparen, berechnet menge_lief_soll*ek_netto_bnk*komponentenmenge. Format NUMERIC(18,4)'),
menge_lief_palette NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_2 und art_umrechnung_faktor_per_2 ermittelt.'),
mandant_id_kunde BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als der WUP_2 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, kunde_id, wtag_id, dat_lief_soll, wg_id, arthiertyp_id, wg_verkett_id)
NOT ENFORCED
) CLUSTER BY mandant_id, dat_lief_soll
OPTIONS(description='TP408_LVS - Aggregat für den Bericht Arbeitsbereiche');