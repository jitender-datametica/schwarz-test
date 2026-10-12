--==============================================================
-- Table: fur_prognose_wo_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose_wo_sum_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FUR_PROGNOSE_WO_SUM_2 CLUSTER BY (
     MANDANT_ID,
     KJWO_KL 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   kjwo_kl                             INTEGER     NOT NULL,
   menge_prognose                      NUMBER(29,3)     NOT NULL COMMENT 'Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean ',
   menge_prognose_bef                  NUMBER(29,3)     NOT NULL COMMENT 'Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect',
   menge_prognose_max                  NUMBER(29,3)     NOT NULL COMMENT 'Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max',
   menge_af                            NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge aktionsfrei. Angereichert aus artbew_2',
   menge_sa                            NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge Aktionsware. Angereichert aus artbew_2',
   diff_menge_af_prognose              NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abweichung zwischen Prognose und aktionsfreiem Abverkauf absolut, aggregiert auf WG_ebene. Bei Tagen mit SA-Mengen > 0 wird keine Differenz ausgegeben',
   sum_progn_groesser                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Flags progn_groesser. Aggregiert aus fur_prognose_2',
   sum_menge_af_groesser               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Flags menge_af_groesser. Aggregiert aus fur_prognose_2',
   menge_af_mittel_3wo                 NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Mittelwert von menge_af der aktuellen Woche_2, der Vorwoche und der Folgewoche.  Bsp: Der Mittelwert für KW 5 ermittelt sich aus KW 2 – 4',
   progn_groesser_wo_fg                INTEGER     NOT NULL DEFAULT 0 COMMENT 'menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
   menge_af_groesser_wo_fg             INTEGER     NOT NULL DEFAULT 0 COMMENT 'menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
   progn_grosser_wo0_fg                INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo derselben Woche_2 in bestimmten Verhältnissen ergibt einen größeren Prognosewert',
   progn_groesser_wo1_fg               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_2 plus 1 in bestimmten Verhältnissen ergibt einen größeren Prognosewert',
   progn_groesser_wo2_fg               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_2 plus 2 in bestimmten Verhältnissen ergibt einen größeren Prognosewert',
   menge_af_groesser_wo0_fg            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo derselben Woche_2 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert',
   menge_af_groesser_wo1_fg            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_2 plus 1 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert',
   menge_af_groesser_wo2_fg            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_2 plus 2 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FUR_PROGNOSE_WO_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, kjwo_kl) NOT ENFORCED
)  COMMENT = 'AIS - Wochen_Aggregat der FUR-Prognose';

