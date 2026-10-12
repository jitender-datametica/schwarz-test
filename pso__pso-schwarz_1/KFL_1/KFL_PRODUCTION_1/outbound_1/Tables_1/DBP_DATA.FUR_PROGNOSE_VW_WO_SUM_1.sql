--==============================================================
-- Table: fur_prognose_vw_wo_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose_vw_wo_sum_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fur_prognose_vw_wo_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebsweges'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
kjwo_kl BIGNUMERIC(38,0) NOT NULL,
menge_prognose NUMERIC(18,3) NOT NULL
OPTIONS(description='Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean '),
menge_prognose_bef NUMERIC(18,3) NOT NULL
OPTIONS(description='Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect'),
menge_prognose_max NUMERIC(18,3) NOT NULL
OPTIONS(description='Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max'),
menge_af NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Abverkaufsmenge aktionsfrei. Angereichert aus artbew_1'),
menge_sa NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Abverkaufsmenge Aktionsware. Angereichert aus artbew_1'),
diff_menge_af_prognose NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abweichung zwischen Prognose und aktionsfreiem Abverkauf absolut, aggregiert auf WG_ebene. Bei Tagen mit SA-Mengen > 0 wird keine Differenz ausgegeben'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vw_id, art_id, kjwo_kl) NOT ENFORCED
) OPTIONS(description='AIS - Wochen_Vertriebsweg_Aggregat der FUR-Prognose');