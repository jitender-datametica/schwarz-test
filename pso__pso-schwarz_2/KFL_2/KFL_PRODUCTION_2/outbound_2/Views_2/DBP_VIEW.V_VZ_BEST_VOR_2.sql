CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vz_best_vor_2 (mandant_id OPTIONS(description='Mandant_2           '),
dat_plan OPTIONS(description='Planungsdatum       '), wup_id OPTIONS(description='Betrieb'), nb_id
OPTIONS(description='Nebenbetrieb'), gp_id OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors'),
gp_teilsortiment_id OPTIONS(description='Lieferantenteilsortiment       '), lagerort_id OPTIONS(description='Lagerort '),
disponent_id OPTIONS(description='Disponent'), art_id OPTIONS(description='Artikelnummer       '), dat_best
OPTIONS(description='Bestelltag'), dat_lief OPTIONS(description='Liefertag  '), bv_quelle_id
OPTIONS(description='BV-Quelle '), menge_best_gesamt OPTIONS(description='Bestellmenge gesamt BME      '),
menge_best_normal OPTIONS(description='Bestellmenge regulär BME  '), menge_best_bevorratung
OPTIONS(description='Bestellmenge Bevorratung BME        '), menge_best_iwt
OPTIONS(description='Bestellmenge IWT BME        '), menge_best_werbung
OPTIONS(description='Bestellmenge Werbung BME       '), menge_einh_id OPTIONS(description='Bestellmengenheit'),
umrech_faktor_best_bme OPTIONS(description='Umrechenfaktor Bestellmengeheit in Basismengeneinheit'), dat_verfuegbarkeit
OPTIONS(description='Verfügbarkeitsdatum '), dat_bestandsperiode_ende OPTIONS(description='Datum Ende Bestandsperiod'),
bestand OPTIONS(description='Gelesener Bestand oder ausgerechnet aus Bestandsprojektion '), bestand_werbung
OPTIONS(description='Gelesener PromoBestand o.ausgerechnet aus Bestandsprojektion'), bestand_iwt
OPTIONS(description='Gelesener IWBestand oder ausgerechnet aus Bestandsprojektion'), reichweite
OPTIONS(description='Reichweite '), dat_besdarfsperiode_ende OPTIONS(description='Datum Ende Bedarfsperiode'),
bedarf_netto OPTIONS(description='Nettobedarf'), bedarf_erweitert OPTIONS(description='Bedarf erweitert'),
bedarf_nach_mbm_art OPTIONS(description='nach MBM Artike'), bedarf_nach_rundung OPTIONS(description='nach Rundung '),
bedarf_nach_dyn_rundung OPTIONS(description='nach dynamischer Rundung'), bedarf_nach_mbm_lieferant
OPTIONS(description='nach MBM Lieferant'), vz_dispo_status_id OPTIONS(description='VZ Dispo Status.'), art_dispo_id
OPTIONS(description='Artikel_2 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
gp_dispo_id
OPTIONS(description='Lieferant ID Dispo (Surrogate Key). Die gp_id entspricht der Lieferantennummer aus SAP, ist Business key, während gp_dispo_id von SAP täglich neu generiert wird. Gp_dispo_id ändert sich mit jedem Planungslauf. Gp_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
best_vor_dispo_id
OPTIONS(description='ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).'))
OPTIONS(DESCRIPTION = `Bestellvorschläge VZ-Lieferant [DC-level order proposals]`) AS SELECT mandant_id,
 dat_plan,
 wup_id,
 nb_id,
 gp_id,
 gp_teilsortiment_id,
 lagerort_id,
 disponent_id,
 art_id,
 dat_best,
 dat_lief,
 bv_quelle_id,
 menge_best_gesamt,
 menge_best_normal,
 menge_best_bevorratung,
 menge_best_iwt,
 menge_best_werbung,
 menge_einh_id,
 umrech_faktor_best_bme,
 dat_verfuegbarkeit,
 dat_bestandsperiode_ende,
 bestand,
 bestand_werbung,
 bestand_iwt,
 reichweite,
 dat_besdarfsperiode_ende,
 bedarf_netto,
 bedarf_erweitert,
 bedarf_nach_mbm_art,
 bedarf_nach_rundung,
 bedarf_nach_dyn_rundung,
 bedarf_nach_mbm_lieferant,
 vz_dispo_status_id,
 art_dispo_id,
 gp_dispo_id,
 best_vor_dispo_id
FROM kfl_production_dbp_data.vz_best_vor_2;