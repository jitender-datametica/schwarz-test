--==============================================================
-- Table: mitarbeiterbew_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mitarbeiterbew_1
   generated from Powerdesigner on Donnerstag, 16. März 2023 11:39:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mitarbeiterbew_1 (
mitarbeiter_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige anonymisierte ID des Mitarbeiters'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresmonat, z.Bsp 201308'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK - Mandant_1 im DWH'),
abwesenheit_tage NUMERIC(9,2) NOT NULL OPTIONS(description='Abwesenheit in Kalendertagen'),
soll_stunden_monat NUMERIC(9,2) NOT NULL OPTIONS(description='Soll Stunden_1 pro Monat_1'),
abr_stunden_monat NUMERIC(9,2) NOT NULL OPTIONS(description='abgerechnete Stunden_1'),
langzeit_abwesend_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ist = 1, wenn der MA > 90 Tage abwesend ist. Redundant zur Performancesteigerung'),
neu_mitarbeiter_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ist = 1, wenn der MA < 6 Monate im Unternehmen ist. Redundant zur Performancesteigerung'),
krank_tage NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Errechnet aus der Summe der Abwesenheitsarten mit der Bedeutung "krank"'),
teilzeit_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Ist = 1, wenn der MA in Teilzeit (Beschäftigungsgrad < 100) ist und somit ein X geliefert wird.'),
hr_objekt_id INTEGER NOT NULL OPTIONS(description='Objekt ID, 8-stellige Zahl'),
ma_status_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Mitarbeiterstatus'),
geschlecht_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Geschlechts'),
tarifgebiet_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Tarifgebiets'),
shr_ma_funktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Funktionsschlüssel des Mitarbeiters aus zhr_fsl'),
tarifart_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Tarifart aus trfar, z.Bsp.\'GH\''),
unternehmens_bereich_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Unternehmensbereichs aus zhr_division, z.Bsp. 23'),
gehalts_region_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Gehaltsregion aus region_1'),
haus_kategorie_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Hauskategorie aus house_cat'),
haupt_mitarbeiter_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hauptpersonalnummer aus hpern. MA mit mehreren Personalnummern besitzen eine_1 Hauptnummer. In der Regel ist hier die mitarbeiter_id gespeichert.'),
soll_kalender_tage NUMERIC(9,2) NOT NULL OPTIONS(description='Sollarbeit in Kalendertagen aus ksoll'),
resturlaub_vj NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Resturlaub aus den Vorjahren in Tagen aus mbnum'),
resturlaub_akt_kj NUMERIC(9,2) NOT NULL OPTIONS(description='Resturlaub aus dem aktuellen Kalenderjahr in Tagen'),
anspruch_urlaub_akt_kj NUMERIC(9,2) NOT NULL OPTIONS(description='Urlaubsanspruch im aktuellen Kalenderjahrin Tagen'),
langzeit_krank_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
mutterschutz_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
beschaeftigungs_verbot_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
aushilfe_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
elternzeit_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
grundwehrdienst_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
atz_kz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Altersteilzeit Kennzeichen: 0 = kein ATZ, 1 = aktiv, 2 = passiv'),
freigestellt_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
impatriates_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
externe_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
azubi_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
ma_eintritt_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='0 = trifft nicht zu, 1 = Eintritt von intern, 2 = Eintritt von extern'),
ma_austritt_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='0 = trifft nicht zu, 1 = Austritt nach intern, 2 = Austritt nach extern'),
fluktuation_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bedeutungen: 0 = nicht ausgetreten, 1 = Fluktuation  Arbeitnehmer  2 = Fluktuation  Arbeitgeber'),
ki_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet Mitarbeiter von Kaufland International. 0 = trifft nicht zu, 1 = trifft zu'),
genommen_urlaub NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='genommener Urlaub auf den Monat_1 bezogen, errechnet aus Abwesenheiten'),
inventur_aushilfe_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
tip_austraeger_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
tip_kontrolleur_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
tip_gebietsbetreuer_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
diplomand_praktikant_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
praktikant_o_entgeld_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
expatriates_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
hinterbliebene_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
versorgungsbezieher_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='0 = trifft nicht zu, 1 = trifft zu'),
soll_arbeitstage NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Soll-Arbeitstage im Monat_1 aus dem Quellfeld asoll'),
sb_prozent BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Grad der Schwerbehinderung (Prozentsatz) aus der Quelle p0004.sbpro'),
arbeitszeit_anteil NUMERIC(9,2) OPTIONS(description='Arbeitszeit-Anteil aus der Quelle p0000,arbant'),
abwesenheit_arbeitstage_bez NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='bezahlte Abwesenheitstage in Arbeitstagen.Wird über die Lohnart 7728 ermittelt'),
abwesenheit_arbeitstage_unbez NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='unbezahlte Abwesenheitstage in Arbeitstagen.Wird über die Lohnart 7729 ermittelt'),
arb_stunden_tag NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Arbeitsstunden pro Tag_1 aus der Quelle arbst'),
krank_tage_arbeitstage NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Summierung auf MA/ Monat_1 der Krankheitstage (Arbeitstage Filter nach Abwesehentsart)'),
anz_arbeits_unfall BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Arbeitsunfälle, redundant, wird ermittelt aus Abwesenheitsart in der Tabelle ma_abwesenh_zu_per_1'),
vertragsende_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag gesetzt, wenn Datum Vertragsende < 6 Monate. Redundant. Wird ermittelt aus ma_datumsart_zu_per_1'),
untermonatlich_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Ist gesetzt bei Austritt innerhalb eines Monats. Redundant. Wird aus l_ma_status ermittelt.'),
aushilfe_nicht_gearbeitet_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Redundant. Wird über ma_lohnart_zu_per_1 ermittelt'),
abwesenheit_stunden NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Abwesenheitsstunden Mitarbeiter auf Ebene Abwesenheitsart aus SAP HCM Infotyp 2001'),
sonstige_abwesenheit_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Ist=1, wenn eine_1 Abwesenheitsart der Kategorie sonstige Abwesenheit im Abrechnungsmonat gepflegt ist.'),
pflege_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Ist=1, wenn eine_1 Abwesenheitsart der Kategorie Pflege im Abrechnungsmonat gepflegt ist.'),
krankheit_unfall_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Ist=1, wenn eine_1 Abwesenheitsart der Kategorie Krankheit oder Unfall im Abrechnungsmonat gepflegt ist.'),
langzeit_abwesenheit_tage NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Durchgängige Abwesenheitstage bis Monatsende'),
langzeit_abwesenheit_tage_kum NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Kummulierte Abwesenheitstage der Monate ohne Unterbrechung'),
langzeit_min_dat DATE OPTIONS(description='Tag_1, an dem die durchgängige Abwesenheit begonnen wurde'),
langzeit_abwesenheit_grund STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Begründung der Unterbrechung'),
stichtag_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Ist=1, wenn entsprechende Abwesenheitsart die der Stichtagslogik folgt, im Abrechnungsmonat gepflegt ist.'),
dat_letzte_abwesenheit DATE
OPTIONS(description='Datum des letzten Tages der Abwesenheit eines Mitarbeiters im entsprechenden KJ-Monat_1'),
mitarbeiter_alter BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Alter des Mitarbeiters '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kjmo, mandant_id) NOT ENFORCED
) OPTIONS(description='SHR - Bewegungsdaten der Mitarbeiter');