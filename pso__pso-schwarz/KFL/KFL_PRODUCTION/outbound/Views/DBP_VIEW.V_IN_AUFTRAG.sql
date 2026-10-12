CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_auftrag (auftrag_id OPTIONS(description='Auftragsnummer aus aufnr'),
mandant_id OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'), auftragsart_id
OPTIONS(description='ID der Auftragsart aus auart'), geschaeftsbereich_id
OPTIONS(description='Der Geschaeftsbereich ist eine interne Organisationseinheit, fuer den eine interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber'),
in_budget_typ_id OPTIONS(description='Eindeutige ID eines Budgettyps'), in_massnahme_typ_id
OPTIONS(description='Eindeutige ID eins Massnahmetyps'), auftrag_typ_id OPTIONS(description='ID des Auftragstyps'),
psp_id
OPTIONS(description='eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen'),
techn_platz_id
OPTIONS(description='Fachlicher Schlüssel des technischen Platzes aus tplnr. Referenz zur Tabelle techn_platz_per (im Modell keine Darstellung der Beziehung) Wird compressed'),
werk_id OPTIONS(description='Numerischer Surrogate key für das Werk werks'), phas_techn_abschluss_fg
OPTIONS(description='Flag = 1 bei technischem Abschluss. Quelle ist phas2'), ref_objektart_id
OPTIONS(description='Teilstring aus dem Quellfeld objnr. Das Feld setzt sich aus Teil 1 ( STRING) und Teil 2 (Auftragsnummer) zusammen. Hier wird nur der alpha-Teil gespeichert.'),
auftrag_kurztext OPTIONS(description='Kurzbeschreibung des Auftrags'), referenz_auftrag_id
OPTIONS(description='Referenzauftragsnummer. If this order is derived from a previous order, then this is the ID of the previous order.'),
standort_id
OPTIONS(description='ID eines Standortes. Zuordnung Markt bei Pooling-Geräten (oder alphanumerischer Wert / "POOL").'),
standort_werk_id
OPTIONS(description='Numerischer Surrogate key für das Werk werks - Plan where order should have been executed. Most of the times it is identical to WERK_ID.'),
kostenstelle_id OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle, aus kostl.'),
verantw_arbeitsplatz_name
OPTIONS(description='Verantwortlicher Arbeitsplatz -  Main work center (SAP term)  for maintenance tasks. A work center is an organizational unit that defines where or by whom a maintenance activity is performed. Work centers can be machines, people, or production lines, for example.In this column we have the work center that is assigned to a maintenance order at the HEADER level (on position a.k.a. "order operation" level there can be other work centers).The "Name" is the identifier of the work place, there is no code or ID. The source system supports additional descriptions of these names, but they are not maintained by the business so as of May 2024, there is no lookup table with name-description combo'))
OPTIONS(DESCRIPTION = `IMS - Auftragsstammdaten aus aufk`) AS SELECT auftrag_id,
 mandant_id,
 auftragsart_id,
 geschaeftsbereich_id,
 in_budget_typ_id,
 in_massnahme_typ_id,
 auftrag_typ_id,
 psp_id,
 techn_platz_id,
 werk_id,
 phas_techn_abschluss_fg,
 ref_objektart_id,
 auftrag_kurztext,
 referenz_auftrag_id,
 standort_id,
 standort_werk_id,
 kostenstelle_id,
 verantw_arbeitsplatz_name
FROM kfl_production_dbp_data.in_auftrag;