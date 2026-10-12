--==============================================================
-- Table: rohertrag_kalk_wup_art_mo_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohertrag_kalk_wup_art_mo_sum
   generated from Powerdesigner on Mittwoch, 4. August 2021 14:32:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rohertrag_kalk_wup_art_mo_sum (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
berichtstyp_id STRING(1) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
basismenge_einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Alternative Mengenheinheit für den Artikel in Basismenge. Referenz zu der Tabelle art_umrechnung_faktor_per'),
menge_umsatz NUMERIC(18,3) OPTIONS(description='Verkaufs-Menge zum Umsatz aktionsfrei'),
menge_umsatz_a NUMERIC(18,3) OPTIONS(description='Verkaufs-Menge zum Umsatz aus Aktion'),
p1_umsatz NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Verkaufs-Umsatz aktionsfrei'),
p1_umsatz_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Verkaufs-Umsatz aus Aktion'),
p2_we NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Wareneinsatz aktionsfrei'),
p2_we_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Wareneinsatz aus Aktion'),
p3_spanne NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Umsatzspanne aktionsfrei'),
p3_spanne_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Umsatzspanne aus Aktion'),
p4_erg_flw NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Erg. Fleischwerke aktionsfrei'),
p4_erg_flw_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Erg. Fleischwerke aus Aktion'),
p5_pr_aend_eh NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Preisänderungen Einzelhandel aktionsfrei'),
p5_pr_aend_eh_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Preisänderungen Einzelhandel aus Aktion'),
p6_spanne_bas NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Basisspanne aktionsfrei'),
p6_spanne_bas_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Basisspanne aus Aktion'),
p7_verkalk_bonus NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='verkalkulierbarer Bonus aktionsfrei'),
p7_verkalk_bonus_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='verkalkulierbarer Bonus aus Aktion'),
p8_bonus_verguetungen NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Bonus / Vergütungen (kalk.) aktionsfrei'),
p8_bonus_verguetungen_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Bonus / Vergütungen (kalk.) aus Aktion'),
p9_aktions_pv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Aktions-PV (+) aktionsfrei'),
p9_aktions_pv_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Aktions-PV (+) aus Aktion'),
p10_restanten_pv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Restanten-PV (+) aktionsfrei'),
p10_restanten_pv_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Restanten-PV (+) aus Aktion'),
p11_pv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Preisveränderung aktionsfrei'),
p11_pv_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Preisveränderung aus Aktion'),
p12_ek_aktionsrabatt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='EK-Aktionsrabatt (-) aktionsfrei'),
p12_ek_aktionsrabatt_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='EK-Aktionsrabatt (-) aus Aktion'),
p13_kalkulation_abteilung NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation Abteilung aktionsfrei'),
p13_kalkulation_abteilung_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation Abteilung aus Aktion'),
p14_wkz NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='WKZ aktionsfrei'),
p14_wkz_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='WKZ aus Aktion'),
p15_eak NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='EAK aktionsfrei'),
p15_eak_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='EAK aus Aktion'),
p16_verguetungen_vorjahre NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Vergütungen Vorjahre aktionsfrei'),
p16_verguetungen_vorjahre_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Vergütungen Vorjahre aus Aktion'),
p17_verguetungen_spanne NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Vergütungen a. d. Spanne aktionsfrei'),
p17_verguetungen_spanne_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Vergütungen a. d. Spanne aus Aktion'),
p18_ertrag_export NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Ertrag aus Export aktionsfrei'),
p18_ertrag_export_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Ertrag aus Export aus Aktion'),
p19_kalkulation_rest NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation Rest aktionsfrei'),
p19_kalkulation_rest_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation Rest aus Aktion'),
p20_kalkulation NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation aktionsfrei'),
p20_kalkulation_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation aus Aktion'),
p21_aktions_pv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Aktions-PV aktionsfrei'),
p21_aktions_pv_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Aktions-PV aus Aktion'),
p22_restanten_pv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Restanten-PV aktionsfrei'),
p22_restanten_pv_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Restanten-PV aus Aktion'),
p23_pv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Preisveränderung aktionsfrei'),
p23_pv_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Preisveränderung aus Aktion'),
p24_ek_aktionsrabatt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='EK-Aktionsrabatt aktionsfrei'),
p24_ek_aktionsrabatt_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='EK-Aktionsrabatt aus Aktion'),
p25_kalkulation_nach_pv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation nach PV aktionsfrei'),
p25_kalkulation_nach_pv_a NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kalkulation nach PV aus Aktion'),
p26_preisabschriften_vt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Preisabschriften VT'),
p27_restantenverwertung NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Restantenverwertung'),
p28_totalabschrift_vt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschriften VT'),
p29_totalabschrift_eink_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschriften Eink. EK'),
p30_totalabschrift_log_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschrift Log. EK'),
p31_totalabschriften NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschriften'),
p32_sonst_totalabschriften_vt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Sonst. Totalabschriften Eink.'),
p33_sonst_totalabschriften_ein NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Sonst. Totalabschriften Eink.'),
p34_sonst_totalabschriften_log NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Sonst. Totalabschriften Log.'),
p35_sonst_totalabschriften NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Sonst. Totalabschriften'),
p36_erloese_erstatt_totalabsch NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Erlöse Erstattungen Totalabschriften'),
p37_abschriften NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Abschriften'),
p38_inventurdiff_geb_vt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdiffernzen geb. VT'),
p38_a_invdiff_totalabsch NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenz Totalabschriften'),
p39_inventurdiff_abgr_vt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenzen Abgr. VT'),
p40_inventurdiff_vt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdiifferenzen VT'),
p41_invdiff_geb_log_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenz geb. Log. EK'),
p42_invdiff_abgr_log_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenz Abgr. Log. EK'),
p43_invdiff_log NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenzen Log.'),
p44_inventurdifferenzen NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenzen'),
p45_preisabschrift_vt_vk_netto NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Preisabschriften Vertrieb VK netto'),
p46_restantenverwertung_vk_net NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Restantenverwertung VK netto'),
p47_totalabschrift_vt_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschriften Vertrieb EK'),
p48_totalabschrift_ek_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschriften Einkauf EK'),
p49_totalabschrift_log_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschriften Logistik EK'),
p50_totalabschriften_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Totalabschriften EK'),
p51_sonst_totalabschrift_vt_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Sonst. Totalabschriften Vertrieb EK'),
p52_sonst_totalabschrift_ek_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Sonst. Totalabschriften Einkauf EK'),
p53_sonst_totalabschrif_log_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Sonst. Totalabschriften Logistik EK'),
p54_sonstige_abschriften_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Sonstige Abschriften EK'),
p55_erloese_erstatt_totalabscr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Erlöse Erstattungen Totalabschriften'),
p56_abschriften_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Abschriften EK'),
p57_invdiff_gebucht_vt_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Inventurdifferenzen gebucht Vertrieb EK'),
p57_a_invdiff_totalabsch_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Inventurdifferenz Totalabschriften Einkauf'),
p58_invdiff_abgr_vt_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenzen Abgrenzung VT EK'),
p59_invdiff_vertrieb_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenzen Vertrieb EK'),
p60_invdiff_gebucht_logist_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Inventurdifferenzen gebucht Logistik EK'),
p61_invdiff_vertrieb_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventurdifferenzen Vertrieb EK'),
p62_invdiff_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventuredifferenzen EK'),
p63_warenverluste_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Warenverluste EK'),
p64_warenverluste_vk_netto_pos NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Warenverluste VK netto positiv'),
p65_ueberleitung_vkn_zu_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Überleitung VKn zu EK'),
p66_bewertungskorrektur_bestan NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Bewertungskorrektur Bestand'),
p67_uebrige_bestanteile NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='übrige Bestandteile'),
p68_nicht_klaerbare_diff_guv NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Nicht klärbare Differenzen GuV'),
p69_sonstiger_rohertrag NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Sonstiger Rohertrag'),
p70_rohertrag NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Rohertrag'),
menge_umsatz_plan NUMERIC(18,3)
OPTIONS(description='Planwert (manuell hochgeladen) zu Verkaufs-Menge zum Umsatz aktionsfrei'),
menge_umsatz_a_plan NUMERIC(18,3)
OPTIONS(description='Planwert (manuell hochgeladen) zu Verkaufs-Menge zum Umsatz aus Aktion'),
p1_umsatz_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Verkaufs-Umsatz aktionsfrei'),
p1_umsatz_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Verkaufs-Umsatz aus Aktion'),
p2_we_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Wareneinsatz aktionsfrei'),
p2_we_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Wareneinsatz aus Aktion'),
p3_spanne_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Umsatzspanne aktionsfrei'),
p3_spanne_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Umsatzspanne aus Aktion'),
p4_erg_flw_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Erg. Fleischwerke aktionsfrei'),
p4_erg_flw_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Erg. Fleischwerke aus Aktion'),
p5_pr_aend_eh_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisänderungen Einzelhandel aktionsfrei'),
p5_pr_aend_eh_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisänderungen Einzelhandel aus Aktion'),
p6_spanne_bas_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Basisspanne aktionsfrei'),
p6_spanne_bas_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Basisspanne aus Aktion'),
p7_verkalk_bonus_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu verkalkulierbarer Bonus aktionsfrei'),
p7_verkalk_bonus_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu verkalkulierbarer Bonus aus Aktion'),
p8_bonus_verguetungen_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Bonus / Vergütungen (kalk.) aktionsfrei'),
p8_bonus_verguetungen_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Bonus / Vergütungen (kalk.) aus Aktion'),
p9_aktions_pv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Aktions-PV (+) aktionsfrei'),
p9_aktions_pv_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Aktions-PV (+) aus Aktion'),
p10_restanten_pv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Restanten-PV (+) aktionsfrei'),
p10_restanten_pv_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Restanten-PV (+) aus Aktion'),
p11_pv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisveränderung aktionsfrei'),
p11_pv_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisveränderung aus Aktion'),
p12_ek_aktionsrabatt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu EK-Aktionsrabatt (-) aktionsfrei'),
p12_ek_aktionsrabatt_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu EK-Aktionsrabatt (-) aus Aktion'),
p13_kalkulation_abteilung_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation Abteilung aktionsfrei'),
p13_kalkulation_abteilung_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation Abteilung aus Aktion'),
p14_wkz_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu WKZ aktionsfrei'),
p14_wkz_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu WKZ aus Aktion'),
p15_eak_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu EAK aktionsfrei'),
p15_eak_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu EAK aus Aktion'),
p16_verguetungen_vorjahre_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Vergütungen Vorjahre aktionsfrei'),
p16_verguetungen_vorjahre_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Vergütungen Vorjahre aus Aktion'),
p17_verguetungen_spanne_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Vergütungen a. d. Spanne aktionsfrei'),
p17_verguetungen_spanne_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Vergütungen a. d. Spanne aus Aktion'),
p18_ertrag_export_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Ertrag aus Export aktionsfrei'),
p18_ertrag_export_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Ertrag aus Export aus Aktion'),
p19_kalkulation_rest_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation Rest aktionsfrei'),
p19_kalkulation_rest_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation Rest aus Aktion'),
p20_kalkulation_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation aktionsfrei'),
p20_kalkulation_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation aus Aktion'),
p21_aktions_pv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Aktions-PV aktionsfrei'),
p21_aktions_pv_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Aktions-PV aus Aktion'),
p22_restanten_pv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Restanten-PV aktionsfrei'),
p22_restanten_pv_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Restanten-PV aus Aktion'),
p23_pv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisveränderung aktionsfrei'),
p23_pv_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisveränderung aus Aktion'),
p24_ek_aktionsrabatt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu EK-Aktionsrabatt aktionsfrei'),
p24_ek_aktionsrabatt_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu EK-Aktionsrabatt aus Aktion'),
p25_kalkulation_nach_pv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation nach PV aktionsfrei'),
p25_kalkulation_nach_pv_a_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kalkulation nach PV aus Aktion'),
p26_preisabschriften_vt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisabschriften VT'),
p27_restantenverwertung_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Restantenverwertung'),
p28_totalabschrift_vt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschriften VT'),
p29_totalabschrift_eink_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschriften Eink. EK'),
p30_totalabschrift_log_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschrift Log. EK'),
p31_totalabschriften_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschriften'),
p32_sonst_totalabschriften_vt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonst. Totalabschriften Eink.'),
p33_sonst_totalabschriften_ein_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonst. Totalabschriften Eink.'),
p34_sonst_totalabschriften_log_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonst. Totalabschriften Log.'),
p35_sonst_totalabschriften_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonst. Totalabschriften'),
p36_erloese_erstatt_totalabsch_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Erlöse Erstattungen Totalabschriften'),
p37_abschriften_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Abschriften'),
p38_inventurdiff_geb_vt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdiffernzen geb. VT'),
p38_a_invdiff_totalabsch_plan NUMERIC(18,2)
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenz Totalabschriften'),
p39_inventurdiff_abgr_vt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen Abgr. VT'),
p40_inventurdiff_vt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdiifferenzen VT'),
p41_invdiff_geb_log_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenz geb. Log. EK'),
p42_invdiff_abgr_log_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenz Abgr. Log. EK'),
p43_invdiff_log_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen Log.'),
p44_inventurdifferenzen_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen'),
p45_preisabschrift_vt_vk_netto_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Preisabschriften Vertrieb VK netto'),
p46_restantenverwertung_vk_net_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Restantenverwertung VK netto'),
p47_totalabschrift_vt_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschriften Vertrieb EK'),
p48_totalabschrift_ek_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschriften Einkauf EK'),
p49_totalabschrift_log_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschriften Logistik EK'),
p50_totalabschriften_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Totalabschriften EK'),
p51_sonst_totalabschrift_vt_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonst. Totalabschriften Vertrieb EK'),
p52_sonst_totalabschrift_ek_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonst. Totalabschriften Einkauf EK'),
p53_sonst_totalabschrif_log_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonst. Totalabschriften Logistik EK'),
p54_sonstige_abschriften_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonstige Abschriften EK'),
p55_erloese_erstatt_totalabscr_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Erlöse Erstattungen Totalabschriften'),
p56_abschriften_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Abschriften EK'),
p57_invdiff_gebucht_vt_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen gebucht Vertrieb EK'),
p57_a_invdiff_totalabsch_ek_plan NUMERIC(18,2)
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenz Totalabschriften Einkauf'),
p58_invdiff_abgr_vt_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen Abgrenzung VT EK'),
p59_invdiff_vertrieb_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen Vertrieb EK'),
p60_invdiff_gebucht_logist_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen gebucht Logistik EK'),
p61_invdiff_vertrieb_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventurdifferenzen Vertrieb EK'),
p62_invdiff_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventuredifferenzen EK'),
p63_warenverluste_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Warenverluste EK'),
p64_warenverluste_vk_netto_pos_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Warenverluste VK netto positiv'),
p65_ueberleitung_vkn_zu_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Überleitung VKn zu EK'),
p66_bewertungskorrektur_bestan_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Bewertungskorrektur Bestand'),
p67_uebrige_bestanteile_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu übrige Bestandteile'),
p68_nicht_klaerbare_diff_guv_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Nicht klärbare Differenzen GuV'),
p69_sonstiger_rohertrag_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sonstiger Rohertrag'),
p70_rohertrag_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Rohertrag'),
mep_we_differenz_plan NUMERIC(18,2) OPTIONS(description='Planwert (manuell hochgeladen) zu MEP / WE-Differenz'),
spannenkorrektur_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Spannenkorrektur'),
finanzbonus_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Finanzbonus'),
jahresbonus_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Jahresbonus'),
steigergungsbonus_de_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Steigergungsbonus (DE)'),
markantbonus_de_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Markantbonus (DE)'),
steigerungs_markantbonus_kmo_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Steigerungs- / Markantbonus (KMO)'),
steigerungs_markantbonus_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Steigerungs- / Markantbonus'),
verbesserungspot_aus_nachm_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Verbesserungspot. aus Nachm.'),
verg_a_d_sp_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Verg. a. d. Sp. (DE: lfd. KJ, KMO: GJ)'),
abgrenzung_verguetungen_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Abgrenzung Vergütungen'),
verguetungen_vorjahre_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Vergütungen Vorjahre'),
apm_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Planwert (manuell hochgeladen) zu APM'),
umsatz_export_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Umsatz Export'),
wareneinsatz_export_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Wareneinsatz Export'),
inventur_diebstahl_ta_geb_vt_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Inventur Diebstahl TA geb. VT'),
ueberleitung_vkn_zu_ek_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Überleitung VKn zu EK'),
bewertungskorrekturen_bestand_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Bewertungskorrekturen Bestand'),
mwst_auf_totalabschr_inv_diff_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu MwSt. auf Totalabschr. / Inv.diff.'),
sondersteuer_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Sondersteuer'),
steuern_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Planwert (manuell hochgeladen) zu Steuern'),
kursdifferenzen_ware_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Kursdifferenzen Ware'),
wertberichtigung_lieferantenboni_plan NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Planwert (manuell hochgeladen) zu Wertberichtigung Lieferantenboni'),
menge_umsatz_hr NUMERIC(18,3)
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Verkaufs-Menge zum Umsatz aktionsfrei'),
menge_umsatz_a_hr NUMERIC(18,3)
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Verkaufs-Menge zum Umsatz aus Aktion'),
p1_umsatz_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Verkaufs-Umsatz aktionsfrei'),
p1_umsatz_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Verkaufs-Umsatz aus Aktion'),
p2_we_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Wareneinsatz aktionsfrei'),
p2_we_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Wareneinsatz aus Aktion'),
p3_spanne_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Umsatzspanne aktionsfrei'),
p3_spanne_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Umsatzspanne aus Aktion'),
p4_erg_flw_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Erg. Fleischwerke aktionsfrei'),
p4_erg_flw_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Erg. Fleischwerke aus Aktion'),
p5_pr_aend_eh_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisänderungen Einzelhandel aktionsfrei'),
p5_pr_aend_eh_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisänderungen Einzelhandel aus Aktion'),
p6_spanne_bas_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Basisspanne aktionsfrei'),
p6_spanne_bas_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Basisspanne aus Aktion'),
p7_verkalk_bonus_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu verkalkulierbarer Bonus aktionsfrei'),
p7_verkalk_bonus_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu verkalkulierbarer Bonus aus Aktion'),
p8_bonus_verguetungen_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Bonus / Vergütungen (kalk.) aktionsfrei'),
p8_bonus_verguetungen_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Bonus / Vergütungen (kalk.) aus Aktion'),
p9_aktions_pv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Aktions-PV (+) aktionsfrei'),
p9_aktions_pv_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Aktions-PV (+) aus Aktion'),
p10_restanten_pv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Restanten-PV (+) aktionsfrei'),
p10_restanten_pv_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Restanten-PV (+) aus Aktion'),
p11_pv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisveränderung aktionsfrei'),
p11_pv_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisveränderung aus Aktion'),
p12_ek_aktionsrabatt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu EK-Aktionsrabatt (-) aktionsfrei'),
p12_ek_aktionsrabatt_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu EK-Aktionsrabatt (-) aus Aktion'),
p13_kalkulation_abteilung_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation Abteilung aktionsfrei'),
p13_kalkulation_abteilung_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation Abteilung aus Aktion'),
p14_wkz_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu WKZ aktionsfrei'),
p14_wkz_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu WKZ aus Aktion'),
p15_eak_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu EAK aktionsfrei'),
p15_eak_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu EAK aus Aktion'),
p16_verguetungen_vorjahre_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Vergütungen Vorjahre aktionsfrei'),
p16_verguetungen_vorjahre_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Vergütungen Vorjahre aus Aktion'),
p17_verguetungen_spanne_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Vergütungen a. d. Spanne aktionsfrei'),
p17_verguetungen_spanne_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Vergütungen a. d. Spanne aus Aktion'),
p18_ertrag_export_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Ertrag aus Export aktionsfrei'),
p18_ertrag_export_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Ertrag aus Export aus Aktion'),
p19_kalkulation_rest_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation Rest aktionsfrei'),
p19_kalkulation_rest_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation Rest aus Aktion'),
p20_kalkulation_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation aktionsfrei'),
p20_kalkulation_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation aus Aktion'),
p21_aktions_pv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Aktions-PV aktionsfrei'),
p21_aktions_pv_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Aktions-PV aus Aktion'),
p22_restanten_pv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Restanten-PV aktionsfrei'),
p22_restanten_pv_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Restanten-PV aus Aktion'),
p23_pv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisveränderung aktionsfrei'),
p23_pv_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisveränderung aus Aktion'),
p24_ek_aktionsrabatt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu EK-Aktionsrabatt aktionsfrei'),
p24_ek_aktionsrabatt_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu EK-Aktionsrabatt aus Aktion'),
p25_kalkulation_nach_pv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation nach PV aktionsfrei'),
p25_kalkulation_nach_pv_a_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kalkulation nach PV aus Aktion'),
p26_preisabschriften_vt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisabschriften VT'),
p27_restantenverwertung_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Restantenverwertung'),
p28_totalabschrift_vt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschriften VT'),
p29_totalabschrift_eink_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschriften Eink. EK'),
p30_totalabschrift_log_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschrift Log. EK'),
p31_totalabschriften_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschriften'),
p32_sonst_totalabschriften_vt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonst. Totalabschriften Eink.'),
p33_sonst_totalabschriften_ein_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonst. Totalabschriften Eink.'),
p34_sonst_totalabschriften_log_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonst. Totalabschriften Log.'),
p35_sonst_totalabschriften_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonst. Totalabschriften'),
p36_erloese_erstatt_totalabsch_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Erlöse Erstattungen Totalabschriften'),
p37_abschriften_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Abschriften'),
p38_inventurdiff_geb_vt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdiffernzen geb. VT'),
p38_a_invdiff_totalabsch_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenz Totalabschriften'),
p39_inventurdiff_abgr_vt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen Abgr. VT'),
p40_inventurdiff_vt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdiifferenzen VT'),
p41_invdiff_geb_log_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenz geb. Log. EK'),
p42_invdiff_abgr_log_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenz Abgr. Log. EK'),
p43_invdiff_log_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen Log.'),
p44_inventurdifferenzen_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen'),
p45_preisabschrift_vt_vk_netto_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Preisabschriften Vertrieb VK netto'),
p46_restantenverwertung_vk_net_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Restantenverwertung VK netto'),
p47_totalabschrift_vt_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschriften Vertrieb EK'),
p48_totalabschrift_ek_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschriften Einkauf EK'),
p49_totalabschrift_log_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschriften Logistik EK'),
p50_totalabschriften_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Totalabschriften EK'),
p51_sonst_totalabschrift_vt_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonst. Totalabschriften Vertrieb EK'),
p52_sonst_totalabschrift_ek_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonst. Totalabschriften Einkauf EK'),
p53_sonst_totalabschrif_log_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonst. Totalabschriften Logistik EK'),
p54_sonstige_abschriften_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonstige Abschriften EK'),
p55_erloese_erstatt_totalabscr_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Erlöse Erstattungen Totalabschriften'),
p56_abschriften_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Abschriften EK'),
p57_invdiff_gebucht_vt_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen gebucht Vertrieb EK'),
p57_a_invdiff_totalabsch_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenz Totalabschriften Einkauf'),
p58_invdiff_abgr_vt_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen Abgrenzung VT EK'),
p59_invdiff_vertrieb_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen Vertrieb EK'),
p60_invdiff_gebucht_logist_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen gebucht Logistik EK'),
p61_invdiff_vertrieb_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventurdifferenzen Vertrieb EK'),
p62_invdiff_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventuredifferenzen EK'),
p63_warenverluste_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Warenverluste EK'),
p64_warenverluste_vk_netto_pos_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Warenverluste VK netto positiv'),
p65_ueberleitung_vkn_zu_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Überleitung VKn zu EK'),
p66_bewertungskorrektur_bestan_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Bewertungskorrektur Bestand'),
p67_uebrige_bestanteile_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu übrige Bestandteile'),
p68_nicht_klaerbare_diff_guv_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Nicht klärbare Differenzen GuV'),
p69_sonstiger_rohertrag_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sonstiger Rohertrag'),
p70_rohertrag_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Rohertrag'),
mep_we_differenz_hr NUMERIC(18,2) OPTIONS(description='Hochrechnung (manuell hochgeladen) zu MEP / WE-Differenz'),
spannenkorrektur_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Spannenkorrektur'),
finanzbonus_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Finanzbonus'),
jahresbonus_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Jahresbonus'),
steigergungsbonus_de_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Steigergungsbonus (DE)'),
markantbonus_de_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Markantbonus (DE)'),
steigerungs_markantbonus_kmo_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Steigerungs- / Markantbonus (KMO)'),
steigerungs_markantbonus_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Steigerungs- / Markantbonus'),
verbesserungspot_aus_nachm_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Verbesserungspot. aus Nachm.'),
verg_a_d_sp_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Verg. a. d. Sp. (DE: lfd. KJ, KMO: GJ)'),
abgrenzung_verguetungen_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Abgrenzung Vergütungen'),
verguetungen_vorjahre_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Vergütungen Vorjahre'),
apm_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Hochrechnung (manuell hochgeladen) zu APM'),
umsatz_export_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Umsatz Export'),
wareneinsatz_export_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Wareneinsatz Export'),
inventur_diebstahl_ta_geb_vt_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Inventur Diebstahl TA geb. VT'),
ueberleitung_vkn_zu_ek_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Überleitung VKn zu EK'),
bewertungskorrekturen_bestand_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Bewertungskorrekturen Bestand'),
mwst_auf_totalabschr_inv_diff_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu MwSt. auf Totalabschr. / Inv.diff.'),
sondersteuer_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Sondersteuer'),
steuern_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Steuern'),
kursdifferenzen_ware_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Kursdifferenzen Ware'),
wertberichtigung_lieferantenboni_hr NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Hochrechnung (manuell hochgeladen) zu Wertberichtigung Lieferantenboni'),
menge_umsatz_kor NUMERIC(18,3)
OPTIONS(description='Korrekturposition (manuell) zu Verkaufs-Menge zum Umsatz aktionsfrei'),
menge_umsatz_a_kor NUMERIC(18,3)
OPTIONS(description='Korrekturposition (manuell) zu Verkaufs-Menge zum Umsatz aus Aktion'),
p1_umsatz_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Verkaufs-Umsatz aktionsfrei'),
p1_umsatz_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Verkaufs-Umsatz aus Aktion'),
p2_we_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Wareneinsatz aktionsfrei'),
p2_we_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Wareneinsatz aus Aktion'),
p3_spanne_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Umsatzspanne aktionsfrei'),
p3_spanne_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Umsatzspanne aus Aktion'),
p4_erg_flw_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Erg. Fleischwerke aktionsfrei'),
p4_erg_flw_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Erg. Fleischwerke aus Aktion'),
p5_pr_aend_eh_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisänderungen Einzelhandel aktionsfrei'),
p5_pr_aend_eh_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisänderungen Einzelhandel aus Aktion'),
p6_spanne_bas_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Basisspanne aktionsfrei'),
p6_spanne_bas_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Basisspanne aus Aktion'),
p7_verkalk_bonus_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu verkalkulierbarer Bonus aktionsfrei'),
p7_verkalk_bonus_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu verkalkulierbarer Bonus aus Aktion'),
p8_bonus_verguetungen_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Bonus / Vergütungen (kalk.) aktionsfrei'),
p8_bonus_verguetungen_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Bonus / Vergütungen (kalk.) aus Aktion'),
p9_aktions_pv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Aktions-PV (+) aktionsfrei'),
p9_aktions_pv_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Aktions-PV (+) aus Aktion'),
p10_restanten_pv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Restanten-PV (+) aktionsfrei'),
p10_restanten_pv_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Restanten-PV (+) aus Aktion'),
p11_pv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisveränderung aktionsfrei'),
p11_pv_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisveränderung aus Aktion'),
p12_ek_aktionsrabatt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu EK-Aktionsrabatt (-) aktionsfrei'),
p12_ek_aktionsrabatt_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu EK-Aktionsrabatt (-) aus Aktion'),
p13_kalkulation_abteilung_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation Abteilung aktionsfrei'),
p13_kalkulation_abteilung_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation Abteilung aus Aktion'),
p14_wkz_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Korrekturposition (manuell) zu WKZ aktionsfrei'),
p14_wkz_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Korrekturposition (manuell) zu WKZ aus Aktion'),
p15_eak_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Korrekturposition (manuell) zu EAK aktionsfrei'),
p15_eak_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Korrekturposition (manuell) zu EAK aus Aktion'),
p16_verguetungen_vorjahre_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Vergütungen Vorjahre aktionsfrei'),
p16_verguetungen_vorjahre_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Vergütungen Vorjahre aus Aktion'),
p17_verguetungen_spanne_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Vergütungen a. d. Spanne aktionsfrei'),
p17_verguetungen_spanne_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Vergütungen a. d. Spanne aus Aktion'),
p18_ertrag_export_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Ertrag aus Export aktionsfrei'),
p18_ertrag_export_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Ertrag aus Export aus Aktion'),
p19_kalkulation_rest_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation Rest aktionsfrei'),
p19_kalkulation_rest_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation Rest aus Aktion'),
p20_kalkulation_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation aktionsfrei'),
p20_kalkulation_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation aus Aktion'),
p21_aktions_pv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Aktions-PV aktionsfrei'),
p21_aktions_pv_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Aktions-PV aus Aktion'),
p22_restanten_pv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Restanten-PV aktionsfrei'),
p22_restanten_pv_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Restanten-PV aus Aktion'),
p23_pv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisveränderung aktionsfrei'),
p23_pv_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisveränderung aus Aktion'),
p24_ek_aktionsrabatt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu EK-Aktionsrabatt aktionsfrei'),
p24_ek_aktionsrabatt_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu EK-Aktionsrabatt aus Aktion'),
p25_kalkulation_nach_pv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation nach PV aktionsfrei'),
p25_kalkulation_nach_pv_a_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Kalkulation nach PV aus Aktion'),
p26_preisabschriften_vt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisabschriften VT'),
p27_restantenverwertung_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Restantenverwertung'),
p28_totalabschrift_vt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschriften VT'),
p29_totalabschrift_eink_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschriften Eink. EK'),
p30_totalabschrift_log_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschrift Log. EK'),
p31_totalabschriften_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschriften'),
p32_sonst_totalabschriften_vt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonst. Totalabschriften Eink.'),
p33_sonst_totalabschriften_ein_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonst. Totalabschriften Eink.'),
p34_sonst_totalabschriften_log_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonst. Totalabschriften Log.'),
p35_sonst_totalabschriften_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonst. Totalabschriften'),
p36_erloese_erstatt_totalabsch_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Erlöse Erstattungen Totalabschriften'),
p37_abschriften_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Abschriften'),
p38_inventurdiff_geb_vt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdiffernzen geb. VT'),
p38_a_invdiff_totalabsch_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenz Totalabschriften'),
p39_inventurdiff_abgr_vt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen Abgr. VT'),
p40_inventurdiff_vt_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdiifferenzen VT'),
p41_invdiff_geb_log_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenz geb. Log. EK'),
p42_invdiff_abgr_log_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenz Abgr. Log. EK'),
p43_invdiff_log_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen Log.'),
p44_inventurdifferenzen_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen'),
p45_preisabschrift_vt_vk_netto_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Preisabschriften Vertrieb VK netto'),
p46_restantenverwertung_vk_net_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Restantenverwertung VK netto'),
p47_totalabschrift_vt_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschriften Vertrieb EK'),
p48_totalabschrift_ek_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschriften Einkauf EK'),
p49_totalabschrift_log_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschriften Logistik EK'),
p50_totalabschriften_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Totalabschriften EK'),
p51_sonst_totalabschrift_vt_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonst. Totalabschriften Vertrieb EK'),
p52_sonst_totalabschrift_ek_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonst. Totalabschriften Einkauf EK'),
p53_sonst_totalabschrif_log_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonst. Totalabschriften Logistik EK'),
p54_sonstige_abschriften_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonstige Abschriften EK'),
p55_erloese_erstatt_totalabscr_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Erlöse Erstattungen Totalabschriften'),
p56_abschriften_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Abschriften EK'),
p57_invdiff_gebucht_vt_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen gebucht Vertrieb EK'),
p57_a_invdiff_totalabsch_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenz Totalabschriften Einkauf'),
p58_invdiff_abgr_vt_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen Abgrenzung VT EK'),
p59_invdiff_vertrieb_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen Vertrieb EK'),
p60_invdiff_gebucht_logist_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen gebucht Logistik EK'),
p61_invdiff_vertrieb_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventurdifferenzen Vertrieb EK'),
p62_invdiff_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Inventuredifferenzen EK'),
p63_warenverluste_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Warenverluste EK'),
p64_warenverluste_vk_netto_pos_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Warenverluste VK netto positiv'),
p65_ueberleitung_vkn_zu_ek_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Überleitung VKn zu EK'),
p66_bewertungskorrektur_bestan_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Bewertungskorrektur Bestand'),
p67_uebrige_bestanteile_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu übrige Bestandteile'),
p68_nicht_klaerbare_diff_guv_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Nicht klärbare Differenzen GuV'),
p69_sonstiger_rohertrag_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Korrekturposition (manuell) zu Sonstiger Rohertrag'),
p70_rohertrag_kor NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Korrekturposition (manuell) zu Rohertrag'),
mep_we_differenz NUMERIC(18,2) OPTIONS(description='MEP / WE-Differenz'),
spannenkorrektur NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Spannenkorrektur'),
finanzbonus NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Finanzbonus'),
jahresbonus NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Jahresbonus'),
steigergungsbonus_de NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Steigergungsbonus (DE)'),
markantbonus_de NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Markantbonus (DE)'),
steigerungs_markantbonus_kmo NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Steigerungs- / Markantbonus (KMO)'),
steigerungs_markantbonus NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Steigerungs- / Markantbonus'),
verbesserungspot_aus_nachm NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Verbesserungspot. aus Nachm.'),
verg_a_d_sp NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Verg. a. d. Sp. (DE: lfd. KJ, KMO: GJ)'),
abgrenzung_verguetungen NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Abgrenzung Vergütungen'),
verguetungen_vorjahre NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Vergütungen Vorjahre'),
apm NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='APM'),
umsatz_export NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Umsatz Export'),
wareneinsatz_export NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Wareneinsatz Export'),
inventur_diebstahl_ta_geb_vt NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Inventur Diebstahl TA geb. VT'),
ueberleitung_vkn_zu_ek NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Überleitung VKn zu EK'),
bewertungskorrekturen_bestand NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Bewertungskorrekturen Bestand'),
mwst_auf_totalabschr_inv_diff NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='MwSt. auf Totalabschr. / Inv.diff.'),
sondersteuer NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Sondersteuer'),
steuern NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Steuern'),
kursdifferenzen_ware NUMERIC(18,2) DEFAULT 0.00 NOT NULL OPTIONS(description='Kursdifferenzen Ware'),
wertberichtigung_lieferantenboni NUMERIC(18,2) DEFAULT 0.00 NOT NULL
OPTIONS(description='Kursdifferenzen WareWertberichtigung Lieferantenboni'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY kjmo
OPTIONS(description='REB - Monatsaggregat zum Rohertrag (Zusammenfassung der Kennzahlen aus den Tabellen rohertrag_kalk_wup_art_zu_per + planung_rohertrag...+ hochrech_rohertrag..+ anreich_rohertrag...+ korrektur_rohertrag)');