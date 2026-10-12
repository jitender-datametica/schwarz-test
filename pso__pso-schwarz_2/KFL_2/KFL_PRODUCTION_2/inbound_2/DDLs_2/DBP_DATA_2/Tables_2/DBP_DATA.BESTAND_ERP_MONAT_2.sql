CREATE TABLE DBP_DATA.BESTAND_ERP_MONAT_2 CLUSTER BY (MANDANT_ID)(
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   gjmo                                NUMBER(38,0)    NOT NULL COMMENT 'Geschäftsjahresmonat',
   lagerort_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort',
   menge_lgbest_erp_frei_bme           NUMBER(18,3)    COMMENT 'Bewerteter, frei verwendbarer Bestand',
   menge_lgbest_erp_umlag_bme          NUMBER(18,3)    COMMENT 'Umlagerungsbestand (von Lagerort zu Lagerort): Menge, die aus dem abgebenden Lagerort bereits entnommen wurde, aber in dem empfangenden Lagerort noch nicht eingetroffen ist.
            Dieser Umlagerungsbestand enthält die Menge, die aufgrund von Umbuchungen in der',
   menge_lgbest_erp_qual_bme           NUMBER(18,3)    COMMENT 'Qualitätsprüfbestand: Menge, die sich in der Qualitätsprüfung befindet. Sie ist Teilmenge des gesamten bewerteten Bestands und ist nicht frei verwendbar. Je nach Einstellung im Customizing gilt der Qualitätsprüfbestand bei der Verfügbarkeitsprüfung der Be',
   menge_lgbest_erp_nf_charge_bme      NUMBER(18,3)    COMMENT 'Gesamtbestand aller nicht freien Chargen: Dieser Bestand wird nur bei chargenpflichtigem Material angezeigt, und nur dann, wenn Sie den Bestand im Chargenstammsatz über den Zustandsschlüssel als nicht frei gekennzeichnet haben. Bei der Disposition gilt di',
   menge_lgbest_erp_gesp_bme           NUMBER(18,3)    COMMENT 'Gesperrter Bestand',
   menge_lgbest_erp_ret_gesp_bme       NUMBER(18,3)    COMMENT 'Retourensperrbestand: Menge, die vom Kunden zurückgeschickt und unter Vorbehalt angenommen wurde.
            Da Retouren vom Kunden in der Regel noch untersucht werden müssen, wird die zurückgelieferte Menge zunächst in den Retourensperrbestand gebucht. Dieser ist ',
   gjmo_bis                            NUMBER(38,0)    NOT NULL COMMENT 'Geschäftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei Lücken in den Monaten zu vereinfachen',
   mard_fg                             NUMBER(38,0)    NOT NULL COMMENT 'kenneichnet die Quelltabelle des Satzes. Wenn aus mard_2 dann = 1, mardh = 0',
   datzeit_daten_abzug                 TIMESTAMP_NTZ(9) COMMENT 'Zeitpunkt des Abzugs aus SAP. Wird zu Abgleichszwecken benötigt.',
   vk_brutto                           NUMBER(9,3)     DEFAULT 0 NOT NULL COMMENT 'Der Verkaufspreis (bei auf den Monat_2 bezogenen Daten zum Monatsletzten) wird aus art_wup_zu_per_2 angereichert ',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESTAND_ERP_MONAT PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Artikelbestand pro WUP_2 und Monat_2 aus den SAP-Tabellen MARD_2 und  MARDH - MULTISET';