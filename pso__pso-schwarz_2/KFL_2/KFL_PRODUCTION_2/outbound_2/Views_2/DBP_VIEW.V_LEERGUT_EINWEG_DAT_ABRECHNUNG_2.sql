CREATE OR REPLACE VIEW kfl_production_dbp_view.v_leergut_einweg_dat_abrechnung_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), leergutautomat_schluessel_id
OPTIONS(description='ID des Leergutautomaten. Eindeutig im Land_2'), datzeit_verarbeitung
OPTIONS(description='Zeitstempel, wann die Daten bei ESB verarbeitet worden sind. In einigen Fällen werden die Daten eines Automaten an zwei verschiedenen Tagen im System verarbeitet, daher wurde diese Spalte als Primärschlüssel hinzugefügt.'),
dat_ruecknahme
OPTIONS(description='Tag_2 der Rücknahme (Reportingdatum) ist der Tag_2, an dem der Kunde die Einwegflaschen im Automaten abgegeben hat.'),
einweg_typ_kz
OPTIONS(description='Kennzeichen für Eigen-Einwegpfand (E) oder Fremd-Einwegpfand (F). Eigen-Einwegpfand bezieht sich auf Einwegpfandflaschen, die von der von Kaufland stammen.'),
leergutautomat_id OPTIONS(description='ID des Leergutautomaten. Eindeutig in der Filiale.'), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), menge_einweg
OPTIONS(description='Menge der geschredderten Einwegpfandflaschen.'), dat_tagesabschluss
OPTIONS(description='Tag_2 des Tagesabschlusses (Business date).'))
OPTIONS(DESCRIPTION = `DIE TABELLE BEINHALTET DIE MENGE DER GESCHREDDERTEN EINWEG PFANDFLASCHEN. SIE BETRIFFT NUR LEERGUT EINWEG. DATEN KOMMEN ÜBER ESB. ES WERDEN IMMER DIE DATEN GELIEFERT, DIE "GESTERN" VERARBEITET WORDEN SIND. INHALLTLICH SIND DAS DIE DATEN VOM VOR-VORTAG.`)
AS SELECT mandant_id,
 leergutautomat_schluessel_id,
 datzeit_verarbeitung,
 dat_ruecknahme,
 einweg_typ_kz,
 leergutautomat_id,
 wup_id,
 nb_id,
 menge_einweg,
 dat_tagesabschluss
FROM kfl_production_dbp_data.leergut_einweg_dat_abrechnung_2;