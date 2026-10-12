CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.zb_dim_projekt (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
psp_nr STRING(20) NOT NULL OPTIONS(description='PSP-Nummer des Projektes.'),
psp_status_id INTEGER NOT NULL OPTIONS(description='ID des PSP-Status.'),
psp_status_bez_de STRING(200) OPTIONS(description='Bezeichnung des PSP-Status in Deutsch'),
psp_status_bez_en STRING(200) OPTIONS(description='Bezeichnung des PSP-Status in Englisch'),
projekt_status_id INTEGER NOT NULL OPTIONS(description='ID des Projektstatus.'),
projekt_status_bez_de STRING(200) OPTIONS(description='Bezeichnung des Projektstatus in Deutsch'),
projekt_status_bez_en STRING(200) OPTIONS(description='Bezeichnung des Projektstatus in Englisch'),
projektart_cd STRING(20) NOT NULL OPTIONS(description='Alphanumerischer Coder der Projektart'),
projektart_bez_de STRING(200) OPTIONS(description='Bezeichnung der Projektart in Deutsch'),
projektart_bez_en STRING(200) OPTIONS(description='Bezeichnung der Projektart in Englisch'),
projekttyp_id INTEGER NOT NULL OPTIONS(description='ID des Projekttyps'),
projekttyp_bez_de STRING(200) OPTIONS(description='Bezeichnung des Projekttyps in Deutsch'),
projekttyp_bez_en STRING(200) OPTIONS(description='Bezeichnung des Projekttyps in Englisch'),
projektphase_id INTEGER NOT NULL OPTIONS(description='ID der Projektphase'),
projektphase_bez_de STRING(200) OPTIONS(description='Bezeichnung der Projektphase in Deutsch'),
projektphase_bez_en STRING(200) OPTIONS(description='Bezeichnung der Projektphase in Englisch'),
projektphase_status_id INTEGER NOT NULL OPTIONS(description='ID des Status der Projektphase.'),
projektphase_status_bez_de STRING(200) OPTIONS(description='Bezeichnung des Status der Projektphase in Deutsch'),
projektphase_status_bez_en STRING(200) OPTIONS(description='Bezeichnung des Status der Projektphase in Englisch'),
projekt_name STRING(100) NOT NULL OPTIONS(description='Name des Projektes.'),
projekt_land_id STRING(2) NOT NULL
OPTIONS(description='Alphanumerischer Code des Landes in dem das Projekt stattfindet.'),
projekt_region_name STRING(200)
OPTIONS(description='Name der Region innerhalb des Landes in dem das Projekt stattfindet. Entsprich nicht den politischen Regionen, bspw. Bundesländer.'),
projekt_plz_nr STRING(40) OPTIONS(description='Nummer der Postleitzahl in dem das Projekt statfindet.'),
projekt_standort_name STRING(200) NOT NULL
OPTIONS(description='Name des Standortes an dem das Projekt stattfindet. Sollte in den meisten Fällen dem Namen der Stadt / der Gemeinde entsprechen.'),
projekt_stadtteil_name STRING(200) OPTIONS(description='Name des Stadtteils in dem das Projekt stattfindet.'),
projekt_strasse_name STRING(200) NOT NULL OPTIONS(description='Name der Straße an dem das Projekt stattfindet.'),
projekt_haus_nr STRING(40) OPTIONS(description='Hausnummer an dem das Projekt in der Straße stattfindet.'),
projekt_bemerkung_txt STRING(500) OPTIONS(description='Freitext für projektbezogene Bemerkungen.'),
immobilienentwickler_name STRING(100)
OPTIONS(description='Verantwortlicher Mitarbeitername für die Rolle des Immobilienentwicklers im Projekt.'),
objektplaner_name STRING(100)
OPTIONS(description='Verantwortlicher Mitarbeitername für die Rolle des Objektplaners im Projekt.'),
bauprojektmanager_name STRING(100)
OPTIONS(description='Verantwortlicher Mitarbeitername für die Rolle des Bauprojektmanagers im Projekt.'),
vertrieb_mitarbeiter_name STRING(100)
OPTIONS(description='Verantwortlicher Mitarbeitername für den Vertrieb im Projekt.'),
dat_storno DATE OPTIONS(description='Datum des Storno sollte ein Projekt nachträglich storniert werden.'),
dat_a1_budget DATE OPTIONS(description='Datum des aktuellen A1 Budgets des Projektes'),
a1_budget_version_name STRING(100) OPTIONS(description='Name der aktuellen Version des A1 Budgets des Projektes'),
dat_a2_budget DATE OPTIONS(description='Datum des aktuellen A2 Budgets des Projektes'),
a2_budget_version_name STRING(100) OPTIONS(description='Name der aktuellen A2 Version des Budgets des Projektes'),
dat_aktuelle_kostenprognose DATE OPTIONS(description='Datum der aktuellsten Kostenprognose des Projektes'),
aktuelle_kostenprognose_version_nr STRING(100)
OPTIONS(description='Nummer der aktuellen Version der Kostenprognose des Projektes'),
dat_objekt_freigegeben DATE
OPTIONS(description='Datum für den Termin Objekt Freigegeben. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
objekt_freigegeben_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Objekt freigegeben\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_standortsicherung_durchgefuehrt DATE
OPTIONS(description='Datum für den Termin Standortsicherung durchgeführt. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
standortsicherung_durchgefuehrt_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Standortsicherung durchgefuehrt\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_baurecht_geschaffen DATE
OPTIONS(description='Datum für den Termin Baurecht geschaffen. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
baurecht_geschaffen_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Baurecht geschaffen\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_baubeginn DATE
OPTIONS(description='Datum für den Termin Baubeginn. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
baubeginn_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Baubeginn\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_beginn_kaelte DATE
OPTIONS(description='Datum für den Termin Beginn Kälte. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
beginn_kaelte_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Beginn Kaelte\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_beginn_einrichtung DATE
OPTIONS(description='Datum für den Termin Beginn Einrichtung. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
beginn_einrichtung_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Baubeginn Einrichtung\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_eroeffnung DATE
OPTIONS(description='Datum für den Termin Eröffnung / Inbetriebnahme. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
eroeffnung_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Eroeffnung\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_projekt_abgeschlossen DATE
OPTIONS(description='Datum für den Termin Projekt abgeschlossen. Wenn das IST-Datum nicht vorhanden ist, handelt es sich um das Prognosedatum,'),
projekt_abgeschlossen_dat_typ_cd STRING(10)
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Projekt abgeschlossen\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
gj_plan_eroeffnung INTEGER OPTIONS(description='Geplantes Geschäftsjahr für die Eröffnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr) NOT ENFORCED
) OPTIONS(description='Dimension für Projeke aus den Zentralbereichen.');