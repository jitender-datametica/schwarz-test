--==============================================================
-- Table: fur_prognose_wg_wo_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose_wg_wo_sum
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FUR_PROGNOSE_WG_WO_SUM (
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kjwo_kl                             INTEGER     NOT NULL,
   menge_prognose                      NUMBER(29,3)     NOT NULL COMMENT 'Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean ',
   menge_prognose_bef                  NUMBER(29,3)     NOT NULL COMMENT 'Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect',
   menge_prognose_max                  NUMBER(29,3)     NOT NULL COMMENT 'Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max',
   menge_af                            NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge aktionsfrei. Angereichert aus artbew',
   menge_sa                            NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge Aktionsware. Angereichert aus artbew',
   diff_menge_af_prognose              NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abweichung zwischen Prognose und aktionsfreiem Abverkauf absolut, aggregiert auf WG_Wochen-Ebene. Bei Tagen mit SA-Mengen > 0 wird keine Differenz ausgegeben',
   sum_progn_groesser                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Flags progn_groesser. Aggregiert aus fur_prognose',
   sum_menge_af_groesser               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Flags menge_af_groesser. Aggregiert aus fur_prognose',
   menge_af_mittel_3wo                 NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Mittelwert von menge_af der aktuellen Woche, der Vorwoche und der Folgewoche.  Bsp: Der Mittelwert für KW 5 ermittelt sich aus KW 2 – 4',
   progn_groesser_wo_fg                INTEGER     NOT NULL DEFAULT 0 COMMENT 'menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
   menge_af_groesser_wo_fg             INTEGER     NOT NULL DEFAULT 0 COMMENT 'menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
   progn_grosser_wo0_fg                INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo derselben Woche in bestimmten Verhältnissen ergibt einen größeren Prognosewert',
   progn_groesser_wo1_fg               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche plus 1 in bestimmten Verhältnissen ergibt einen größeren Prognosewert',
   progn_groesser_wo2_fg               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche plus 2 in bestimmten Verhältnissen ergibt einen größeren Prognosewert',
   menge_af_groesser_wo0_fg            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo derselben Woche in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert',
   menge_af_groesser_wo1_fg            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche plus 1 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert',
   menge_af_groesser_wo2_fg            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verhältnis der Prognose zur menge_af_mittel_3wo der Woche plus 2 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FUR_PROGNOSE_WG_WO_SUM PRIMARY KEY (wg_id, arthiertyp_id, mandant_id, wup_id, nb_id, kjwo_kl) NOT ENFORCED
)  COMMENT = 'AIS - Warengruppen-Wochen-Aggregat der FUR-Prognose';

