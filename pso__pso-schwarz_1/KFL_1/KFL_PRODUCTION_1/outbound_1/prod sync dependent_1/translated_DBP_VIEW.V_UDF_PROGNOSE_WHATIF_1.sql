CREATE OR REPLACE VIEW kfl_production_dbp_view.v_udf_prognose_whatif_1 (mandant_id OPTIONS(description='Mandant_1 im DWH.'),
art_id
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
wup_id OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), angebot_id
OPTIONS(description='Offer/Angebot_1-ID.'), dat_von OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gültig von.'), dat_bis
OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gültig bis.'), menge_prognose_basis
OPTIONS(description='Basisverkaufsmenge für zusätzliche Deltaverkaufsberechnungen.'), menge_prognose_saison
OPTIONS(description='Nettoverkaufsmenge wegen Saisonalität.'), menge_prognose_feiertag
OPTIONS(description='Nettoverkaufsmenge wegen Feiertagen.'), menge_prognose_preisaenderung
OPTIONS(description='Nettoverkaufsmenge wegen Preisänderungen.'), menge_prognose_kaufanreize
OPTIONS(description='Nettoverkaufsmenge wegen vorausgesetzten Kaufanreizen.'), menge_prognose_uplift
OPTIONS(description='Nettoverkaufsmenge wegen Effekt durch Angebotsart-Uplift.'), menge_prognose_werbemittel
OPTIONS(description='Nettoverkaufsmenge wegen Effekt aller Werbemittel.'), menge_prognose_praemienkaufanreize
OPTIONS(description='Nettoverkaufsmenge wegen Prämienkaufanreizen.'), menge_prognose_kundenkarte
OPTIONS(description='Nettoverkaufsmenge wegen Kundenkarte.'), menge_prognose_verfuegbarkeit
OPTIONS(description='Nettoverkaufsmenge wegen Verfügbarkeit.'), menge_prognose_kannibalisierung
OPTIONS(description='Nettoverkaufsmenge wegen Kannibalisierung.'), menge_prognose_verbund
OPTIONS(description='Nettoverkaufsmenge wegen Verbundeffekt.'), menge_prognose_faktoren
OPTIONS(description='Nettoverkaufsmenge aus anderen Bedarfseinflussfaktoren.'), menge_prognose_gesamt
OPTIONS(description='Nettoverkaufsmenge gesamt.'), dat_erstellung OPTIONS(description='Anlagedatum aus dat_erstellung.'),
dat_beladung OPTIONS(description='Beladungsdatum (DWH).'), dat_prognose_werbung_zuletzt_gesteuert
OPTIONS(description='Datum der letzten manuellen  Prognosesteuerung für die Werbeprognose.'),
dat_prognose_normal_zuletzt_gesteuert OPTIONS(description='Datum der letzten Prognosesteuerung für die Normalprognose.'),
prognose_offer_nullwert_fg OPTIONS(description='Einfluss auf Prognose durch Offer = 0.'), prognose_preis_nullwert_fg
OPTIONS(description='Einfluss auf Prognose durch Preis = 0.'), prognose_preis_faktor_fg
OPTIONS(description='Einfluss auf Prognose durch Preis < 0.'), prognose_tactic_nullwert_fg
OPTIONS(description='Einfluss auf Prognose durch Tactic = 0.'), menge_prognose_faktor_fg
OPTIONS(description='Einfluss aller Faktoren auf die Prognose < 0.'), menge_prognose_nullwert_fg
OPTIONS(description='Einfluss aller Faktoren auf die Prognose = 0.'), quelle_alt_prioren_fg
OPTIONS(description='ACHTUNG: Abgelöst mit der Einführung der ANZ_A_PRIORI_PARAMETER_* Spalten. Nur noch gültig/gefüllt für historische Daten davor. Flag: Sagt aus, ob alternative a-priori Parameter (Prioren) verwendet wurden als die zum Artikel_1 eigenen. Andere sind entweder Referenzartikel, hierarchische Prioren oder global-default Einstellungen. 1 bedeutet, dass mindestens eine_1 der erwähnten Alternativen zur Berechnung der Prognose herangezogen wurde.'),
anz_prior_gesamt
OPTIONS(description='Anzahl aller verfügbaren Prioren zur Prognoseberechnung. Prior ist die übliche Abkürzung für a priori Wahrscheinlichkeit. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\nSAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\nWenig historische Daten → Parameterschätzungen näher an Priors\nViele historische Daten → Parameterschätzungen näher an Daten\nDie berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_eigen
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf der eigenen Historie basieren. Höchste Präferenz. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\nSAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\nWenig historische Daten → Parameterschätzungen näher an Priors\nViele historische Daten → Parameterschätzungen näher an Daten\nDie berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_ref
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf der Referenzhistorie basieren. Erst-niedrigere Präferenz, nach den eigenen Prioren. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\nSAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\nWenig historische Daten → Parameterschätzungen näher an Priors\nViele historische Daten → Parameterschätzungen näher an Daten\nDie berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_hpr
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf hierarchischen Prioren (HPR) basieren (z.B. WG, WUG_1 bzw. WGI (Warengruppenindex)). Hierarchische Kriterien die indirekt zum Artikel_1 gehören, wie z.B. Warengruppe. Zweit-niedrigere Präferenz, nach den eigenen und Referenzartikeln. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\nSAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\nWenig historische Daten → Parameterschätzungen näher an Priors\nViele historische Daten → Parameterschätzungen näher an Daten\nDie berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_default
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf default-Werten basieren. Niedrigste Präferenz, nach den eigenen, Referenzartikeln und hierarchischen Prioren. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\nSAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\nWenig historische Daten → Parameterschätzungen näher an Priors\nViele historische Daten → Parameterschätzungen näher an Daten\nDie berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
dk_fg
OPTIONS(description='Flag gibt an, ob eine_1 Aktion_1 (Offer) in der UDF-Prognose durch die sogenannte Doorkeeper-Logik herausgefiltert wurde.\n1 (Ja): Die Aktion_1 wurde durch den Doorkeeper ausgefiltert und ist somit in UDF inaktiv.\n0 (Nein): Die Aktion_1 wurde nicht ausgefiltert und bleibt in UDF aktiv.\nQuelle ist das Feld DK_RELEVANCE aus der SAP Tabelle ZUDF_OFRWBS_DATA. Mapping: wenn X=1, sonst 0.'))
AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 angebot_id,
 dat_von,
 dat_bis,
 menge_prognose_basis,
 menge_prognose_saison,
 menge_prognose_feiertag,
 menge_prognose_preisaenderung,
 menge_prognose_kaufanreize,
 menge_prognose_uplift,
 menge_prognose_werbemittel,
 menge_prognose_praemienkaufanreize,
 menge_prognose_kundenkarte,
 menge_prognose_verfuegbarkeit,
 menge_prognose_kannibalisierung,
 menge_prognose_verbund,
 menge_prognose_faktoren,
 menge_prognose_gesamt,
 dat_erstellung,
 dat_beladung,
 dat_prognose_werbung_zuletzt_gesteuert,
 dat_prognose_normal_zuletzt_gesteuert,
 prognose_offer_nullwert_fg,
 prognose_preis_nullwert_fg,
 prognose_preis_faktor_fg,
 prognose_tactic_nullwert_fg,
 menge_prognose_faktor_fg,
 menge_prognose_nullwert_fg,
 quelle_alt_prioren_fg,
 anz_prior_gesamt,
 anz_prior_eigen,
 anz_prior_ref,
 anz_prior_hpr,
 anz_prior_default,
 dk_fg
FROM kfl_production_dbp_data.udf_prognose_whatif_1;