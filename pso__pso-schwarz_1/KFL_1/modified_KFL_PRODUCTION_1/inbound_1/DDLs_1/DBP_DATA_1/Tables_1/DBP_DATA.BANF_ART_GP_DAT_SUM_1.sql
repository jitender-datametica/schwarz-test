--==============================================================
-- Table: banf_art_gp_dat_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_art_gp_dat_sum_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BANF_ART_GP_DAT_SUM_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID) aus art_wup_ordersatz_1',
   dat_lief_soll                       DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT - (banf_det.dat_lief_soll; banf_forecast.dat_lief_soll; besch_bestaetigung.dat_lief_plan (EKET))',
   in_aktion_fg                        INTEGER     NOT NULL DEFAULT 0,
   dat_kalk                            DATE             NOT NULL COMMENT 'Kalkulationsdatum',
   vk_brutto                           NUMBER(29,2)      NOT NULL COMMENT 'Verkaufspreis brutto (aus art_wup_vk_pe.vk_bruttor; wenn in Aktion_1, dann aus aktion_art_wup_zu.vk_aktion_brutto',
   banf_menge_kolli                    NUMBER(29,3)     NOT NULL COMMENT 'Bestellanforderungsmenge aus banf_det.banf_menge und Umrechnung in Kolli',
   forecast_menge_kolli                NUMBER(29,3)     COMMENT 'Bestellmenge auf banf_forecast.forecast_menge_kolli (bereits in der Einheit Kolli)',
   menge_best_kolli                    NUMBER(29,3)     NOT NULL COMMENT 'Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per_1 ermittelt.',
   banf_menge_kg                       NUMBER(29,3)     NOT NULL COMMENT 'Bestellanforderungsmenge in kg (Umrechnung in kg über Feld banf_det.banf_menge (wenn nicht in kg, dann Ermittlung über EORD_1->EINA_1->MARM_1))',
   forecast_menge_kg                   NUMBER(29,3)     COMMENT 'Bestellmenge in kg (Umrechnung in kg über Feld banf_forecast.forecast_menge (wenn nicht in kg, dann Ermittlung über EORD_1->EINA_1->MARM_1))',
   menge_best_kg                       NUMBER(29,3)     NOT NULL COMMENT 'bestellte Menge des Artikel_1  (wenn besch_best_det.best_menge_einh_id = KG dann besch_best_det.menge_best_bme Sonst Umrechnung über MARM_1)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BANF_ART_GP_DAT_SUM PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, gp_id, dat_lief_soll, in_aktion_fg, dat_kalk) NOT ENFORCED
)  COMMENT = 'FLW - Aggregat der Bestellanforderungen und Bestellungen auf Ebene Artikel_1/Markt/Tag_1 - wird im Beladeprozess gebildet';

