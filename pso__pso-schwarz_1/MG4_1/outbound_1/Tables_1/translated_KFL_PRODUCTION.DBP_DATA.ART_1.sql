CREATE OR REPLACE TABLE kfl_production_dbp_data.art_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
mwst_id INTEGER NOT NULL OPTIONS(description='Mehrwertsteuer - Kennzeichen.'),
land_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Herkunftsland.'),
region_id INTEGER NOT NULL
OPTIONS(description='Region_1 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_1 gebildet.'),
kl_art_id INTEGER NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.'),
dat_von DATE NOT NULL
OPTIONS(description='Datum, ab welchem der Artikel_1 im System angelegt wurde. Bei Artikeln älter als DWH: 1900-01-01. (SAP Quellfeld: MARA.ERSDA))'),
dat_bis DATE NOT NULL
OPTIONS(description='Reorganisations (Lösch)-Datum des Artikels in SAP. Bei nicht gelöschten Artikeln:\'9999-12-31\'.'),
dat_angelegt DATE
OPTIONS(description='Datum, an dem der Artikel_1 angelegt wurde. Für Artikel_1, die bereits vor SAP vorhanden waren wurde das Anlagedatum aus dem Vorsystem übernommen. Für Artikel_1, die erst nach der SAP Einführung angelegt wurden entsptricht das Anlagedatum dem Erstelldatum in SAP (dat_von). (SAP Quellfeld: MARA.DATAB)'),
loesch_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Löschkennzeichen für logische Löschung, kann folgende Ausprägungen annehmen G: Gesperrt, R: Räumen, L: Gelöscht, blank: kein Löschkennzeichen.'),
bio_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Biosiegel Flag EU, es gibt auch noch ein bio_fg_cz (Kürzel: BIO).'),
wg_art_fg INTEGER NOT NULL
OPTIONS(description='Warengruppen-Artikel_1 (wird auch als Sumpfartikel oder Warengruppen-Erfassungsartikel bezeichnet). Wird benutzt, wenn sich ein Artikel_1 nicht eindeutig einer Artikelnummer zuordnen lässt. 0 = Nein; 1 = Ja.'),
posten_id STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_1, die nicht ständig im Sortiment sind (für KMO ist es ein posten_fg, wenn das Posten-KZ in SAP wird eine_1 1 gesetzt).'),
lead_id INTEGER NOT NULL OPTIONS(description='Leaderkennzeichen.'),
leist_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelkennzeichen Leistungsstark Food.'),
discount_id INTEGER NOT NULL
OPTIONS(description='Schlüssel des Discount Artikelkennzeichens - numerischer Wert (0 = kein Discountartikel, oder Kennzeichen zwischen 1 und 7).'),
verpart_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Verpackungsart, z.Bsp DS.'),
esb_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kalkulationskennzeichen Nonfood. Inhalt = E für Einstiegspreislage, B für Blickpunktartikel. S = Strategieartikel. Wird nicht mehr benutzt.'),
aldi_id INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, in welcher / welchen Vertriebsschiene(n) ein Artikel_1 das Aldi Kennzeichen besitzt, kann sich auf eine_1 oder mehrere Vertriebsschienen beziehen.'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer-ID: Diese ID ist nicht mit der Mitarbeiter-ID identisch. So gesehen eine_1 überflüssige ID.'),
gewart_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Gewichtsartikel: ist bei Gewichtsartikeln = KG, bei Stückartikeln = ST.'),
eigenmarke_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Classik Artikel_1).'),
mutter_wb_id INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
display_id INTEGER OPTIONS(description='Schlüssel des Artikelkennzeichens Display (0 = kein Displayartikel).'),
best_menge_einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Bestellmengeneinheit. Diese Mengeneinheit wird standardmäßig bei Bestellungen verwendet.'),
loeschvorm_fg INTEGER DEFAULT - 1
OPTIONS(description='Kennzeichen, dass Artikel_1 zum Löschen vorgemerkt wird. 1 entspricht Ja.'),
mhd_zeitraum INTEGER
OPTIONS(description='Dieses Feld gibt den standardmässigen Mindesthaltbarkeitszeitraum für diesen Artikel_1 in Tagen an.'),
artikelart_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kategorisierung in Artikelarten (z. B. Batterien, Leergut, Sport-Schuhe). Referenz zu der Tabelle l_artikelart.'),
basismenge_einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Alternative Mengenheinheit für den Artikel_1 in Basismenge. Referenz zu der Tabelle art_umrechnung_faktor_per.'),
faktor_nettoinhalt NUMERIC(18,3)
OPTIONS(description='Umrechnungsfaktor von Stück in Nettogewicht (wenn die Basismengeneinheit in Stück ausgewiesen ist). Aus SAP MARA.INHAL.'),
mutter_vk_id INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleichen Verkaufspreisen ist hier die Artikel_ID des führenden Artikels (auch: Mutterartikel) hinterlegt.'),
lager_prozent INTEGER DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird.'),
temperatur_id STRING(2) COLLATE 'und:ci' OPTIONS(description='Kennzeichen für den Temperaturbereich, z.Bsp. 3.'),
duales_system_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Duales System-Gebühren (0 = nein, 1 = ja).'),
grs_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag für Gemeinsames Rücknahme System (für Batterien) -Gebühren (0=nein, 1 = ja).'),
ear_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag für Elektro-Altgeräte-Register-Gebühren (0 = nein, 1 = ja).'),
gema_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag für GEMA (Gesellschaft für musikalische Aufführungs- und mechanische Vervielfältigungsrechte) -relevante Artikel_1 (0 = nein, 1 = ja).'),
lactose_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Lactosefreie Artikel.'),
gluten_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Gluten-freie Artikel.'),
diaet_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag kennzeichnet Diät-Artikel.'),
artikeltyp_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Klassifizierung des Artikels, z.Bsp. Displayartikel.'),
verkauf_sperre_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet für den Verkkauf gesperrte Artikel. Nur in DE SAP vorhanden.'),
einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Maßeinheit aus mara.inhme. Referenz zur Tabelle l_einh_1 (t006a).'),
platz_relevant_fg INTEGER NOT NULL
OPTIONS(description='Flag zur Kennzeichnung platzierungsrelevanter Artikel_1 aus maw1.zzekplatz.'),
bitrex_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BEX\'. Bitrex.'),
blauer_engel_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BLA\'. Blauer Engel.'),
dachlogo_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DAC\'. Dachlogo.'),
dolphin_safe_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DTU\'. Delfinsicherer Thunfischfang (Safe).'),
euro_blume_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'EBL\'. Europäisches Umweltzeichen Euro-Blume.'),
ecocert_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'ECO\'. Ecocert Flag (Bio-Zertifizierung).'),
eier_bh_fh_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'EIB\'. Eier aus Bodenhaltung (BH) / Freilandhaltung (FH).'),
fair_trade_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FAT\'. Fair Trade.'),
fos_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FOS\'. Friend of the sea (FOS).'),
fsc_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FSC\'. Forest Stewardship Council (FSC).'),
gap_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GAP\'. Gemeinsame Agrapolitik (GAP).'),
gots_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GOT\'. Siegel zur Kennzeichnung Global Organic Textile Standard (GOTS) - Organic in conversion, min 95%.'),
halal_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'HAL\'. Halal.'),
kaninchen_bh_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'KAB\'. SAP Icon\'KAB\'. Kaninchen aus Bodenhaltung (BH).'),
keimling_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'KEI\'. Keimling.'),
kein_stopf_rupf_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'KST\'. Keine Stopfmast / kein Lebendrupf.'),
msc_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'MSC\'. Marine Stewardship Council (MSC).'),
kon_nat_kosmetik_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'NAK\'. Kontrollierte Naturkosmetik.'),
natrue_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'NAT\'. NaTrue Naturkosmetik-Siegel.'),
naturland_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'NLA\'. Naturland.'),
ohne_gentechnik_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'OGE\'. Ohne Gentechnik.'),
oeko_tex_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'OTS\'. Textiles Vertrauen - Öko-Tex Standard 100.'),
pefc_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'PEF\'. Programme for the Endorsement of Forest Certification Schemes (PEFC), Nachhaltigkeit in der Waldwirtschaft.'),
rainforest_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RAL\'. Rainforest Alliance.'),
sustain_clean_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'SCC\'. Sustainable-cleaning-charter (SCC) Logo_1 für nachhaltiges Waschen und Reinigen.'),
tierschutz_gepr_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Tierschutz geprüft Flag.'),
aquagap_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Aqua Gap Flag für nachhaltige Fischereiwirtschaft aus der Quelle zekstn (Kürzel: AQUAGAP).'),
saison_id STRING(10) COLLATE 'und:ci' OPTIONS(description='ID der Saison aus saiso, z.Bsp 9.'),
jugendschutz_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Jugendschutz Kennzeichen aus maw1.zzek_ekpom. Enthält eine_1 Altersangabe (z.Bsp. 12,16,18).'),
follow_fish_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: FollowFish (Kürzel: FOLLOW_FISH).'),
gepa_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: GEPA Fair Trade (Kürzel: GEPA).'),
green_brands_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Green Brands Flag.'),
nature_and_respect_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Nature & Respect Flag für artgerechte Tierhaltung (Kürzel: NATURE_AND_RESPECT).'),
utz_certified_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: UTZ Certified Flag für Kaffeeprodukte (Kürzel: UTZ_CERTIFIED).'),
oeko_tex_std_100_plus_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Ökotex Standard 100 (Kürzel: OEKO_TEX_STD_100_PLUS).'),
vier_pfoten_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Vier Pfoten (Kürzel: VIER_PFOTEN).'),
asc_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'ASC\'. Aquaculture Stewardship Council (ASC) für nachhaltige Fischzucht aus Aquakultur.'),
bap_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BAP\'. Best Aquaculture Practices (BAP).'),
rspo_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: Roundtable on Sustainable Palm Oil (RSPO).'),
kl_art_id_alt INTEGER OPTIONS(description='Vorgänger-Artikelnummer aus der Spalte bismt.'),
tagesartikel_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Tagesartikel-Flag aus maw1.zzek_kztgar. Tagesartikel müssen innerhalb eines Tages verkauft werden.'),
kein_abverkauf_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kein-Abverkauf-Flag aus maw1.zzek_nsale. Wenn = 1, darf der Artikel_1 nicht abverkauft werden.'),
div_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DIV\'. Diverse Logos.'),
fcp_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FCP\'. FT cocoa.'),
fw_saison_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='ID für das Fleischwerk-Artikel_1-Kennzeichen Saison aus dem Quellfeld zzfwarblock mit Referenz zu zfwprartik bzw.l_fw_saison.'),
fw_wk_system_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='ID des Fleischwerk WK Artikelkennzeichens aus zzfwbeschaf, z.Bsp. Innereien.'),
fw_wk_discount_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung fw_wk_discount aus dem Quellfeld zfwqualita.'),
fw_wk_national_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung fw_wk_national aus dem Quellfeld zfwwarenar.'),
fw_we_hammer_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung Fleischwerk WE-Hammer aus dem Quellfeld zfwveredel.'),
fw_we_artikel_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung Fleischwerk WE-Artikel_1 aus dem Quellfeld zfwprzuber.'),
fw_reserve_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='ID für die Kennzeichnung Artikel_1 Fleischwerk Reserve aus dem Quellfeld zfwbestvor.'),
vegan_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'VGN\'. Vegan. Wird für Lebensmittel gesetzt wenn sie vegan sind.'),
vegan_kaufland_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'VGK\'. Siegel zur Kennzeichnung Vegan (Kaufland internes vegan Zeichen). Wird für Beauty Artikel_1 der Kaufland Eigenmarke gesetzt wenn sie vegan sind.'),
vegetarisch_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'VGT\'. Vegetarisch.'),
psf_id INTEGER OPTIONS(description='ID des Produktschaufensters aus zzek_showcase, z.Bsp. 1.'),
menge_haus INTEGER OPTIONS(description='Haushaltsübliche Menge aus zzek_hausmg.'),
smgrp INTEGER OPTIONS(description='Sortimentsmanagergruppe aus zzek_smgrp. Referenziert auf die Tabelle zek_1(t024_1).'),
tierwohl_kz STRING(2) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen Tierwohl, z.Bsp. sw für Schwein, aus dem Quellfeld zzek_tierwohl. Keine Lookup vorhanden.'),
gtin_id INTEGER NOT NULL
OPTIONS(description='Pro Artikel_1 ist eine_1 Haupt-GTIN vorhanden. Diese wird für KMO hier abgelegt. Für DE wird -1 eingetragen.'),
bio_fg_cz INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Bio Flag CZ. Aus der Quelle SAP zek_sustain_set.pez.'),
verhandler_id STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='MAW1.ZZEK_ZEKKLMAVERH - Verhandler KL-Marke.'),
zek_vat_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer-ID: Diese ID ist nicht mit der Mitarbeiter-ID identisch.'),
inhalt_menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Maßeinheit für das Feld Inhalt_Menge.'),
inhalt_menge NUMERIC(18,3) OPTIONS(description='Inhaltsmenge (abhängig von der Maßeinheit (inhalt_menge_einh_id).'),
kein_vk_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag kein Verkaufsartikel (1 = kein Verkaufsartikel).'),
gots_organ_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GOO\'. Global Organic Textile Standard (GOTS) - made with min 95%+ organic materials.'),
gots_proz_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GOP\'. Global Organic Textile Standard (GOTS) - made with 70-94% organic materials.'),
gu_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'PDO\'. Geschützte Ursprungsbezeichnung (GU).'),
gga_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'PGI\'. Geschützte Geografische Angabe (GGA).'),
fsc_verpackung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'PVP\'. FSC Verpackung (Kürzel: PVP).'),
rainf_kakao_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RKA\'. Rainforest Kakao.'),
rainf_kaffee_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RKF\'. Rainforest Kaffee.'),
gts_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'TSG\'. Garantiert traditionelle Spezialität (GTS).'),
blauer_engel_abbaubar_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BAB\'. Blauer Engel abbaubar.'),
blauer_engel_altpapier_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BAL\'. Blauer Engel Altpapier.'),
bio_bw_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BBW\'. Bio BW.'),
bioland_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BIL\'. Bioland.'),
blauer_engel_kunststoff_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BKU\'. Blauer Engel Kunststoff.'),
blauer_engel_mehrweg_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BME\'. Blauer Engel Mehrweg.'),
blauer_engel_wirkstoff_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BOW\'. Blauer Engel Wirkstoff.'),
blauer_engel_wasser2_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BSA\'. Blauer Engel Wasser 2.'),
blauer_engel_solarbetrieb_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BSO\'. Blauer Engel Solarbetrieb.'),
blauer_engel_ungebleicht_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BUG\'. Blauer Engel Ungebleicht.'),
dtb_einstieg_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DTE\'. Deutscher Tierschutzbund (DTB) Einstiegsstufe.'),
dtb_premium_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DTP\'. Deutscher Tierschutzbund (DTB) Premiumstufe.'),
freilandhaltung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FDH\'. Freilandhaltung.'),
neuland_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'NEL\'. Neuland.'),
qs_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'QSP\'. QS-Prüfzeichen für Lebensmittel.'),
weidehaltung_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'WDH\'. Weidehaltung.'),
tierwohl_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'ITW\'. Initiative Tierwohl.'),
marktfrisch_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'MAF\'. Marktfrisch.'),
yellowprint_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Gelbes Regaletikett.'),
ipn_id INTEGER OPTIONS(description='Internationale Produktnummer zum Artikel_1 (MAW1.ZZEK_IPN).'),
posten_kz_sap STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_1, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert) (z.B PN = Posten, SP = sortimentsnahe Posten, etc.).'),
demeter_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag für Demeter-Artikel.'),
kaufempfehlung_fg INTEGER OPTIONS(description='Flag Kaufempfehlung (0 = nein, 1 = ja).'),
neu_sort_fg INTEGER OPTIONS(description='Kennzeichen neu im Sortiment (0 = nein, 1 = ja).'),
discountart_id STRING(2) COLLATE 'und:ci' OPTIONS(description='ID Discountart.'),
positionstyp_grp_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL
OPTIONS(description='ID allgemeine Positionstypengruppe.'),
artikelrolle_id STRING(2) COLLATE 'und:ci' OPTIONS(description='Artikelrolle international ID.'),
unsere_region_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_1 ist aus der Region_1 (BG).'),
lets_bbq_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_1 hat das Saisonkennzeichen\'Let\'s Barbeque\'.'),
verpackungseinsparung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Verpackungsmaterial wurde beim Artikel_1 gespart (Kürzel:BEV).'),
cz_norm_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_1 nach der tschech.Zunftnorm.'),
kl_exclusiv_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Exclusiv bei Kaufland.'),
zum_fasten_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Artikel_1 zum Fasten geeignet.'),
kl_besonderes_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Besonderes bei Kaufland.'),
stahlhaltung_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Haltungsform 1_Stallhaltung.'),
stahlhaltung_plus_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Haltungsform 2_Stallhaltung Plus.'),
aussenklima_haltung_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Haltungsform 3_Außenklima.'),
premium_haltung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Haltungsform 4_Premium. Seit Mitte 2024 wurde die Premium-Haltungsform in zwei geteilt. Diese stellt die Auslauf/Weide Form dar.'),
bio_haltung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'HF5\'. Siegel zur Kennzeichnung Initiative Tierwohl - Haltungsform 5 (Bio).'),
machen_macht_unterschied_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Artikelslogan: K-CSR_Machen macht den Untersch.'),
premium_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Saison Kennzeichen: Premium.'),
qafp_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='QAFP - quality control sign.'),
qudal_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='QUDAL - Top quality medal.'),
regionale_lebensmittel_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RPO\'. Regional food (CZ).'),
startup_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Startup Artikel_1 - startup by Kaufland.'),
togo_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Saisonkennzeichen: ToGo.'),
ohne_microplastik_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Rezeptur ohne Mikroplastik.'),
grk_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Grüner Knopf.'),
ppl_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Produkt Polski.'),
rpp_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Online Click & Collect.'),
rsc_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Online Supermercato.'),
daa_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='DAAB.'),
okt_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Ohne Kükentöten (OKT).'),
mutter_1_n_id INTEGER OPTIONS(description='Neu Uebergang Art_id aus 1:N BQ Findung DE Logik.'),
sustain_concat STRING(100) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Alle Nachhaltigkeitslogos konkatiniert, Quelle ZEK_SUSTAIN_SET.'),
int_art_id INTEGER OPTIONS(description='Internationale Artikelnummer aus ZSM.'),
tage_uebernachtungen INTEGER OPTIONS(description='Tage Übernachtungen im Zentrallager.'),
ggn_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: GGN zertifiziertes Farming (Kürzel GGN).'),
oug_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kennzeichen Obst und Gemüse.'),
nettogew NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Nettogewicht des Artikels. Feld NTGEW.'),
wsi_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Wasser sparen.'),
vbe_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Veganblume.'),
fte_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='fTrace'),
kni_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Klimaneutral.'),
nhi_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: Nationales Länderherz.'),
vac_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Vegan ohne V-Label.'),
gbs_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Ohne Verwendung von GVO hergestellt..'),
ek_marken_id INTEGER OPTIONS(description='ID des Markennamens im Einkauf.'),
nat_bio_siegel_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'NBS\'. Ein Bio-Siegel ist ein Güte- und Prüfsiegel, mit welchem Erzeugnisse aus ökologischem Landbau gekennzeichnet werden.'),
fair_sugar_prog_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FSP\'. Fairtrade Sugar Program (FSI).'),
fair_cotton_prog_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FCO\'. Fairtrade Cotton Program (FSI).'),
sustainable_cleaning_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'SCK\'. Das Sustainable Cleaning Siegel kennzeichnet Putz- und Reinigungsprodukte, die hohe Standards für Umweltsicherheit erfüllen, Abfall minimieren und klare und transparente Informationen über die nachhaltigere Verwendung liefern.\n            www.cleanright.eu'),
rainforest_alliance_tee_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RAT\'. Das Rainforest Alliance Certified (RFA) Siegel wird für Kakao, Kaffee, Tee, Zitrusfrüchte oder Bananen vergeben, die unter Berücksichtigung ökologischer, sozialer und ökonomischer Anforderungen angebaut werden.\n             www.rainforest-alliance.org'),
heumilch_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'HEM\'. Heumilch.'),
fairmast_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FAM\'. Fairmast.'),
kat_kontrolliert_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'KDK\'. Das KAT-Kennzeichnungssystem gibt detailliert Auskunft über die Herkunft von Eiern und schafft so größtmögliche Transparenz.\n            www.kat.eu '),
kdk_kalb_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'KDI\'. Kalbfleisch aus der Heimat, das unter den hohen Erzeugungs- und Tierwohlstandards der Kontrollgemeinschaft Deutsches Kalbfleisch produziert wird.\n            www.deutscheskalbfleisch.de'),
organic_cont_std_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'OCS\'. Der Organic Content Standard (OCS) ermöglicht es, den genauen Anteil an ökologischem Material in einer Ware zu erfassen und durch die Produktionskette weiterzuverfolgen. Er besagt, dass Bio-Baumwolle eingesetzt wurde.\n            www.textileexchange.org'),
global_rec_std_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GRS\'. Global Recycled Standard (GRS).'),
global_rec_std_50_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R50\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_55_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R55\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_60_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R60\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_65_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R65\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_70_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R70\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_75_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R75\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_80_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R80\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_85_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R85\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
global_rec_std_90_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'R90\'. Produkte, die nach dem Global Recycled Standard (GRS) zertifiziert sind, enthalten recyceltes Material. Das GRS-Logo_1 darf verwendet werden, wenn Produkte zu mindestens 50 Prozent aus recyceltem Material bestehen.\n            www.textileexchange.org '),
institut_heidger_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'IHE\'. Institut Heidger.'),
cotton_mia_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CMA\'. Cotton made in Africa (CmiA) ist ein international anerkannter Standard für nachhaltige Baumwolle aus Afrika. Im Fokus stehen der Umweltschutz sowie bessere Arbeits- und Lebensbedingungen für Kleinbauern und Arbeiter in den Entkörnungsbetrieben.\n            www.cottonmadeinafrica.org'),
downpass_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DPA\'. Down Pass.'),
junghahnaufzucht_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'JHI\'. Junghahnenaufzucht.'),
bord_bia_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BOB\'. Bord Bia.'),
gss_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GSS\'. GS.'),
tuv_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'TUV\'. TÜV.'),
ces_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CES\'. CE.'),
aklasa_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'AKL\'. aKlasa.'),
i_know_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'VCO\'. I know what I eat.'),
czech_guild_std_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CCI\'. ČCN (Czech Guild Standard).'),
czech_food_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CPO\'. Czech food.'),
organic_cotton_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'OCO\'. Organic Cotton.'),
sephora_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'SAN\'. sephora-approved-natural-product-seal.'),
green_globe_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GGL\'. Green-globe.'),
certificare_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CHI\'. CERTIFICARE-HACCP.'),
bg_state_std_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BST\'. Bulgarische staatliche Standards.'),
ayvar_quality_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GQU\'. Geprüfte Qualität für Ayvar.'),
creekstone_farm_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CFA\'. Creekstone Farms.'),
milchprodukte_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'MSI\'. Milchprodukte Siegel.'),
stara_planina_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'SPL\'. Stara Planina geprüfter Standard.'),
bgi_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BGI\'. Ich wähle bulgarisch.'),
bgs_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BGS\'. Wählen Sie bulgarisch.'),
brot_qual_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GQB\'. geprüfte Qualität für Brot.'),
dti_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DTI\'. d test.'),
mfd_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'MFD\'. MF today.'),
consumer_choice_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'VSP\'. Consumer Choice.'),
flash_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'BLE\'. Flash.'),
cz_appetizer_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CCH\'. Czech appetizer.'),
children_appetizer_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'DCH\'. Children\'s appetizer.'),
natulon_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'NAC\'. Das YKK NATULON® Siegel garantiert, dass Teile des Reißverschlusses aus recyceltem Material bestehen.\n            www.ykkdigitalshowroom.com/en/ '),
laenderherz_5d_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'FUD\'. Länderherz_5D.'),
ohne_gentechnik_nicht_vlog_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'OGO\'. Eine_1 Ausprägung für „ohne Gentechnik“ gekennzeichnete Lebensmittel. Artikel_1 ohne Auditierung der VLOG (Verband Lebensmittel ohne Gentechnik).'),
traditional_certified_product_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'TCP\'. Siegel zur Kennzeichnung traditionell zertifizierter Produkte.'),
iwt_id STRING(1) DEFAULT ''
OPTIONS(description='IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country_1 for its own use (\'\'/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country_1 (I)'),
seitenbehang_fg INTEGER
OPTIONS(description='Seitenbehang bezieht sich auf die Artikel_1, die an den Regalsseiten aufgehängt werden.\n            Wenn das Flag auf 1 gesetzt ist, wird der Artikel_1 als\' Seitenbehang\' definiert, unabhängig von der Filiale.'),
herkunftskennzeichen_de_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'HKD\'. Siegel zur Kennzeichnung Herkunftskennzeichen Deutschland.'),
leather_working_group_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'LWG\'. Siegel zur Kennzeichnung Leather Working Group.'),
silphie_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'SIL\'. Siegel zur Kennzeichnung Silphie.'),
rainforest_banane_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RAB\'. Siegel zur Kennzeichnung Rainforest Allliance (RFA) - Multiple ingredient Banane.'),
rainforest_schwarztee_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RAS\'. Siegel zur Kennzeichnung Rainforest Allliance (RFA) - Multiple ingredient Schwarzteeextrakt.'),
rainforest_orange_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RAO\'. Siegel zur Kennzeichnung Rainforest Allliance (RFA) - Multiple ingredient Orange.'),
rainforest_haselnuss_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RAH\'. Siegel zur Kennzeichnung Rainforest Allliance - Multiple ingredient Haselnuss (RFA).'),
vlabel_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'VLA\'. Siegel zur Kennzeichnung V-Label - Von Natur aus Vegan (ProVeg).'),
qmilch_plus_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'QMI\'. Siegel zur Kennzeichnung QMilch+.'),
global_rec_std_filling_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GRF\'. Siegel zur Kennzeichnung Global Recycled Standard (GRS) - filling.'),
organic_con_std_blended_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'OCB\'. Siegel zur Kennzeichnung Organic Content Standard (OCS) - blended.'),
gots_made_with_organic_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'GOM\'. Siegel zur Kennzeichnung Global Organic Textile Standard (GOTS) - Made with organic in conversion.'),
rcs_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RCS\'. Siegel zur Kennzeichnung Recycled Claim Standard (RCS).'),
rcs_blended_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RCB\'. Siegel zur Kennzeichnung Recycled Claim Standard (RCS) - blended.'),
rcs_filling_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RCF\'. Siegel zur Kennzeichnung Recycled Claim Standard (RCS) - filling.'),
rcs_filling_blended_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RFB\'. Siegel zur Kennzeichnung Recycled Claim Standard (RCS) - filling blended.'),
made_in_germany_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'HID\'. Siegel zur Kennzeichnung Hergestellt in Deutschland - Made in Germany.'),
cyclos_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'CYC\'. Siegel zur Kennzeichnung Cyclos.'),
rmc_blue_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RMC\'. Siegel zur Kennzeichnung Recycled Material Certification (RMC) blue - marine plastics intercepted in waterways, recyceled material PFI certified.'),
rws_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'RWS\'. Siegel zur Kennzeichnung Responsible Wool Standard (RWS) certified.'),
sustainable_rice_platform_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachhaltigkeitslogo: SAP Icon\'SRP\'. Siegel zur Kennzeichnung SRP - Sustainable Rice Platform'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Artikel_1');