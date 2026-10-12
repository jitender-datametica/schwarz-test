CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_zb_dim_projekt_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), psp_nr
OPTIONS(description='PSP-Nummer des Projektes.'), psp_status_id OPTIONS(description='ID des PSP-Status.'),
psp_status_bez_de OPTIONS(description='Bezeichnung des PSP-Status_2 in Deutsch'), psp_status_bez_en
OPTIONS(description='Bezeichnung des PSP-Status_2 in Englisch'), projekt_status_id
OPTIONS(description='ID des Projektstatus.'), projekt_status_bez_de
OPTIONS(description='Bezeichnung des Projektstatus in Deutsch'), projekt_status_bez_en
OPTIONS(description='Bezeichnung des Projektstatus in Englisch'), projektart_cd
OPTIONS(description='Alphanumerischer Coder der Projektart'), projektart_bez_de
OPTIONS(description='Bezeichnung der Projektart in Deutsch'), projektart_bez_en
OPTIONS(description='Bezeichnung der Projektart in Englisch'), projekttyp_id OPTIONS(description='ID des Projekttyps'),
projekttyp_bez_de OPTIONS(description='Bezeichnung des Projekttyps in Deutsch'), projekttyp_bez_en
OPTIONS(description='Bezeichnung des Projekttyps in Englisch'), projektphase_id
OPTIONS(description='ID der Projektphase'), projektphase_bez_de
OPTIONS(description='Bezeichnung der Projektphase in Deutsch'), projektphase_bez_en
OPTIONS(description='Bezeichnung der Projektphase in Englisch'), projektphase_status_id
OPTIONS(description='ID des Status_2 der Projektphase.'), projektphase_status_bez_de
OPTIONS(description='Bezeichnung des Status_2 der Projektphase in Deutsch'), projektphase_status_bez_en
OPTIONS(description='Bezeichnung des Status_2 der Projektphase in Englisch'), projekt_name
OPTIONS(description='Name des Projektes.'), projekt_land_id
OPTIONS(description='Alphanumerischer Code des Landes in dem das Projekt stattfindet.'), projekt_region_name
OPTIONS(description='Name der Region_2 innerhalb des Landes in dem das Projekt stattfindet. Entsprich nicht den politischen Regionen, bspw. Bundesländer.'),
projekt_plz_nr OPTIONS(description='Nummer der Postleitzahl in dem das Projekt statfindet.'), projekt_standort_name
OPTIONS(description='Name des Standortes an dem das Projekt stattfindet. Sollte in den meisten Fällen dem Namen der Stadt / der Gemeinde entsprechen.'),
projekt_stadtteil_name OPTIONS(description='Name des Stadtteils in dem das Projekt stattfindet.'), projekt_strasse_name
OPTIONS(description='Name der Straße an dem das Projekt stattfindet.'), projekt_haus_nr
OPTIONS(description='Hausnummer an dem das Projekt in der Straße stattfindet.'), projekt_bemerkung_txt
OPTIONS(description='Freitext für projektbezogene Bemerkungen.'), immobilienentwickler_name
OPTIONS(description='Verantwortlicher Mitarbeitername für die Rolle des Immobilienentwicklers im Projekt.'),
objektplaner_name OPTIONS(description='Verantwortlicher Mitarbeitername für die Rolle des Objektplaners im Projekt.'),
bauprojektmanager_name
OPTIONS(description='Verantwortlicher Mitarbeitername für die Rolle des Bauprojektmanagers im Projekt.'),
vertrieb_mitarbeiter_name OPTIONS(description='Verantwortlicher Mitarbeitername für den Vertrieb im Projekt.'),
dat_storno OPTIONS(description='Datum des Storno sollte ein Projekt nachträglich storniert werden.'), dat_a1_budget
OPTIONS(description='Datum des aktuellen A1 Budgets des Projektes'), a1_budget_version_name
OPTIONS(description='Name der aktuellen Version des A1 Budgets des Projektes'), dat_a2_budget
OPTIONS(description='Datum des aktuellen A2 Budgets des Projektes'), a2_budget_version_name
OPTIONS(description='Name der aktuellen A2 Version des Budgets des Projektes'), dat_aktuelle_kostenprognose
OPTIONS(description='Datum der aktuellsten Kostenprognose des Projektes'), aktuelle_kostenprognose_version_nr
OPTIONS(description='Nummer der aktuellen Version der Kostenprognose des Projektes'), dat_objekt_freigegeben
OPTIONS(description='Datum für den Termin Objekt Freigegeben. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
objekt_freigegeben_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Objekt freigegeben\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_standortsicherung_durchgefuehrt
OPTIONS(description='Datum für den Termin Standortsicherung durchgeführt. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
standortsicherung_durchgefuehrt_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Standortsicherung durchgefuehrt\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_baurecht_geschaffen
OPTIONS(description='Datum für den Termin Baurecht geschaffen. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
baurecht_geschaffen_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Baurecht geschaffen\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_baubeginn
OPTIONS(description='Datum für den Termin Baubeginn. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
baubeginn_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Baubeginn\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_beginn_kaelte
OPTIONS(description='Datum für den Termin Beginn Kälte. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
beginn_kaelte_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Beginn Kaelte\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_beginn_einrichtung
OPTIONS(description='Datum für den Termin Beginn Einrichtung. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
beginn_einrichtung_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Baubeginn Einrichtung\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_eroeffnung
OPTIONS(description='Datum für den Termin Eröffnung / Inbetriebnahme. Wenn das IST-Datum nicht vorhanden ist, handelt es sich hier um das Prognosedatum.'),
eroeffnung_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Eroeffnung\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
dat_projekt_abgeschlossen
OPTIONS(description='Datum für den Termin Projekt abgeschlossen. Wenn das IST-Datum nicht vorhanden ist, handelt es sich um das Prognosedatum,'),
projekt_abgeschlossen_dat_typ_cd
OPTIONS(description='Code gibt an ob es sich beim Datum für\""Projekt abgeschlossen\"" um ein IST (I) oder Prognose (P) Datum handelt. '),
gj_plan_eroeffnung OPTIONS(description='Geplantes Geschäftsjahr für die Eröffnung.'))
OPTIONS(DESCRIPTION = `Dimension für Projeke aus den Zentralbereichen.`) AS SELECT mandant_id,
 projekt_nr,
 wup_id,
 nb_id,
 psp_nr,
 psp_status_id,
 psp_status_bez_de,
 psp_status_bez_en,
 projekt_status_id,
 projekt_status_bez_de,
 projekt_status_bez_en,
 projektart_cd,
 projektart_bez_de,
 projektart_bez_en,
 projekttyp_id,
 projekttyp_bez_de,
 projekttyp_bez_en,
 projektphase_id,
 projektphase_bez_de,
 projektphase_bez_en,
 projektphase_status_id,
 projektphase_status_bez_de,
 projektphase_status_bez_en,
 projekt_name,
 projekt_land_id,
 projekt_region_name,
 projekt_plz_nr,
 projekt_standort_name,
 projekt_stadtteil_name,
 projekt_strasse_name,
 projekt_haus_nr,
 projekt_bemerkung_txt,
 immobilienentwickler_name,
 objektplaner_name,
 bauprojektmanager_name,
 vertrieb_mitarbeiter_name,
 dat_storno,
 dat_a1_budget,
 a1_budget_version_name,
 dat_a2_budget,
 a2_budget_version_name,
 dat_aktuelle_kostenprognose,
 aktuelle_kostenprognose_version_nr,
 dat_objekt_freigegeben,
 objekt_freigegeben_dat_typ_cd,
 dat_standortsicherung_durchgefuehrt,
 standortsicherung_durchgefuehrt_dat_typ_cd,
 dat_baurecht_geschaffen,
 baurecht_geschaffen_dat_typ_cd,
 dat_baubeginn,
 baubeginn_dat_typ_cd,
 dat_beginn_kaelte,
 beginn_kaelte_dat_typ_cd,
 dat_beginn_einrichtung,
 beginn_einrichtung_dat_typ_cd,
 dat_eroeffnung,
 eroeffnung_dat_typ_cd,
 dat_projekt_abgeschlossen,
 projekt_abgeschlossen_dat_typ_cd,
 gj_plan_eroeffnung
FROM kfl_production_dbp_msi_data.zb_dim_projekt_2;