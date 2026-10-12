--==============================================================
-- Table: cpr_projekt_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_projekt_per
   generated from Powerdesigner on Mittwoch, 15. Dezember 2021 17:59:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_projekt_per (
projekt_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID des Projekts'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
cpr_ext_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='eindeutige Projektnummer pro Projekt und Sprache'),
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit'),
cpr_kategorie_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Projektkategorie ID, z.Bsp. 1'),
projekt_anlass_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Projektanlasses oder Veranlassers, z.Bsp. Vertrieb'),
projektart_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Projektart, z.Bsp. EX'),
dat_freigabe DATE OPTIONS(description='Datum der Freigabe'),
expansion_merkmal STRING(10) COLLATE 'und:ci' OPTIONS(description='Angebotsnummer'),
cpr_auftraggeber_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Auftraggebers (Nachname ist gepflegt)'),
expansion_auftrag_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Kombination aus Buchstaben und Ziffern, z.Bsp. EA556'),
cpr_filialtyp_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichnung, z.Bsp. HH, KL'),
gj BIGNUMERIC(38,0) OPTIONS(description='tatsächliches Geschäftsjahr'),
investor_eigenobj STRING(10) COLLATE 'und:ci' OPTIONS(description='Angabe zum Eigentumsverhältnis, z.Bsp. Miete'),
kbl_nl_bez STRING(30) COLLATE 'und:ci'
OPTIONS(description='Name bzw. Ort der zuständigen Niederlassung, z.Bsp. Dortmund'),
cpr_vs STRING(10) COLLATE 'und:ci' OPTIONS(description='Angabe zum Vertriebskonzept, z.Bsp. SA oder DNP'),
massnahme_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Kennzeichnung einer Massnahme, z.Bsp. KB'),
land_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Land, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
leiter_eroeff_abn_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Kann den Namen des Leiters der Eröffnungsabnahme enthalten'),
leiter_rohger_abn_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Kann den Namen des Leiters der Rohgerüstabnahme enthalten'),
wup_id BIGNUMERIC(38,0)
OPTIONS(description='Kann eine Marktnummer enthalten. Diese Nummer kann vorläufig und im Marktstamm nicht enthalten sein'),
markt_typ_ea STRING(20) COLLATE 'und:ci' OPTIONS(description='Markt_typ laut Expansionsauftrag, z.Bsp. 5A'),
markt_typ_vp STRING(20) COLLATE 'und:ci' OPTIONS(description='Markt_typ laut Vorplanungz.Bsp. 3B'),
cpr_standort STRING(40) COLLATE 'und:ci'
OPTIONS(description='Kann den Namen eines Standortes enthalten, z.Bsp. Heilbronn'),
objekt_planer_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Kannn den Namen des Pbjektplaners oder dessen Kürzel enthalten, z.Bsp. EF'),
cpr_str STRING(80) COLLATE 'und:ci'
OPTIONS(description='Kann Angaben zur Strasse und Hausnummer des Projekts enthalten'),
plan_verantw_kz STRING(1) COLLATE 'und:ci' OPTIONS(description='Kennzeichnung des Planungsverantwortlichen'),
pl_be_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Hier kann der Name des Projektleiters BE hinterlegt sein'),
pl_vertrieb_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Projektleiters Vertrieb'),
cpr_plz STRING(10) COLLATE 'und:ci' OPTIONS(description='Hier kann eine Postleitzahl zum Projekt hinterlegt sein'),
betrag_proj_kosten NUMERIC(18,3) DEFAULT 0.000 OPTIONS(description='Betrag der Projektkosten'),
region_id BIGNUMERIC(38,0)
OPTIONS(description='Region eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region gebildet.'),
cpr_systemstatus1_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend'),
cpr_systemstatus2_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend'),
cpr_systemstatus3_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend'),
pl_elektro STRING(40) COLLATE 'und:ci' OPTIONS(description='Projektleiter Elektro'),
pl_hls STRING(40) COLLATE 'und:ci' OPTIONS(description='Projektleiter HLS'),
cpr_vw STRING(20) COLLATE 'und:ci'
OPTIONS(description='Angabe zurVertriebsregion in cProjects (DWH: Vertriebsweg) z.B. Nord, Ost, West etc'),
cpr_bl_projekt_bau_einr_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Kann den Namen des Bereichsleiters Projekt Bau Einr enthalten'),
cpr_suchfeld_id BIGNUMERIC(38,0)
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
bauleiter_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Bauleiters'),
bearbeit_ea_soa_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Bearbeiters EA/SOA'),
fach_ing_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Fachingenieurs'),
ges_grund_flaeche_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Gesamt Grundfläche Gebäude als Freitext'),
gu_ladenbau_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Nmae des Gesamtunternehmers Ladenbau'),
kaelte_lief_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Kältelieferanten'),
log_massn STRING(40) COLLATE 'und:ci' OPTIONS(description='Nummer einer Logistikmassnahme als Freitext'),
pl_einrichtung_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Projektleiters Einrichtng'),
statiker_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Statikers'),
plan_verantwortl_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des verantwortlichen Planers'),
cpr_generalunternehmer_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Kann den Namen des Generalunternehmers enthalten'),
cpr_objekt_steurer STRING(40) COLLATE 'und:ci' OPTIONS(description='Objektsteuerer Name'),
cpr_betreuer_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Name des Betreuers. Es ist Nachname,Vorname oder Anrede plus Nachname gepflegt'),
cpr_general_planer STRING(40) COLLATE 'und:ci' OPTIONS(description='Generalplaner Name'),
investor_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Kann den Namen des Investors enthalten'),
cpr_gen_ueb_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Generalübernehmer'),
cpr_gen_unt_haust_name STRING(40) COLLATE 'und:ci' OPTIONS(description='GU / Unternehmer Haustechnik'),
cpr_arch_ph_14_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Architekt Phase 1-4'),
cpr_arch_phase_58_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Architekt Phase 5-8'),
cpr_fachpl_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Fachplaner'),
cpr_fachpl_kaelt_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Fachplaner Kälte'),
cpr_fachpl_sonst_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Sonstige Planer'),
cpr_gutachter_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Gutachter'),
cpr_vermesser_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Vermesser'),
cpr_fachin_tga_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Fachingenieur TGA'),
cpr_qual_sich_bau_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Qualitätssicherung Bau'),
cpr_qual_sich_haust_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Qualitätssicherung Haustechnik'),
cpr_gj_ber BIGNUMERIC(38,0) OPTIONS(description='Geschäftsjahr BERI (Bau Einrichtung Reparatur Instandhaltung)'),
cpr_eig_proj STRING(40) COLLATE 'und:ci' OPTIONS(description='Eigenentwicklung/Projektentwickler Compress'),
cpr_gu_ausbau STRING(40) COLLATE 'und:ci' OPTIONS(description='GU / Unternehmer Ausbau Compress'),
einbau_kkv STRING(1) COLLATE 'und:ci' OPTIONS(description='Einbau Klima-Kälteverbund aus einbaukkv'),
dat_teil_oeffentl DATE OPTIONS(description='Teilöffentlichkeit Datum au zz_dpr_teiloeff'),
dat_eroeffnung DATE OPTIONS(description='Eröffnungsdatum aus zz_dpr_eroeff'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='IOS - Projekt aus der SAP - Anwendung cProjects');