--==============================================================
-- Table: fur_prognose_vw_wo_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose_vw_wo_sum_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FUR_PROGNOSE_VW_WO_SUM_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   vw_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebsweges',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   kjwo_kl                             NUMBER(38,0)     NOT NULL,
   menge_prognose                      NUMBER(18,3)     NOT NULL COMMENT 'Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean ',
   menge_prognose_bef                  NUMBER(18,3)     NOT NULL COMMENT 'Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect',
   menge_prognose_max                  NUMBER(18,3)     NOT NULL COMMENT 'Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max',
   menge_af                            NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge aktionsfrei. Angereichert aus artbew_1',
   menge_sa                            NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge Aktionsware. Angereichert aus artbew_1',
   diff_menge_af_prognose              NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Abweichung zwischen Prognose und aktionsfreiem Abverkauf absolut, aggregiert auf WG_ebene. Bei Tagen mit SA-Mengen > 0 wird keine Differenz ausgegeben',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FUR_PROGNOSE_VW_WO_SUM PRIMARY KEY (mandant_id, vw_id, art_id, kjwo_kl) NOT ENFORCED
)  COMMENT = 'AIS - Wochen_Vertriebsweg_Aggregat der FUR-Prognose';

