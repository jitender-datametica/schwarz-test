CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
MWST_ID INTEGER NOT NULL OPTIONS(description='Mehrwertsteuer - Kennzeichen.'),
LAND_ID STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Herkunftsland.'),
REGION_ID INTEGER NOT NULL
OPTIONS(description='Region_2 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_2 gebildet.'),
KL_ART_ID INTEGER NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.'),
DAT_VON DATE NOT NULL
OPTIONS(description='Datum, ab welchem der Artikel_2 im System angelegt wurde. Bei Artikeln älter als DWH: 1900-01-01. (SAP Quellfeld: MARA.ERSDA))'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Reorganisations (Lösch)-Datum des Artikels in SAP. Bei nicht gelöschten Artikeln: 9999-12-31.'),
DAT_ANGELEGT DATE
OPTIONS(description='Datum, an dem der Artikel_2 angelegt wurde. Für Artikel_2, die bereits vor SAP vorhanden waren wurde das Anlagedatum aus dem Vorsystem übernommen. Für Artikel_2, die erst nach der SAP Einführung angelegt wurden entsptricht das Anlagedatum dem Erstelldatum in SAP (dat_von). (SAP Quellfeld: MARA.DATAB)'),
LOESCH_ID STRING COLLATE 'und:ci' NOT NULL
OPTIONS(description='Löschkennzeichen für logische Löschung, kann folgende Ausprägungen annehmen G: Gesperrt, R: Räumen, L: Gelöscht, blank: kein Löschkennzeichen.'),
BIO_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Biosiegel Flag EU, es gibt auch noch ein bio_fg_cz (Kürzel: BIO).'),
WG_ART_FG INTEGER NOT NULL
OPTIONS(description='Warengruppen-Artikel_2 (wird auch als Sumpfartikel oder Warengruppen-Erfassungsartikel bezeichnet). Wird benutzt, wenn sich ein Artikel_2 nicht eindeutig einer Artikelnummer zuordnen lässt. 0 = Nein; 1 = Ja.'),
POSTEN_ID STRING COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_2, die nicht ständig im Sortiment sind (für KMO ist es ein posten_fg, wenn das Posten-KZ in SAP wird eine_2 1 gesetzt).'),
LEAD_ID INTEGER NOT NULL OPTIONS(description='Leaderkennzeichen.'),
LEIST_ID STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelkennzeichen Leistungsstark Food.'),
DISCOUNT_ID INTEGER NOT NULL
OPTIONS(description='Schlüssel des Discount Artikelkennzeichens - numerischer Wert (0 = kein Discountartikel, oder Kennzeichen zwischen 1 und 7).'),
VERPART_ID STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Verpackungsart, z.Bsp DS.'),
ESB_ID STRING COLLATE 'und:ci'
OPTIONS(description='Kalkulationskennzeichen Nonfood. Inhalt = E für Einstiegspreislage, B für Blickpunktartikel. S = Strategieartikel. Wird nicht mehr benutzt.'),
ALDI_ID INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, in welcher / welchen Vertriebsschiene(n) ein Artikel_2 das Aldi Kennzeichen besitzt, kann sich auf eine_2 oder mehrere Vertriebsschienen beziehen.'),
ZEK_ID STRING NOT NULL
OPTIONS(description='Zentraleinkäufer-ID: Diese ID ist nicht mit der Mitarbeiter-ID identisch. So gesehen eine_2 überflüssige ID.'),
GEWART_ID STRING COLLATE 'und:ci'
OPTIONS(description='Gewichtsartikel: ist bei Gewichtsartikeln = KG, bei Stückartikeln = ST.'),
EIGENMARKE_ID STRING COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Classik Artikel_2).'),
MUTTER_WB_ID INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
DISPLAY_ID INTEGER OPTIONS(description='Schlüssel des Artikelkennzeichens Display (0 = kein Displayartikel).'),
BEST_MENGE_EINH_ID STRING COLLATE 'und:ci'
OPTIONS(description='Bestellmengeneinheit. Diese Mengeneinheit wird standardmäßig bei Bestellungen verwendet.'),
LOESCHVORM_FG INTEGER DEFAULT - 1
OPTIONS(description='Kennzeichen, dass Artikel_2 zum Löschen vorgemerkt wird. 1 entspricht Ja.'),
MHD_ZEITRAUM INTEGER
OPTIONS(description='Dieses Feld gibt den standardmässigen Mindesthaltbarkeitszeitraum für diesen Artikel_2 in Tagen an.'),
ARTIKELART_ID STRING COLLATE 'und:ci'
OPTIONS(description='Kategorisierung in Artikelarten (z. B. Batterien, Leergut, Sport-Schuhe). Referenz zu der Tabelle l_artikelart.'),
BASISMENGE_EINH_ID STRING COLLATE 'und:ci'
OPTIONS(description='Alternative Mengenheinheit für den Artikel_2 in Basismenge. Referenz zu der Tabelle art_umrechnung_faktor_per.'),
FAKTOR_NETTOINHALT NUMERIC(18,3)
OPTIONS(description='Umrechnungsfaktor von Stück in Nettogewicht (wenn die Basismengeneinheit in Stück ausgewiesen ist). Aus SAP MARA.INHAL.'),
MUTTER_VK_ID INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleichen Verkaufspreisen ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
LAGER_PROZENT INTEGER DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_2 vom Lager ausgeliefert wird.'),
TEMPERATUR_ID STRING COLLATE 'und:ci' OPTIONS(description='Kennzeichen für den Temperaturbereich, z.Bsp. 3.'),
DUALES_SYSTEM_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Duales System-Gebühren (0 = nein, 1 = ja).'),
GRS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag für Gemeinsames Rücknahme System (für Batterien) -Gebühren (0=nein, 1 = ja).'),
EAR_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag für Elektro-Altgeräte-Register-Gebühren (0 = nein, 1 = ja).'),
GEMA_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag für GEMA (Gesellschaft für musikalische Aufführungs- und mechanische Vervielfältigungsrechte) -relevante Artikel_2 (0 = nein, 1 = ja).'),
LACTOSE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Lactosefreie Artikel.'),
GLUTEN_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Gluten-freie Artikel.'),
DIAET_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag kennzeichnet Diät-Artikel.'),
ARTIKELTYP_ID INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Klassifizierung des Artikels, z.Bsp. Displayartikel.'),
VERKAUF_SPERRE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet für den Verkkauf gesperrte Artikel. Nur in DE SAP vorhanden.'),
EINH_ID STRING COLLATE 'und:ci' OPTIONS(description='Maßeinheit aus mara.inhme. Referenz zur Tabelle l_einh_2 (t006a).'),
PLATZ_RELEVANT_FG INTEGER NOT NULL
OPTIONS(description='Flag zur Kennzeichnung platzierungsrelevanter Artikel_2 aus maw1.zzekplatz.'),
BITREX_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BEX. Bitrex.'),
BLAUER_ENGEL_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BLA. Blauer Engel.'),
DACHLOGO_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DAC. Dachlogo.'),
DOLPHIN_SAFE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DTU. Delfinsicherer Thunfischfang (Safe).'),
EURO_BLUME_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon EBL. Europäisches Umweltzeichen Euro-Blume.'),
ECOCERT_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon ECO. Ecocert Flag (Bio-Zertifizierung).'),
EIER_BH_FH_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon EIB. Eier aus Bodenhaltung (BH) / Freilandhaltung (FH).'),
FAIR_TRADE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FAT. Fair Trade.'),
FOS_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FOS. Friend of the sea (FOS).'),
FSC_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FSC. Forest Stewardship Council (FSC).'),
GAP_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GAP. Gemeinsame Agrapolitik (GAP).'),
GOTS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GOT. Siegel zur Kennzeichnung Global Organic Textile Standard (GOTS) - Organic in conversion, min 95%.'),
HALAL_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon HAL. Halal.'),
KANINCHEN_BH_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon KAB. SAP Icon KAB. Kaninchen aus Bodenhaltung (BH).'),
KEIMLING_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon KEI. Keimling.'),
KEIN_STOPF_RUPF_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon KST. Keine Stopfmast / kein Lebendrupf.'),
MSC_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon MSC. Marine Stewardship Council (MSC).'),
KON_NAT_KOSMETIK_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon NAK. Kontrollierte Naturkosmetik.'),
NATRUE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon NAT. NaTrue Naturkosmetik-Siegel.'),
NATURLAND_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon NLA. Naturland.'),
OHNE_GENTECHNIK_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon OGE. Ohne Gentechnik.'),
OEKO_TEX_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon OTS. Textiles Vertrauen - Öko-Tex Standard 100.'),
PEFC_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon PEF. Programme for the Endorsement of Forest Certification Schemes (PEFC), Nachhaltigkeit in der Waldwirtschaft.'),
RAINFOREST_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RAL. Rainforest Alliance.'),
SUSTAIN_CLEAN_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon SCC. Sustainable-cleaning-charter (SCC) Logo_2 für nachhaltiges Waschen und Reinigen.'),
TIERSCHUTZ_GEPR_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Tierschutz geprüft Flag.'),
AQUAGAP_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Aqua Gap Flag für nachhaltige Fischereiwirtschaft aus der Quelle zekstn (Kürzel: AQUAGAP).'),
SAISON_ID STRING COLLATE 'und:ci' OPTIONS(description='ID der Saison aus saiso, z.Bsp 9.'),
JUGENDSCHUTZ_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Jugendschutz Kennzeichen aus maw1.zzek_ekpom. Enthält eine_2 Altersangabe (z.Bsp. 12,16,18).'),
FOLLOW_FISH_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: FollowFish (Kürzel: FOLLOW_FISH).'),
GEPA_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: GEPA Fair Trade (Kürzel: GEPA).'),
GREEN_BRANDS_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Green Brands Flag.'),
NATURE_AND_RESPECT_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Nature & Respect Flag für artgerechte Tierhaltung (Kürzel: NATURE_AND_RESPECT).'),
UTZ_CERTIFIED_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: UTZ Certified Flag für Kaffeeprodukte (Kürzel: UTZ_CERTIFIED).'),
OEKO_TEX_STD_100_PLUS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Ökotex Standard 100 (Kürzel: OEKO_TEX_STD_100_PLUS).'),
VIER_PFOTEN_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Vier Pfoten (Kürzel: VIER_PFOTEN).'),
ASC_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon ASC. Aquaculture Stewardship Council (ASC) für nachhaltige Fischzucht aus Aquakultur.'),
BAP_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BAP. Best Aquaculture Practices (BAP).'),
RSPO_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Roundtable on Sustainable Palm Oil (RSPO).'),
KL_ART_ID_ALT INTEGER OPTIONS(description='Vorgänger-Artikelnummer aus der Spalte bismt.'),
TAGESARTIKEL_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Tagesartikel-Flag aus maw1.zzek_kztgar. Tagesartikel müssen innerhalb eines Tages verkauft werden.'),
KEIN_ABVERKAUF_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kein-Abverkauf-Flag aus maw1.zzek_nsale. Wenn = 1, darf der Artikel_2 nicht abverkauft werden.'),
DIV_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DIV. Diverse Logos.'),
FCP_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FCP. FT cocoa.'),
FW_SAISON_ID STRING COLLATE 'und:ci'
OPTIONS(description='ID für das Fleischwerk-Artikel_2-Kennzeichen Saison aus dem Quellfeld zzfwarblock mit Referenz zu zfwprartik bzw.l_fw_saison.'),
FW_WK_SYSTEM_ID STRING COLLATE 'und:ci'
OPTIONS(description='ID des Fleischwerk WK Artikelkennzeichens aus zzfwbeschaf, z.Bsp. Innereien.'),
FW_WK_DISCOUNT_ID STRING COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung fw_wk_discount aus dem Quellfeld zfwqualita.'),
FW_WK_NATIONAL_ID STRING COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung fw_wk_national aus dem Quellfeld zfwwarenar.'),
FW_WE_HAMMER_ID STRING COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung Fleischwerk WE-Hammer aus dem Quellfeld zfwveredel.'),
FW_WE_ARTIKEL_ID STRING COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung Fleischwerk WE-Artikel_2 aus dem Quellfeld zfwprzuber.'),
FW_RESERVE_ID STRING COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung Artikel_2 Fleischwerk Reserve aus dem Quellfeld zfwbestvor.'),
VEGAN_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon VGN. Vegan. Wird für Lebensmittel gesetzt wenn sie vegan sind.'),
VEGAN_KAUFLAND_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon VGK. Siegel zur Kennzeichnung Vegan (Kaufland internes vegan Zeichen). Wird für Beauty Artikel_2 der Kaufland Eigenmarke gesetzt wenn sie vegan sind.'),
VEGETARISCH_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon VGT. Vegetarisch.'),
PSF_ID INTEGER OPTIONS(description='ID des Produktschaufensters aus zzek_showcase, z.Bsp. 1.'),
MENGE_HAUS INTEGER OPTIONS(description='Haushaltsübliche Menge aus zzek_hausmg.'),
SMGRP INTEGER OPTIONS(description='Sortimentsmanagergruppe aus zzek_smgrp. Referenziert auf die Tabelle zek_2(t024_2).'),
TIERWOHL_KZ STRING COLLATE 'und:ci'
OPTIONS(description='Kennzeichen Tierwohl, z.Bsp. sw für Schwein, aus dem Quellfeld zzek_tierwohl. Keine Lookup vorhanden.'),
GTIN_ID INTEGER NOT NULL
OPTIONS(description='Pro Artikel_2 ist eine_2 Haupt-GTIN vorhanden. Diese wird für KMO hier abgelegt. Für DE wird -1 eingetragen.'),
BIO_FG_CZ INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Bio Flag CZ. Aus der Quelle SAP zek_sustain_set.pez.'),
VERHANDLER_ID STRING COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='MAW1.ZZEK_ZEKKLMAVERH - Verhandler KL-Marke.'),
ZEK_VAT_ID STRING NOT NULL
OPTIONS(description='Zentraleinkäufer-ID: Diese ID ist nicht mit der Mitarbeiter-ID identisch.'),
INHALT_MENGE_EINH_ID STRING COLLATE 'und:ci' OPTIONS(description='Maßeinheit für das Feld Inhalt_Menge.'),
INHALT_MENGE NUMERIC(18,3) OPTIONS(description='Inhaltsmenge (abhängig von der Maßeinheit (inhalt_menge_einh_id).'),
KEIN_VK_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag kein Verkaufsartikel (1 = kein Verkaufsartikel).'),
GOTS_ORGAN_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GOO. Global Organic Textile Standard (GOTS) - made with min 95%+ organic materials.'),
GOTS_PROZ_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GOP. Global Organic Textile Standard (GOTS) - made with 70-94% organic materials.'),
GU_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon PDO. Geschützte Ursprungsbezeichnung (GU).'),
GGA_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon PGI. Geschützte Geografische Angabe (GGA).'),
FSC_VERPACKUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon PVP. FSC Verpackung (Kürzel: PVP).'),
RAINF_KAKAO_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RKA. Rainforest Kakao.'),
RAINF_KAFFEE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RKF. Rainforest Kaffee.'),
GTS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon TSG. Garantiert traditionelle Spezialität (GTS).'),
BLAUER_ENGEL_ABBAUBAR_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BAB. Blauer Engel abbaubar.'),
BLAUER_ENGEL_ALTPAPIER_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BAL. Blauer Engel Altpapier.'),
BIO_BW_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BBW. Bio BW.'),
BIOLAND_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BIL. Bioland.'),
BLAUER_ENGEL_KUNSTSTOFF_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BKU. Blauer Engel Kunststoff.'),
BLAUER_ENGEL_MEHRWEG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BME. Blauer Engel Mehrweg.'),
BLAUER_ENGEL_WIRKSTOFF_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BOW. Blauer Engel Wirkstoff.'),
BLAUER_ENGEL_WASSER2_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BSA. Blauer Engel Wasser 2.'),
BLAUER_ENGEL_SOLARBETRIEB_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BSO. Blauer Engel Solarbetrieb.'),
BLAUER_ENGEL_UNGEBLEICHT_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BUG. Blauer Engel Ungebleicht.'),
DTB_EINSTIEG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DTE. Deutscher Tierschutzbund (DTB) Einstiegsstufe.'),
DTB_PREMIUM_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DTP. Deutscher Tierschutzbund (DTB) Premiumstufe.'),
FREILANDHALTUNG_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FDH. Freilandhaltung.'),
NEULAND_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon NEL. Neuland.'),
QS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon QSP. QS-Prüfzeichen für Lebensmittel.'),
WEIDEHALTUNG_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon WDH. Weidehaltung.'),
TIERWOHL_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon ITW. Initiative Tierwohl.'),
MARKTFRISCH_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon MAF. Marktfrisch.'),
YELLOWPRINT_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Gelbes Regaletikett.'),
IPN_ID INTEGER OPTIONS(description='Internationale Produktnummer zum Artikel_2 (MAW1.ZZEK_IPN).'),
POSTEN_KZ_SAP STRING COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_2, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert) (z.B PN = Posten, SP = sortimentsnahe Posten, etc.).'),
DEMETER_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Demeter-Artikel.'),
KAUFEMPFEHLUNG_FG INTEGER OPTIONS(description='Flag Kaufempfehlung (0 = nein, 1 = ja).'),
NEU_SORT_FG INTEGER OPTIONS(description='Kennzeichen neu im Sortiment (0 = nein, 1 = ja).'),
DISCOUNTART_ID STRING COLLATE 'und:ci' OPTIONS(description='ID Discountart.'),
POSITIONSTYP_GRP_ID STRING COLLATE 'und:ci' DEFAULT '    ' NOT NULL
OPTIONS(description='ID allgemeine Positionstypengruppe.'),
ARTIKELROLLE_ID STRING COLLATE 'und:ci' OPTIONS(description='Artikelrolle international ID.'),
UNSERE_REGION_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_2 ist aus der Region_2 (BG).'),
LETS_BBQ_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_2 hat das Saisonkennzeichen Lets Barbeque.'),
VERPACKUNGSEINSPARUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Verpackungsmaterial wurde beim Artikel_2 gespart (Kürzel:BEV).'),
CZ_NORM_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_2 nach der tschech.Zunftnorm.'),
KL_EXCLUSIV_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Exclusiv bei Kaufland.'),
ZUM_FASTEN_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_2 zum Fasten geeignet.'),
KL_BESONDERES_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Besonderes bei Kaufland.'),
STAHLHALTUNG_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Haltungsform 1_Stallhaltung.'),
STAHLHALTUNG_PLUS_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Haltungsform 2_Stallhaltung Plus.'),
AUSSENKLIMA_HALTUNG_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Haltungsform 3_Außenklima.'),
PREMIUM_HALTUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Haltungsform 4_Premium. Seit Mitte 2024 wurde die Premium-Haltungsform in zwei geteilt. Diese stellt die Auslauf/Weide Form dar.'),
BIO_HALTUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon HF5. Siegel zur Kennzeichnung Initiative Tierwohl - Haltungsform 5 (Bio).'),
MACHEN_MACHT_UNTERSCHIED_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Artikelslogan: K-CSR_Machen macht den Untersch.'),
PREMIUM_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Saison Kennzeichen: Premium.'),
QAFP_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='QAFP - quality control sign.'),
QUDAL_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='QUDAL - Top quality medal.'),
REGIONALE_LEBENSMITTEL_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RPO. Regional food (CZ).'),
STARTUP_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Startup Artikel_2 - startup by Kaufland.'),
TOGO_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Saisonkennzeichen: ToGo.'),
OHNE_MICROPLASTIK_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Rezeptur ohne Mikroplastik.'),
GRK_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Grüner Knopf.'),
PPL_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Produkt Polski.'),
RPP_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Online Click & Collect.'),
RSC_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Online Supermercato.'),
DAA_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='DAAB.'),
OKT_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Ohne Kükentöten (OKT).'),
MUTTER_1_N_ID INTEGER OPTIONS(description='Neu Uebergang Art_id aus 1:N BQ Findung DE Logik.'),
SUSTAIN_CONCAT STRING COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Alle Nachhaltigkeitslogos konkatiniert, Quelle ZEK_SUSTAIN_SET.'),
INT_ART_ID INTEGER OPTIONS(description='Internationale Artikelnummer aus ZSM.'),
TAGE_UEBERNACHTUNGEN INTEGER OPTIONS(description='Tage Übernachtungen im Zentrallager.'),
GGN_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: GGN zertifiziertes Farming (Kürzel GGN).'),
OUG_ID INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kennzeichen Obst und Gemüse.'),
NETTOGEW NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Nettogewicht des Artikels. Feld NTGEW.'),
WSI_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Wasser sparen.'),
VBE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Veganblume.'),
FTE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='fTrace'),
KNI_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Klimaneutral.'),
NHI_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Nationales Länderherz.'),
VAC_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Vegan ohne V-Label.'),
GBS_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Ohne Verwendung von GVO hergestellt..'),
EK_MARKEN_ID INTEGER OPTIONS(description='ID des Markennamens im Einkauf.'),
NAT_BIO_SIEGEL_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon NBS. Ein Bio-Siegel ist ein Güte- und Prüfsiegel, mit welchem Erzeugnisse aus ökologischem Landbau gekennzeichnet werden.'),
FAIR_SUGAR_PROG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FSP. Fairtrade Sugar Program (FSI).'),
FAIR_COTTON_PROG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FCO. Fairtrade Cotton Program (FSI).'),
SUSTAINABLE_CLEANING_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon SCK. Das Sustainable Cleaning Siegel kennzeichnet Putz- und Reinigungsprodukte, die hohe Standards für Umweltsicherheit erfüllen, Abfall minimieren und klare und transparente Informationen über die nachhaltigere Verwendung liefern.\n            www.cleanright.eu'),
RAINFOREST_ALLIANCE_TEE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RAT. Das Rainforest Alliance Certified (RFA) Siegel wird für Kakao, Kaffee, Tee, Zitrusfrüchte oder Bananen vergeben, die unter Berücksichtigung ökologischer, sozialer und ökonomischer Anforderungen angebaut werden.\n             www.rainforest-alliance.org'),
HEUMILCH_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon HEM. Heumilch.'),
FAIRMAST_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FAM. Fairmast.'),
KAT_KONTROLLIERT_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon KDK. Das KAT-Kennzeichnungssystem gibt detailliert Auskunft über die Herkunft von Eiern und schafft so größtmögliche Transparenz.\n            www.kat.eu '),
KDK_KALB_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon KDI. Kalbfleisch aus der Heimat, das unter den hohen Erzeugungs- und Tierwohlstandards der Kontrollgemeinschaft Deutsches Kalbfleisch produziert wird.\n            www.deutscheskalbfleisch.de'),
ORGANIC_CONT_STD_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon OCS. Der Organic Content Standard (OCS) ermöglicht es, den genauen Anteil an ökologischem Material in einer Ware zu erfassen und durch die Produktionskette weiterzuverfolgen. Er besagt, dass Bio-Baumwolle eingesetzt wurde.\n            www.textileexchange.org'),
GLOBAL_REC_STD_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GRS. Global Recycled Standard (GRS).'),
GLOBAL_REC_STD_50_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R50. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_55_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R55. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_60_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R60. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_65_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R65. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_70_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R70. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_75_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R75. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_80_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R80. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_85_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R85. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
GLOBAL_REC_STD_90_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon R90. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_2 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
INSTITUT_HEIDGER_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon IHE. Institut Heidger.'),
COTTON_MIA_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CMA. Cotton made in Africa (CmiA) ist ein international anerkannter Standard für nachhaltige Baumwolle aus Afrika. Im Fokus stehen der Umweltschutz sowie bessere Arbeits- und Lebensbedingungen für Kleinbauern und Arbeiter in den Entkörnungsbetrieben.\n            www.cottonmadeinafrica.org'),
DOWNPASS_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DPA. Down Pass.'),
JUNGHAHNAUFZUCHT_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon JHI. Junghahnenaufzucht.'),
BORD_BIA_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BOB. Bord Bia.'),
GSS_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GSS. GS.'),
TUV_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon TUV. TÜV.'),
CES_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CES. CE.'),
AKLASA_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon AKL. aKlasa.'),
I_KNOW_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon VCO. I know what I eat.'),
CZECH_GUILD_STD_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CCI. ČCN (Czech Guild Standard).'),
CZECH_FOOD_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CPO. Czech food.'),
ORGANIC_COTTON_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon OCO. Organic Cotton.'),
SEPHORA_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon SAN. sephora-approved-natural-product-seal.'),
GREEN_GLOBE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GGL. Green-globe.'),
CERTIFICARE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CHI. CERTIFICARE-HACCP.'),
BG_STATE_STD_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BST. Bulgarische staatliche Standards.'),
AYVAR_QUALITY_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GQU. Geprüfte Qualität für Ayvar.'),
CREEKSTONE_FARM_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CFA. Creekstone Farms.'),
MILCHPRODUKTE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon MSI. Milchprodukte Siegel.'),
STARA_PLANINA_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon SPL. Stara Planina geprüfter Standard.'),
BGI_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BGI. Ich wähle bulgarisch.'),
BGS_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BGS. Wählen Sie bulgarisch.'),
BROT_QUAL_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GQB. geprüfte Qualität für Brot.'),
DTI_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DTI. d test.'),
MFD_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon MFD . MF today.'),
CONSUMER_CHOICE_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon VSP. Consumer Choice.'),
FLASH_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon BLE. Flash.'),
CZ_APPETIZER_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CCH. Czech appetizer.'),
CHILDREN_APPETIZER_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon DCH. Childrens appetizer.'),
NATULON_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon NAC. Das YKK NATULON® Siegel garantiert, dass Teile des Reißverschlusses aus recyceltem Material bestehen.\n            www.ykkdigitalshowroom.com/en/ '),
LAENDERHERZ_5D_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon FUD . Länderherz_5D.'),
OHNE_GENTECHNIK_NICHT_VLOG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon OGO. Eine_2 Ausprägung für „ohne Gentechnik“ gekennzeichnete Lebensmittel. Artikel_2 ohne Auditierung der VLOG (Verband Lebensmittel ohne Gentechnik).'),
TRADITIONAL_CERTIFIED_PRODUCT_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon TCP. Siegel zur Kennzeichnung traditionell zertifizierter Produkte.'),
IWT_ID STRING DEFAULT ''
OPTIONS(description='IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country_2 for its own use (/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country_2 (I)'),
SEITENBEHANG_FG INTEGER
OPTIONS(description='Seitenbehang bezieht sich auf die Artikel_2, die an den Regalsseiten aufgehängt werden.\n            Wenn das Flag auf 1 gesetzt ist, wird der Artikel_2 als  Seitenbehang definiert, unabhängig von der Filiale.'),
HERKUNFTSKENNZEICHEN_DE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon HKD. Siegel zur Kennzeichnung Herkunftskennzeichen Deutschland.'),
LEATHER_WORKING_GROUP_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon LWG. Siegel zur Kennzeichnung Leather Working Group.'),
SILPHIE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon SIL. Siegel zur Kennzeichnung Silphie.'),
RAINFOREST_BANANE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RAB. Siegel zur Kennzeichnung Rainforest Allliance (RFA) - Multiple ingredient Banane.'),
RAINFOREST_SCHWARZTEE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RAS. Siegel zur Kennzeichnung Rainforest Allliance (RFA) - Multiple ingredient Schwarzteeextrakt.'),
RAINFOREST_ORANGE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RAO. Siegel zur Kennzeichnung Rainforest Allliance (RFA) - Multiple ingredient Orange.'),
RAINFOREST_HASELNUSS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RAH. Siegel zur Kennzeichnung Rainforest Allliance - Multiple ingredient Haselnuss (RFA).'),
VLABEL_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon VLA. Siegel zur Kennzeichnung V-Label - Von Natur aus Vegan (ProVeg).'),
QMILCH_PLUS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon QMI. Siegel zur Kennzeichnung QMilch+.'),
GLOBAL_REC_STD_FILLING_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GRF. Siegel zur Kennzeichnung Global Recycled Standard (GRS) - filling.'),
ORGANIC_CON_STD_BLENDED_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon OCB. Siegel zur Kennzeichnung Organic Content Standard (OCS) - blended.'),
GOTS_MADE_WITH_ORGANIC_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon GOM. Siegel zur Kennzeichnung Global Organic Textile Standard (GOTS) - Made with organic in conversion.'),
RCS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RCS. Siegel zur Kennzeichnung Recycled Claim Standard (RCS).'),
RCS_BLENDED_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RCB. Siegel zur Kennzeichnung Recycled Claim Standard (RCS) - blended.'),
RCS_FILLING_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RCF. Siegel zur Kennzeichnung Recycled Claim Standard (RCS) - filling.'),
RCS_FILLING_BLENDED_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RFB. Siegel zur Kennzeichnung Recycled Claim Standard (RCS) - filling blended.'),
MADE_IN_GERMANY_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon HID. Siegel zur Kennzeichnung Hergestellt in Deutschland - Made in Germany.'),
CYCLOS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon CYC. Siegel zur Kennzeichnung Cyclos.'),
RMC_BLUE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RMC. Siegel zur Kennzeichnung Recycled Material Certification (RMC) blue - marine plastics intercepted in waterways, recyceled material PFI certified.'),
RWS_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon RWS. Siegel zur Kennzeichnung Responsible Wool Standard (RWS) certified.'),
SUSTAINABLE_RICE_PLATFORM_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon SRP. Siegel zur Kennzeichnung SRP - Sustainable Rice Platform'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Artikel_2');
