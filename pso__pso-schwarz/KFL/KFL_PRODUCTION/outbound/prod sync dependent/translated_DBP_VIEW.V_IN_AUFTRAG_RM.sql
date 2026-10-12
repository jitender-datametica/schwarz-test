CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_auftrag_rm (mandant_id
OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'), auftrag_rm_id
OPTIONS(description='ID der Rückmeldung aus rueck'), auftrag_rm_pos_id
OPTIONS(description='Positionsid der Rückmeldung aus rmzhl'), auftrag_id OPTIONS(description='Auftragsnummer aus aufnr'),
co_leistungsart_id
OPTIONS(description='ID der CO-Leistungsart der Rückmeldung aus dem Quellfeld learr. Referenztabelle ist in_l_leistungsart'),
storno_fg OPTIONS(description='Flag = 1 für stornierten Beleg aus dem Quellfeld stokz'), storno_zaehler
OPTIONS(description='Rückmeldezähler der stornierten Rückmeldung aus dem Quellfeld stzhl'), dat_buch
OPTIONS(description='Buchungsdatum'), teil_end_rm
OPTIONS(description='Teil-/Endrückmeldung (X = Endrückmeldung, 1 = Automatische Endrückmeldung, leer = Teilrückmeldung)'),
menge_arbeit_ist OPTIONS(description='Istarbeit - actual work done for this order'), menge_arbeit_ist_einh_id
OPTIONS(description='istarbeit Masseinheit - unit in which the actual work for this order is measured'),
datzeit_durchfuehrung_ende OPTIONS(description='Rückgemeldeter Endzeitpunkt der Durchführung')) AS SELECT mandant_id,
 auftrag_rm_id,
 auftrag_rm_pos_id,
 auftrag_id,
 co_leistungsart_id,
 storno_fg,
 storno_zaehler,
 dat_buch,
 teil_end_rm,
 menge_arbeit_ist,
 menge_arbeit_ist_einh_id,
 datzeit_durchfuehrung_ende
FROM kfl_production_dbp_data.in_auftrag_rm;