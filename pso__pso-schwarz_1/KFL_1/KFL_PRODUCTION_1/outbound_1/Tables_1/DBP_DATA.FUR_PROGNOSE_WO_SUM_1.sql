--==============================================================
-- Table: fur_prognose_wo_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose_wo_sum_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fur_prognose_wo_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
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
sum_progn_groesser BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Flags progn_groesser. Aggregiert aus fur_prognose_1'),
sum_menge_af_groesser BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Flags menge_af_groesser. Aggregiert aus fur_prognose_1'),
menge_af_mittel_3wo NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Mittelwert von menge_af der aktuellen Woche_1, der Vorwoche und der Folgewoche.  Bsp: Der Mittelwert für KW 5 ermittelt sich aus KW 2 – 4'),
progn_groesser_wo_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
menge_af_groesser_wo_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
progn_grosser_wo0_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Verhältnis der Prognose zur menge_af_mittel_3wo derselben Woche_1 in bestimmten Verhältnissen ergibt einen größeren Prognosewert'),
progn_groesser_wo1_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_1 plus 1 in bestimmten Verhältnissen ergibt einen größeren Prognosewert'),
progn_groesser_wo2_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_1 plus 2 in bestimmten Verhältnissen ergibt einen größeren Prognosewert'),
menge_af_groesser_wo0_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Verhältnis der Prognose zur menge_af_mittel_3wo derselben Woche_1 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert'),
menge_af_groesser_wo1_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_1 plus 1 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert'),
menge_af_groesser_wo2_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Verhältnis der Prognose zur menge_af_mittel_3wo der Woche_1 plus 2 in bestimmten Verhältnissen ergibt einen größeren Abverkaufswert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, kjwo_kl) NOT ENFORCED
) CLUSTER BY mandant_id, kjwo_kl
OPTIONS(description='AIS - Wochen_Aggregat der FUR-Prognose');