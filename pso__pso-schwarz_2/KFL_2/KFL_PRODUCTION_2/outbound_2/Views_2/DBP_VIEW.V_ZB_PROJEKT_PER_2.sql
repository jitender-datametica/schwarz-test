CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_per_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '), dat_von
OPTIONS(description='Beginn der Gültigkeit, Teil der DWH-Historisierung.'), dat_bis
OPTIONS(description='Ende der Gültigkeit, Teil der DWH-Historisierung.'), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), psp_nr
OPTIONS(description='PSP-Nummer des Projektes.'), projekt_status_id OPTIONS(description='ID des Projektstatus.'),
psp_status_id
OPTIONS(description='ID des Status_2 des Buchungselementes (entspricht der PSP_NR). Kann vom Status_2 des Projektes abweichen.'),
projekt_name OPTIONS(description='Name des Projektes.'), projekt_land_id
OPTIONS(description='Alphanumerischer Code des Landes in dem das Projekt stattfindet.'), projekttyp_id
OPTIONS(description='ID des Projekttyps'), projektart_cd OPTIONS(description='Alphanumerischer Coder der Projektart'),
projekt_region_name
OPTIONS(description='Name der Region_2 innerhalb des Landes in dem das Projekt stattfindet. Entsprich nicht den politischen Regionen, bspw. Bundesländer.'),
projekt_plz_nr OPTIONS(description='Nummer der Postleitzahl in dem das Projekt statfindet.'), projekt_standort_name
OPTIONS(description='Name des Standortes an dem das Projekt stattfindet. Sollte in den meisten Fällen dem Namen der Stadt / der Gemeinde entsprechen.'),
projekt_stadtteil_name OPTIONS(description='Name des Stadtteils in dem das Projekt stattfindet.'), projekt_strasse_name
OPTIONS(description='Name der Straße an dem das Projekt stattfindet.'), projekt_haus_nr
OPTIONS(description='Hausnummer an dem das Projekt in der Straße stattfindet.'), projekt_bemerkung_txt
OPTIONS(description='Freitext für projektbezogene Bemerkungen.'), dat_storno
OPTIONS(description='Datum des Storno sollte ein Projekt nachträglich storniert werden.'), gj_plan_eroeffnung
OPTIONS(description='Geplantes Geschäftsjahr für die Eröffnung.'))
OPTIONS(DESCRIPTION = `Enthält historisierte Stammdaten für Projekte im Bereich Zentralbereiche (ZB).`) AS SELECT
 mandant_id,
 projekt_nr,
 dat_von,
 dat_bis,
 wup_id,
 nb_id,
 psp_nr,
 projekt_status_id,
 psp_status_id,
 projekt_name,
 projekt_land_id,
 projekttyp_id,
 projektart_cd,
 projekt_region_name,
 projekt_plz_nr,
 projekt_standort_name,
 projekt_stadtteil_name,
 projekt_strasse_name,
 projekt_haus_nr,
 projekt_bemerkung_txt,
 dat_storno,
 gj_plan_eroeffnung
FROM kfl_production_dbp_data.zb_projekt_per_2;