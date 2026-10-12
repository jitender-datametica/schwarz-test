--==============================================================
-- Table: fur_prognose_wg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose_wg_sum_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FUR_PROGNOSE_WG_SUM_1 CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
   menge_prognose                      NUMBER(29,3)     NOT NULL COMMENT 'Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean ',
   menge_prognose_bef                  NUMBER(29,3)     NOT NULL COMMENT 'Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect',
   menge_prognose_max                  NUMBER(29,3)     NOT NULL COMMENT 'Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max',
   menge_af                            NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge aktionsfrei. Angereichert aus artbew_1',
   menge_sa                            NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge Aktionsware. Angereichert aus artbew_1',
   diff_menge_af_prognose              NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Abweichung zwischen Prognose und aktionsfreiem Abverkauf absolut, aggregiert auf WG_ebene. Bei Tagen mit SA-Mengen > 0 wird keine Differenz ausgegeben',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FUR_PROGNOSE_WG_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, wg_id, arthiertyp_id, dat) NOT ENFORCED
)  COMMENT = 'AIS - Warengruppen_Aggregat der FUR-Prognose';

