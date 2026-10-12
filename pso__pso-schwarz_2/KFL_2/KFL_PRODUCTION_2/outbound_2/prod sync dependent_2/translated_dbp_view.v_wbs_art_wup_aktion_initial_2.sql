CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_art_wup_aktion_initial_2 (mandant_id
OPTIONS(description='Mandant_2 (Markt)'), art_id OPTIONS(description='Artikel_2'), wup_id OPTIONS(description='Markt'),
nb_id OPTIONS(description='Nebenbetrieb (Markt)'), mandant_id_vz OPTIONS(description='Mandant_2 (VZ)'), wup_id_vz
OPTIONS(description='Verteilzentrum'), nb_id_vz OPTIONS(description='Nebenbetrieb (VZ)'), aktion_id
OPTIONS(description='Aktion_2'), ausliefergruppe_id OPTIONS(description='Ausliefergruppe'), dat_von
OPTIONS(description='Datum im Format JJJJ-MM_2-TT'), dat_bis OPTIONS(description='Aktion_2 gültig bis'),
dat_bestandsperiode_rel OPTIONS(description='Relevantes Datum Bestandsperiode'), dat_lief_split
OPTIONS(description='Lieferdatum Split-Logik'), dat_lief_wunsch OPTIONS(description='Planlieferdatum'),
dat_bestandsperiode_bis OPTIONS(description='Bestandsperiode Datum Bis'), dat_letzte_nachversorgung
OPTIONS(description='Letzter Tag_2 für Nachversorgung'), we_bearbeitungszeit OPTIONS(description='WE-Bearbeitungszeit'),
menge_gesamt_bme OPTIONS(description='Gesamtmenge in BME. Die für die Aktion_2 ursprünglich insgesamt berechnete Menge.'),
menge_min_bme OPTIONS(description='Mindestplatzierung in BME'), menge_initial_bme
OPTIONS(description='Initialmenge in BME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
menge_initial_ame
OPTIONS(description='Initialmenge in AME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
menge_initial_pal
OPTIONS(description='Initialmenge in PAL. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
split_fg OPTIONS(description='Split möglich - 0/1'), fair_share_fg
OPTIONS(description='Welches Werbethema hatte der Artikel_2 am Vortag'), order_type
OPTIONS(description='Bestellart/Belegart für SAP UBP, UBP1, UBP0, UBGK,UBG1, UBG2'), init_lief_modus_kz
OPTIONS(description='Beschreibt den Modus, in welchem die initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None).\n- N: wenn keine initiale Belieferung errechnet wird (vor wbs_phase_id = 8).\n- S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen (wbs_phase_id 7 bis 3).\n- O: der ursprüngliche initiale Lieferlauf findet 9 Tage vor der Promotion statt, und der Berechnungslauf wird als\""O\"" (Order Creation) gekennzeichnet (ab wbs_phase_id = 2).'),
dat_beladung OPTIONS(description='Datum der Beladung.')) AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 mandant_id_vz,
 wup_id_vz,
 nb_id_vz,
 aktion_id,
 ausliefergruppe_id,
 dat_von,
 dat_bis,
 dat_bestandsperiode_rel,
 dat_lief_split,
 dat_lief_wunsch,
 dat_bestandsperiode_bis,
 dat_letzte_nachversorgung,
 we_bearbeitungszeit,
 menge_gesamt_bme,
 menge_min_bme,
 menge_initial_bme,
 menge_initial_ame,
 menge_initial_pal,
 split_fg,
 fair_share_fg,
 order_type,
 init_lief_modus_kz,
 dat_beladung
FROM kfl_production_dbp_data.wbs_art_wup_aktion_initial_2;