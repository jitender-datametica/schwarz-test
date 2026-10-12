CREATE OR REPLACE TABLE kfl_production_dbp_data.udf_prognose_whatif (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
angebot_id INTEGER NOT NULL OPTIONS(description='Offer/Angebot-ID.'),
dat_von DATE OPTIONS(description='YYYY-MM-DD // Aktion gültig von.'),
dat_bis DATE OPTIONS(description='YYYY-MM-DD // Aktion gültig bis.'),
menge_prognose_basis NUMERIC(29,5) OPTIONS(description='Basisverkaufsmenge für zusätzliche Deltaverkaufsberechnungen.'),
menge_prognose_saison NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Saisonalität.'),
menge_prognose_feiertag NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Feiertagen.'),
menge_prognose_preisaenderung NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Preisänderungen.'),
menge_prognose_kaufanreize NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen vorausgesetzten Kaufanreizen.'),
menge_prognose_uplift NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Effekt durch Angebotsart-Uplift.'),
menge_prognose_werbemittel NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Effekt aller Werbemittel.'),
menge_prognose_praemienkaufanreize NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Prämienkaufanreizen.'),
menge_prognose_kundenkarte NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Kundenkarte.'),
menge_prognose_verfuegbarkeit NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Verfügbarkeit.'),
menge_prognose_kannibalisierung NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Kannibalisierung.'),
menge_prognose_verbund NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge wegen Verbundeffekt.'),
menge_prognose_faktoren NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge aus anderen Bedarfseinflussfaktoren.'),
menge_prognose_gesamt NUMERIC(29,5) OPTIONS(description='Nettoverkaufsmenge gesamt.'),
dat_erstellung DATE NOT NULL OPTIONS(description='Anlagedatum aus dat_erstellung.'),
dat_beladung DATE OPTIONS(description='Beladungsdatum (DWH).'),
dat_prognose_werbung_zuletzt_gesteuert DATE
OPTIONS(description='Datum der letzten manuellen  Prognosesteuerung für die Werbeprognose.'),
prognose_offer_nullwert_fg INTEGER OPTIONS(description='Einfluss auf Prognose durch Offer = 0.'),
prognose_preis_nullwert_fg INTEGER OPTIONS(description='Einfluss auf Prognose durch Preis = 0.'),
prognose_preis_faktor_fg INTEGER OPTIONS(description='Einfluss auf Prognose durch Preis < 0.'),
prognose_tactic_nullwert_fg INTEGER OPTIONS(description='Einfluss auf Prognose durch Tactic = 0.'),
menge_prognose_faktor_fg INTEGER OPTIONS(description='Einfluss aller Faktoren auf die Prognose < 0.'),
menge_prognose_nullwert_fg INTEGER OPTIONS(description='Einfluss aller Faktoren auf die Prognose = 0.'),
quelle_alt_prioren_fg INTEGER
OPTIONS(description='ACHTUNG: Abgelöst mit der Einführung der ANZ_A_PRIORI_PARAMETER_* Spalten. Nur noch gültig/gefüllt für historische Daten davor. Flag: Sagt aus, ob alternative a-priori Parameter (Prioren) verwendet wurden als die zum Artikel eigenen. Andere sind entweder Referenzartikel, hierarchische Prioren oder global-default Einstellungen. 1 bedeutet, dass mindestens eine der erwähnten Alternativen zur Berechnung der Prognose herangezogen wurde.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
dat_prognose_normal_zuletzt_gesteuert DATE
OPTIONS(description='Datum der letzten Prognosesteuerung für die Normalprognose.'),
anz_prior_gesamt INTEGER
OPTIONS(description='Anzahl aller verfügbaren Prioren zur Prognoseberechnung. Prior ist die übliche Abkürzung für a priori Wahrscheinlichkeit. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\n            SAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\n            Wenig historische Daten → Parameterschätzungen näher an Priors\n            Viele historische Daten → Parameterschätzungen näher an Daten\n            Die berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_eigen INTEGER
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf der eigenen Historie basieren. Höchste Präferenz. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\n            SAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\n            Wenig historische Daten → Parameterschätzungen näher an Priors\n            Viele historische Daten → Parameterschätzungen näher an Daten\n            Die berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_ref INTEGER
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf der Referenzhistorie basieren. Erst-niedrigere Präferenz, nach den eigenen Prioren. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\n            SAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\n            Wenig historische Daten → Parameterschätzungen näher an Priors\n            Viele historische Daten → Parameterschätzungen näher an Daten\n            Die berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_hpr INTEGER
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf hierarchischen Prioren (HPR) basieren (z.B. WG, WUG bzw. WGI (Warengruppenindex)). Hierarchische Kriterien die indirekt zum Artikel gehören, wie z.B. Warengruppe. Zweit-niedrigere Präferenz, nach den eigenen und Referenzartikeln. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\n            SAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\n            Wenig historische Daten → Parameterschätzungen näher an Priors\n            Viele historische Daten → Parameterschätzungen näher an Daten\n            Die berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
anz_prior_default INTEGER
OPTIONS(description='Anzahl der verfügbaren Prioren, die auf default-Werten basieren. Niedrigste Präferenz, nach den eigenen, Referenzartikeln und hierarchischen Prioren. Verfügbar, weil es nicht die tatsächliche Anzahl der verwendeten Prioren ist, sondern die, die dem Modell zum Zeitpunkt der Prognoseerstellung zur Verfügung standen.\n            SAP UDF kann fehlende Informationen durch allgemeine bestmögliche Schätzungen (Prioren) behandeln. Bei der Berechnung der Parameterschätzungen des Bedarfsmodells balanciert UDF a priori und historische Daten:\n            Wenig historische Daten → Parameterschätzungen näher an Priors\n            Viele historische Daten → Parameterschätzungen näher an Daten\n            Die berechneten Parameterschätzungen dienen als Input für die Berechnung der Prognose.'),
dk_fg INTEGER
OPTIONS(description='Flag gibt an, ob eine Aktion (Offer) in der UDF-Prognose durch die sogenannte Doorkeeper-Logik herausgefiltert wurde.\n            1 (Ja): Die Aktion wurde durch den Doorkeeper ausgefiltert und ist somit in UDF inaktiv.\n            0 (Nein): Die Aktion wurde nicht ausgefiltert und bleibt in UDF aktiv.\n            Quelle ist das Feld DK_RELEVANCE aus der SAP Tabelle ZUDF_OFRWBS_DATA. Mapping: wenn X=1, sonst 0.'),
PRIMARY KEY (mandant_id, wup_id, art_id, nb_id, angebot_id) NOT ENFORCED
)
OPTIONS(description='SCM - Prognosewerte aus SAP UDF - Lookup 00700 = 7 > Lookup_Table L_System\n             Die Tabelle UDF_PROGNOSE_WHATIF enthält eine ursachengerechte Aufschlüsselung für die errechneten Werbeprognosen aus dem SAP-Quellsystem UDF.\n             Die Prognose wird unter Berücksichtigung unterschiedlicher Einflüsse, wie z.B. Saisonalität (menge_prognose_saison) oder Kannibalisierung mit anderen Artikeln (menge_prognose_kannibalisierung) gebildet. Die Aufschlüsselung auf die einzelnen Einflussfaktoren ermöglicht dem User ein besseres Verständnis darüber, wie sich die Prognose gebildet hat und erlaubt Rückschlüsse auf die Steuerung dieser.\n             Die Prioren-Felder enthalten Informationen darüber, auf welcher Basis sich die Prognose gebildet hat – entfällt beispielsweise ein großer Anteil der Prioren auf den Referenzartikel (anz_prioren_referenz), so kann der User daraus ableiten, dass kaum die Historie des eigenen Artikels herangezogen wurde. Eine gewünschte Veränderung der Prognose durch den User kann so z.B. über die Änderung des Referenzartikels herbeigeführt werden.\n             Des Weiteren enthält die Tabelle auch Informationen über den letzten manuellen Eingriff durch den User (dat_prognose_zuletzt_gesteuert).');