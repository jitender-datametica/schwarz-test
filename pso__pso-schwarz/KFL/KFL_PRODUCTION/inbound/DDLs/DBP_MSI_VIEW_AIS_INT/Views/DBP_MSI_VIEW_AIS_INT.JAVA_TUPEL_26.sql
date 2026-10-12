CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_26
(
MANDANT_ID,
KJWO_26,
MATCHING_ID,
A5,
A7,
A9,
WUG_ID,
E283,
E287,
E237,
E267,
E235,
E156,
E158,
E160,
E162,
E164,
E166,
E168,
E142,
E144,
E146,
E148,
E150,
E152,
E154,
E170,
E172,
E174,
E176,
E178,
E180,
E157,
E159,
E161,
E163,
E165,
E167,
E169,
E143,
E145,
E147,
E149,
E151,
E153,
E155,
E171,
E173,
E175,
E177,
E179,
E181,
E362,
E241,
E247,
E263,
E271,
E238,
E350,
E354,
E242,
E295,
E299,
E303,
E307,
E374,
E243,
E244,
E311,
E236,
E239,
E279,
E291,
E240,
E275,
E245,
E315,
E319,
E246,
E327,
E331,
E323
)
AS
SELECT
t1.mandant_id,
t1.kjwo_26,
t1.matching_id,
t2.A5_owg_id AS A5,
t2.A7_wg_id AS A7,
CASE
WHEN a7_wg_id < 10 THEN '00' || CAST(a7_wg_id AS VARCHAR(3))
WHEN a7_wg_id < 100 THEN '0' || CAST(a7_wg_id AS VARCHAR(3))
ELSE CAST(a7_wg_id AS VARCHAR(3)) END || CASE
WHEN wug_id < 10 THEN '00' || CAST(wug_id AS VARCHAR(3))
WHEN wug_id < 100 THEN '0' || CAST(wug_id AS VARCHAR(3))
ELSE CAST(wug_id AS VARCHAR(3)) END  A9,
t2.wug_id AS wug_id,
CAST(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E283,
CAST((((CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E287,
CAST(CASE
WHEN SUM(t1.absatz_af_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,1)) AS E237,
CAST((((CASE
WHEN SUM(t1.absatz_af_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN SUM(t1.absatz_af_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.absatz_af_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/ CASE
WHEN (SUM(t1.absatz_af_kl_vj)) / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN NULL
ELSE (SUM(t1.absatz_af_kl_vj)) / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)*100 AS DECIMAL(18,1)) AS E267,
CAST(SUM(absatz_kl) AS DECIMAL(18,0)) AS E235,
CAST(SUM(absatz_sst1) AS DECIMAL(18,0)) AS E156,
CAST(SUM(absatz_sst2) AS DECIMAL(18,0)) AS E158,
CAST(SUM(absatz_sst3) AS DECIMAL(18,0)) AS E160,
CAST(SUM(absatz_sst4) AS DECIMAL(18,0)) AS E162,
CAST(SUM(absatz_sst5) AS DECIMAL(18,0)) AS E164,
CAST(SUM(absatz_sst6) AS DECIMAL(18,0)) AS E166,
CAST(SUM(absatz_sst7) AS DECIMAL(18,0)) AS E168,
CAST(SUM(absatz_ksst1) AS DECIMAL(18,0)) AS E142,
CAST(SUM(absatz_ksst2) AS DECIMAL(18,0)) AS E144,
CAST(SUM(absatz_ksst3) AS DECIMAL(18,0)) AS E146,
CAST(SUM(absatz_ksst4) AS DECIMAL(18,0)) AS E148,
CAST(SUM(absatz_ksst5) AS DECIMAL(18,0)) AS E150,
CAST(SUM(absatz_ksst6) AS DECIMAL(18,0)) AS E152,
CAST(SUM(absatz_ksst7) AS DECIMAL(18,0)) AS E154,
CAST(SUM(absatz_ost_basis) AS DECIMAL(18,0)) AS E170,
CAST(SUM(absatz_ost_gross) AS DECIMAL(18,0)) AS E172,
CAST(SUM(absatz_sued_ost) AS DECIMAL(18,0)) AS E174,
CAST(SUM(absatz_sued_west) AS DECIMAL(18,0)) AS E176,
CAST(SUM(absatz_west) AS DECIMAL(18,0)) AS E178,
CAST(SUM(absatz_nord) AS DECIMAL(18,0)) AS E180,
CAST(CASE
WHEN SUM(absatz_sst1) = 0 THEN NULL
ELSE SUM(absatz_sst1) END / CASE
WHEN SUM(t1.markt_wochen_sst1) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst1) END AS DECIMAL(18,1)) AS E157,
CAST(CASE
WHEN SUM(absatz_sst2) = 0 THEN NULL
ELSE SUM(absatz_sst2) END / CASE
WHEN SUM(t1.markt_wochen_sst2) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst2) END AS DECIMAL(18,1))AS E159,
CAST(CASE
WHEN SUM(absatz_sst3) = 0 THEN NULL
ELSE SUM(absatz_sst3) END / CASE
WHEN SUM(t1.markt_wochen_sst3) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst3) END AS DECIMAL(18,1)) AS E161,
CAST(CASE
WHEN SUM(absatz_sst4) = 0 THEN NULL
ELSE SUM(absatz_sst4) END / CASE
WHEN SUM(t1.markt_wochen_sst4) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst4) END AS DECIMAL(18,1)) AS E163,
CAST(CASE
WHEN SUM(absatz_sst5) = 0 THEN NULL
ELSE SUM(absatz_sst5) END / CASE
WHEN SUM(t1.markt_wochen_sst5) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst5) END AS DECIMAL(18,1)) AS E165,
CAST(CASE
WHEN SUM(absatz_sst6) = 0 THEN NULL
ELSE SUM(absatz_sst6) END / CASE
WHEN SUM(t1.markt_wochen_sst6) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst6) END AS DECIMAL(18,1)) AS E167,
CAST(CASE
WHEN SUM(absatz_sst7) = 0 THEN NULL
ELSE SUM(absatz_sst7) END / CASE
WHEN SUM(t1.markt_wochen_sst7) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst7) END AS DECIMAL(18,1)) AS E169,
CAST(CASE
WHEN SUM(absatz_ksst1) = 0 THEN NULL
ELSE SUM(absatz_ksst1) END / CASE
WHEN SUM(t1.markt_wochen_ksst1) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst1) END AS DECIMAL(18,1)) AS E143,
CAST(CASE
WHEN SUM(absatz_ksst2) = 0 THEN NULL
ELSE SUM(absatz_ksst2) END / CASE
WHEN SUM(t1.markt_wochen_ksst2) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst2) END AS DECIMAL(18,1)) AS E145,
CAST(CASE
WHEN SUM(absatz_ksst3) = 0 THEN NULL
ELSE SUM(absatz_ksst3) END / CASE
WHEN SUM(t1.markt_wochen_ksst3) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst3) END AS DECIMAL(18,1)) AS E147,
CAST(CASE
WHEN SUM(absatz_ksst4) = 0 THEN NULL
ELSE SUM(absatz_ksst4) END / CASE
WHEN SUM(t1.markt_wochen_ksst4) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst4) END AS DECIMAL(18,1)) AS E149,
CAST(CASE
WHEN SUM(absatz_ksst5) = 0 THEN NULL
ELSE SUM(absatz_ksst5) END / CASE
WHEN SUM(t1.markt_wochen_ksst5) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst5) END AS DECIMAL(18,1)) AS E151,
CAST(CASE
WHEN SUM(absatz_ksst6) = 0 THEN NULL
ELSE SUM(absatz_ksst6) END / CASE
WHEN SUM(t1.markt_wochen_ksst6) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst6) END AS DECIMAL(18,1)) AS E153,
CAST(CASE
WHEN SUM(absatz_ksst7) = 0 THEN NULL
ELSE SUM(absatz_ksst7) END / CASE
WHEN SUM(t1.markt_wochen_ksst7) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst7) END AS DECIMAL(18,1)) AS E155,
CAST(CASE
WHEN SUM(t1.absatz_ost_basis) = 0 THEN NULL
ELSE SUM(t1.absatz_ost_basis) END / CASE
WHEN SUM(t1.markt_wochen_ost_basis) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ost_basis) END AS DECIMAL(18,1)) AS E171,
CAST(CASE
WHEN SUM(t1.absatz_ost_gross) = 0 THEN NULL
ELSE SUM(t1.absatz_ost_gross) END / CASE
WHEN SUM(t1.markt_wochen_ost_gross) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ost_gross) END AS DECIMAL(18,1)) AS E173,
CAST(CASE
WHEN SUM(t1.absatz_sued_ost) = 0 THEN NULL
ELSE SUM(t1.absatz_sued_ost) END / CASE
WHEN SUM(t1.markt_wochen_sued_ost) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sued_ost) END AS DECIMAL(18,1)) AS E175,
CAST(CASE
WHEN SUM(t1.absatz_sued_west) = 0 THEN NULL
ELSE SUM(t1.absatz_sued_west) END / CASE
WHEN SUM(t1.markt_wochen_sued_west) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sued_west) END AS DECIMAL(18,1)) AS E177,
CAST(CASE
WHEN SUM(t1.absatz_west) = 0 THEN NULL
ELSE SUM(t1.absatz_west) END / CASE
WHEN SUM(t1.markt_wochen_west) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_west) END AS DECIMAL(18,1)) AS E179,
CAST(CASE
WHEN SUM(t1.absatz_nord) = 0 THEN NULL
ELSE SUM(t1.absatz_nord) END / CASE
WHEN SUM(t1.markt_wochen_nord) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_nord) END AS DECIMAL(18,1)) AS E181,
CAST (CAST(SUM(t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS DEC (18,4)) / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_listung) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_listung) END *100 AS DEC (18,1)) AS E362,
CAST(SUM(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS E241,
CAST((SUM(kassenumsatz_kl_absolut_netto) - (SUM(rohertrag_ekmep_olk_4n))) / CASE
WHEN SUM(absatz_kl) = 0 THEN NULL
ELSE SUM(absatz_kl) END AS DECIMAL(18,2)) AS E247,
CAST(CASE
WHEN SUM(t1.absatz_sa_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,1)) AS E263,
CAST((((CASE
WHEN SUM(t1.absatz_sa_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN SUM(t1.absatz_sa_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.absatz_sa_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN SUM(t1.absatz_sa_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E271,
CAST((CASE
WHEN SUM(t1.absatz_sa_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl) END / CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END) * 100 AS DECIMAL(18,1)) AS E238,
--,CAST((NULLIfZero(SUM(CAST(t1.anz_bons_sa AS DECIMAL(18,4)))) / NULLIfZero(SUM(CAST(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E354
--,CAST((NULLIfZero(SUM(CAST(t1.anz_bons_af AS DECIMAL(18,4)))) / NULLIfZero(SUM(CAST(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E350
--Bons aktuell nicht möglich
NULL AS E350,
NULL AS E354,
CAST(CASE
WHEN (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN NULL
ELSE (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS E242,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E295,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E299,
CAST((((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E303,
CAST((((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E307,
CAST(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_brutto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_brutto) END / CASE
WHEN SUM(t1.absatz_af_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl) END AS DECIMAL(18,2)) AS E374,
CAST((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS E243,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS E244,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS E311,
CAST(((CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END - CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) / CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS E236,
CAST(SUM(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS E239,
CAST(CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E279,
CAST((((CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E291,
CAST(((CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS E240,
CAST(SUM(t1.kassenumsatz_kl_absolut_brutto) AS DECIMAL(18,0)) AS E275,
CAST(SUM(t1.totalabschriften_wert_netto_absolut) AS DECIMAL(18,0)) AS E245,
CAST(SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) AS DECIMAL(18,0)) AS E315,
CAST((CASE
WHEN SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E319,
CAST((CASE
WHEN SUM(t1.totalabschriften_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E246,
CAST((((CASE
WHEN SUM(t1.totalabschriften_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) - CASE
WHEN CASE
WHEN SUM(t1.totalabschriften_wert_netto_absolut_vj) = 0 THEN NULL
ELSE SUM(t1.totalabschriften_wert_netto_absolut_vj) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.totalabschriften_wert_netto_absolut_vj) = 0 THEN NULL
ELSE SUM(t1.totalabschriften_wert_netto_absolut_vj) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END END) / (CASE
WHEN SUM(t1.totalabschriften_wert_netto_absolut_vj) = 0 THEN NULL
ELSE SUM(t1.totalabschriften_wert_netto_absolut_vj) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E327,
CAST((((CASE
WHEN SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) - CASE
WHEN CASE
WHEN SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0 THEN NULL
ELSE SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END = 0 THEN NULL
ELSE CASE
WHEN SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0 THEN NULL
ELSE SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END END) / (CASE
WHEN SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0 THEN NULL
ELSE SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E331,
CAST ((SUM(t1.totalabschriften_wert_netto_absolut) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) / CASE
WHEN (SUM(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_wg) END) = 0 THEN NULL
ELSE (SUM(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_wg) END) END AS DEC (18,2)) AS E323
FROM dbp_msi_v_view.v_tupel_26_wochen t1
JOIN dbp_view.v_woche x1
ON t1.kjwo_26 = x1.kjwo
JOIN dbp_view.v_woche x2
ON x1.akt_wo+2 = x2.akt_wo
JOIN dbp_msi_v_view.v_tupel_mat t2
ON t1.mandant_id=t2.mandant_id
AND t1.matching_id=t2.matching_id
AND x2.kjwo = t2.a500_kjwo_update
GROUP BY 1,2,3,4,5,6,7;