--==============================================================
-- Table: udf_prognose_whatif_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: udf_prognose_whatif_2
   generated from Powerdesigner on Donnerstag, 22. Juni 2023 17:19:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.UDF_PROGNOSE_WHATIF_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   angebot_id                          INTEGER     NOT NULL COMMENT 'Offer/Angebot_2-ID.',
   dat_von                             DATE             COMMENT 'YYYY-MM_2-DD // Aktion_2 gültig von.',
   dat_bis                             DATE             COMMENT 'YYYY-MM_2-DD // Aktion_2 gültig bis.',
   menge_prognose_basis                NUMBER(29,5)     COMMENT 'Basisverkaufsmenge für zusätzliche Deltaverkaufsberechnungen.',
   menge_prognose_saison               NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Saisonalität.',
   menge_prognose_feiertag             NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Feiertagen.',
   menge_prognose_preisaenderung       NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Preisänderungen.',
   menge_prognose_kaufanreize          NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen vorausgesetzten Kaufanreizen.',
   menge_prognose_uplift               NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Effekt durch Angebotsart-Uplift.',
   menge_prognose_werbemittel          NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Effekt aller Werbemittel.',
   menge_prognose_praemienkaufanreize  NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Prämienkaufanreizen.',
   menge_prognose_kundenkarte          NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Kundenkarte.',
   menge_prognose_verfuegbarkeit       NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Verfügbarkeit.',
   menge_prognose_kannibalisierung     NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Kannibalisierung.',
   menge_prognose_verbund              NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge wegen Verbundeffekt.',
   menge_prognose_faktoren             NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge aus anderen Bedarfseinflussfaktoren.',
   menge_prognose_gesamt               NUMBER(29,5)     COMMENT 'Nettoverkaufsmenge gesamt.',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Anlagedatum aus dat_erstellung.',
   dat_beladung                        DATE             COMMENT 'Beladungsdatum (DWH).',
   dat_prognose_werbung_zuletzt_gesteuert DATE             COMMENT 'Datum der letzten manuellen  Prognosesteuerung für die Werbeprognose.',
   dat_prognose_normal_zuletzt_gesteuert DATE             COMMENT 'Datum der letzten Prognosesteuerung für die Normalprognose.',
   prognose_offer_nullwert_fg          INTEGER     COMMENT 'Einfluss auf Prognose durch Offer = 0.',
   prognose_preis_nullwert_fg          INTEGER     COMMENT 'Einfluss auf Prognose durch Preis = 0.',
   prognose_preis_faktor_fg            INTEGER     COMMENT 'Einfluss auf Prognose durch Preis < 0.',
   prognose_tactic_nullwert_fg         INTEGER     COMMENT 'Einfluss auf Prognose durch Tactic = 0.',
   menge_prognose_faktor_fg            INTEGER     COMMENT 'Einfluss aller Faktoren auf die Prognose < 0.',
   menge_prognose_nullwert_fg          INTEGER     COMMENT 'Einfluss aller Faktoren auf die Prognose = 0.',
   quelle_alt_prioren_fg               INTEGER     COMMENT 'ACHTUNG: Abgelöst mit der Einführung der ANZ_A_PRIORI_PARAMETER_* Spalten. Nur noch gültig/gefüllt für historische Daten davor. Flag: Sagt aus, ob alternative a-priori Parameter (Prioren) verwendet wurden als die zum Artikel_2 eigenen. Andere sind entweder Referenzartikel, hierarchische Prioren oder global-default Einstellungen. 1 bedeutet, dass mindestens eine_2 der erwähnten Alternativen zur Berechnung der Prognose herangezogen wurde.',
   anz_prior_gesamt                    INTEGER     COMMENT 'Anzahl aller verfügbaren Prioren zur Prognoseberechnung. Prior ist die übliche Abkürzung für a-priori-Wahrscheinlichkeitsverteilung und bedeutet, dass ',
   anz_prior_eigen                     INTEGER     COMMENT 'Anzahl der verfügbaren Prioren, die auf der eigenen Historie basieren. Höchste Präferenz.',
   anz_prior_ref                       INTEGER     COMMENT 'Anzahl der verfügbaren Prioren, die auf der Referenzhistorie basieren. Erst-niedrigere Präferenz, nach den eigenen Prioren.',
   anz_prior_hpr                       INTEGER     COMMENT 'Anzahl der verfügbaren Prioren, die auf hierarchischen Prioren (HPR) basieren (z.B. WG, WUG_2 bzw. WGI (Warengruppenindex)). Hierarchische Kriterien über Artikeleigenschaften wie Warengruppe oder . Zweit-niedrigere Präferenz, nach den eigenen und Referenzartikeln.',
   anz_prior_default                   INTEGER     COMMENT 'Anzahl der verfügbaren Prioren, die auf default-Werten basieren. Niedrigste Präferenz, nach den eigenen, Referenzartikeln und hierarchischen Prioren.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_UDF_PROGNOSE_WHATIF PRIMARY KEY (mandant_id, wup_id, art_id, nb_id, angebot_id) NOT ENFORCED
)  COMMENT = 'SCM - Prognosewerte aus SAP UDF - Lookup 00700 = 7 > Lookup_Table L_System_2
             Die Tabelle UDF_PROGNOSE_WHATIF_2 enthält eine_2 ursachengerechte Aufschlüsselung für die errechneten Werbeprognosen aus dem SAP-Quellsystem UDF.
             Die Prognose wird unter Berücksichtigung unterschiedlicher Einflüsse, wie z.B. Saisonalität (menge_prognose_saison) oder Kannibalisierung mit anderen Artikeln (menge_prognose_kannibalisierung) gebildet. Die Aufschlüsselung auf die einzelnen Einflussfaktoren ermöglicht dem User ein besseres Verständnis darüber, wie sich die Prognose gebildet hat und erlaubt Rückschlüsse auf die Steuerung dieser.
             Die Prioren-Felder enthalten Informationen darüber, auf welcher Basis sich die Prognose gebildet hat – entfällt beispielsweise ein großer Anteil der Prioren auf den Referenzartikel (anz_prioren_referenz), so kann der User daraus ableiten, dass kaum die Historie des eigenen Artikels herangezogen wurde. Eine_2 gewünschte Veränderung der Prognose durch den User kann so z.B. über die Änderung des Referenzartikels herbeigeführt werden.
             
             Des Weiteren enthält die Tabelle auch Informationen über den letzten manuellen Eingriff durch den User (dat_prognose_zuletzt_gesteuert).';
