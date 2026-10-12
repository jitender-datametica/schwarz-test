--==============================================================
-- Table: fur_prognose_wg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose_wg_sum_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fur_prognose_wg_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
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
PRIMARY KEY (mandant_id, wup_id, nb_id, wg_id, arthiertyp_id, dat) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='AIS - Warengruppen_Aggregat der FUR-Prognose');