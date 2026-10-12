CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_tupel_52_2
AS
SELECT
t1.mandant_id,
t1.kjwo_52,
t1.matching_id,
t2.A5_owg_id AS A5,
t2.A7_wg_id AS A7,
CASE
WHEN a7_wg_id < 10 THEN '00' || Cast(a7_wg_id AS VARCHAR(3))
WHEN a7_wg_id < 100 THEN '0' || Cast(a7_wg_id AS VARCHAR(3))
ELSE Cast(a7_wg_id AS VARCHAR(3)) END || CASE
WHEN wug_id < 10 THEN '00' || Cast(wug_id AS VARCHAR(3))
WHEN wug_id < 100 THEN '0' || Cast(wug_id AS VARCHAR(3))
ELSE Cast(wug_id AS VARCHAR(3)) END  A9,
t2.wug_id AS wug_id,
Cast(CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E282,
Cast((((CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E286,
Cast(CASE
WHEN Sum(t1.absatz_af_kl) = 0 THEN null
ELSE Sum(t1.absatz_af_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,1)) AS E224,
Cast((((CASE
WHEN Sum(t1.absatz_af_kl) = 0 THEN null
ELSE Sum(t1.absatz_af_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN Sum(t1.absatz_af_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_af_kl_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.absatz_af_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_af_kl_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/ CASE
WHEN (Sum(t1.absatz_af_kl_vj)) / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN null
ELSE (Sum(t1.absatz_af_kl_vj)) / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)*100 AS DECIMAL(18,1)) AS E266,
Cast(Sum(absatz_kl) AS DECIMAL(18,0)) AS E222,
Cast(Sum(absatz_sst1) AS DECIMAL(18,0)) AS E116,
Cast(Sum(absatz_sst2) AS DECIMAL(18,0)) AS E118,
Cast(Sum(absatz_sst3) AS DECIMAL(18,0)) AS E120,
Cast(Sum(absatz_sst4) AS DECIMAL(18,0)) AS E122,
Cast(Sum(absatz_sst5) AS DECIMAL(18,0)) AS E124,
Cast(Sum(absatz_sst6) AS DECIMAL(18,0)) AS E126,
Cast(Sum(absatz_sst7) AS DECIMAL(18,0)) AS E128,
Cast(Sum(absatz_ksst1) AS DECIMAL(18,0)) AS E102,
Cast(Sum(absatz_ksst2) AS DECIMAL(18,0)) AS E104,
Cast(Sum(absatz_ksst3) AS DECIMAL(18,0)) AS E106,
Cast(Sum(absatz_ksst4) AS DECIMAL(18,0)) AS E108,
Cast(Sum(absatz_ksst5) AS DECIMAL(18,0)) AS E110,
Cast(Sum(absatz_ksst6) AS DECIMAL(18,0)) AS E112,
Cast(Sum(absatz_ksst7) AS DECIMAL(18,0)) AS E114,
Cast(Sum(absatz_ost_basis) AS DECIMAL(18,0)) AS E130,
Cast(Sum(absatz_ost_gross) AS DECIMAL(18,0)) AS E132,
Cast(Sum(absatz_sued_ost) AS DECIMAL(18,0)) AS E134,
Cast(Sum(absatz_sued_west) AS DECIMAL(18,0)) AS E136,
Cast(Sum(absatz_west) AS DECIMAL(18,0)) AS E138,
Cast(Sum(absatz_nord) AS DECIMAL(18,0)) AS E140,
Cast(CASE
WHEN Sum(absatz_sst1) = 0 THEN null
ELSE Sum(absatz_sst1) END / CASE
WHEN Sum(t1.markt_wochen_sst1) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst1) END AS DECIMAL(18,1)) AS E117,
Cast(CASE
WHEN Sum(absatz_sst2) = 0 THEN null
ELSE Sum(absatz_sst2) END / CASE
WHEN Sum(t1.markt_wochen_sst2) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst2) END AS DECIMAL(18,1))AS E119,
Cast(CASE
WHEN Sum(absatz_sst3) = 0 THEN null
ELSE Sum(absatz_sst3) END / CASE
WHEN Sum(t1.markt_wochen_sst3) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst3) END AS DECIMAL(18,1)) AS E121,
Cast(CASE
WHEN Sum(absatz_sst4) = 0 THEN null
ELSE Sum(absatz_sst4) END / CASE
WHEN Sum(t1.markt_wochen_sst4) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst4) END AS DECIMAL(18,1)) AS E123,
Cast(CASE
WHEN Sum(absatz_sst5) = 0 THEN null
ELSE Sum(absatz_sst5) END / CASE
WHEN Sum(t1.markt_wochen_sst5) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst5) END AS DECIMAL(18,1)) AS E125,
Cast(CASE
WHEN Sum(absatz_sst6) = 0 THEN null
ELSE Sum(absatz_sst6) END / CASE
WHEN Sum(t1.markt_wochen_sst6) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst6) END AS DECIMAL(18,1)) AS E127,
Cast(CASE
WHEN Sum(absatz_sst7) = 0 THEN null
ELSE Sum(absatz_sst7) END / CASE
WHEN Sum(t1.markt_wochen_sst7) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst7) END AS DECIMAL(18,1)) AS E129,
Cast(CASE
WHEN Sum(absatz_ksst1) = 0 THEN null
ELSE Sum(absatz_ksst1) END / CASE
WHEN Sum(t1.markt_wochen_ksst1) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst1) END AS DECIMAL(18,1)) AS E103,
Cast(CASE
WHEN Sum(absatz_ksst2) = 0 THEN null
ELSE Sum(absatz_ksst2) END / CASE
WHEN Sum(t1.markt_wochen_ksst2) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst2) END AS DECIMAL(18,1)) AS E105,
Cast(CASE
WHEN Sum(absatz_ksst3) = 0 THEN null
ELSE Sum(absatz_ksst3) END / CASE
WHEN Sum(t1.markt_wochen_ksst3) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst3) END AS DECIMAL(18,1)) AS E107,
Cast(CASE
WHEN Sum(absatz_ksst4) = 0 THEN null
ELSE Sum(absatz_ksst4) END / CASE
WHEN Sum(t1.markt_wochen_ksst4) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst4) END AS DECIMAL(18,1)) AS E109,
Cast(CASE
WHEN Sum(absatz_ksst5) = 0 THEN null
ELSE Sum(absatz_ksst5) END / CASE
WHEN Sum(t1.markt_wochen_ksst5) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst5) END AS DECIMAL(18,1)) AS E111,
Cast(CASE
WHEN Sum(absatz_ksst6) = 0 THEN null
ELSE Sum(absatz_ksst6) END / CASE
WHEN Sum(t1.markt_wochen_ksst6) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst6) END AS DECIMAL(18,1)) AS E113,
Cast(CASE
WHEN Sum(absatz_ksst7) = 0 THEN null
ELSE Sum(absatz_ksst7) END / CASE
WHEN Sum(t1.markt_wochen_ksst7) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst7) END AS DECIMAL(18,1)) AS E115,
Cast(CASE
WHEN Sum(t1.absatz_ost_basis) = 0 THEN null
ELSE Sum(t1.absatz_ost_basis) END / CASE
WHEN Sum(t1.markt_wochen_ost_basis) = 0 THEN null
ELSE Sum(t1.markt_wochen_ost_basis) END AS DECIMAL(18,1)) AS E131,
Cast(CASE
WHEN Sum(t1.absatz_ost_gross) = 0 THEN null
ELSE Sum(t1.absatz_ost_gross) END / CASE
WHEN Sum(t1.markt_wochen_ost_gross) = 0 THEN null
ELSE Sum(t1.markt_wochen_ost_gross) END AS DECIMAL(18,1)) AS E133,
Cast(CASE
WHEN Sum(t1.absatz_sued_ost) = 0 THEN null
ELSE Sum(t1.absatz_sued_ost) END / CASE
WHEN Sum(t1.markt_wochen_sued_ost) = 0 THEN null
ELSE Sum(t1.markt_wochen_sued_ost) END AS DECIMAL(18,1)) AS E135,
Cast(CASE
WHEN Sum(t1.absatz_sued_west) = 0 THEN null
ELSE Sum(t1.absatz_sued_west) END / CASE
WHEN Sum(t1.markt_wochen_sued_west) = 0 THEN null
ELSE Sum(t1.markt_wochen_sued_west) END AS DECIMAL(18,1)) AS E137,
Cast(CASE
WHEN Sum(t1.absatz_west) = 0 THEN null
ELSE Sum(t1.absatz_west) END / CASE
WHEN Sum(t1.markt_wochen_west) = 0 THEN null
ELSE Sum(t1.markt_wochen_west) END AS DECIMAL(18,1)) AS E139,
Cast(CASE
WHEN Sum(t1.absatz_nord) = 0 THEN null
ELSE Sum(t1.absatz_nord) END / CASE
WHEN Sum(t1.markt_wochen_nord) = 0 THEN null
ELSE Sum(t1.markt_wochen_nord) END AS DECIMAL(18,1)) AS E141,
Cast (Cast(Sum(t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS DEC (18,4)) / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_listung) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_listung) END *100 AS DEC (18,1)) AS  E361,
Cast(Sum(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS E228,
Cast((Sum(kassenumsatz_kl_absolut_netto) - (Sum(rohertrag_ekmep_olk_4n))) / CASE
WHEN Sum(absatz_kl) = 0 THEN null
ELSE Sum(absatz_kl) END AS DECIMAL(18,2)) AS E234,
Cast(CASE
WHEN Sum(t1.absatz_sa_kl) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,1)) AS E262,
Cast((((CASE
WHEN Sum(t1.absatz_sa_kl) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN Sum(t1.absatz_sa_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.absatz_sa_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN Sum(t1.absatz_sa_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E270,
Cast((CASE
WHEN Sum(t1.absatz_sa_kl) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl) END / CASE
WHEN Sum(t1.absatz_kl) = 0 THEN null
ELSE Sum(t1.absatz_kl) END) * 100 AS DECIMAL(18,1)) AS E225,
--,Cast((NullIfZero(Sum(Cast(t1.anz_bons_sa AS DECIMAL(18,4)))) / NullIfZero(Sum(Cast(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E353
--,Cast((NullIfZero(Sum(Cast(t1.anz_bons_af AS DECIMAL(18,4)))) / NullIfZero(Sum(Cast(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E349
--Bons aktuell nicht möglich
NULL AS E349,
NULL AS E353,
Cast(CASE
WHEN (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN null
ELSE (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS E229,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E294,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E298,
Cast((((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END)- CASE
WHEN CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)/(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E302,
Cast((((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E306,
Cast(CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_brutto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_brutto) END / CASE
WHEN Sum(t1.absatz_af_kl) = 0 THEN null
ELSE Sum(t1.absatz_af_kl) END AS DECIMAL(18,2)) AS E373,
Cast((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS E230,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS E231,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS E310,
Cast(((CASE
WHEN Sum(t1.absatz_kl) = 0 THEN null
ELSE Sum(t1.absatz_kl) END - CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) / CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS E223,
Cast(Sum(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS E226,
Cast(CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E278,
Cast((((CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END)- CASE
WHEN CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END END)/(CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto_vj) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E290,
Cast(((CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS E227,
Cast(Sum(t1.kassenumsatz_kl_absolut_brutto) AS DECIMAL(18,0)) AS E274,
Cast(Sum(t1.totalabschriften_wert_netto_absolut) AS DECIMAL(18,0)) AS E232,
Cast(Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) AS DECIMAL(18,0)) AS E314,
Cast((CASE
WHEN Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E318,
Cast((CASE
WHEN Sum(t1.totalabschriften_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E233,
Cast((((CASE
WHEN Sum(t1.totalabschriften_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) - CASE
WHEN CASE
WHEN Sum(t1.totalabschriften_wert_netto_absolut_vj) = 0 THEN null
ELSE Sum(t1.totalabschriften_wert_netto_absolut_vj) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.totalabschriften_wert_netto_absolut_vj) = 0 THEN null
ELSE Sum(t1.totalabschriften_wert_netto_absolut_vj) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END END) / (CASE
WHEN Sum(t1.totalabschriften_wert_netto_absolut_vj) = 0 THEN null
ELSE Sum(t1.totalabschriften_wert_netto_absolut_vj) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E326,
Cast((((CASE
WHEN Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) - CASE
WHEN CASE
WHEN Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0 THEN null
ELSE Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END = 0 THEN null
ELSE CASE
WHEN Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0 THEN null
ELSE Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END END) / (CASE
WHEN Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) = 0 THEN null
ELSE Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut_vj) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E330,
Cast ((Sum(t1.totalabschriften_wert_netto_absolut) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) / CASE
WHEN (Sum(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_wg) END) = 0 THEN null
ELSE (Sum(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_wg) END) END AS DEC (18,2)) AS E322
FROM dbp_msi_v_view.v_tupel_52_wochen_2 t1_2
JOIN dbp_view.v_woche_2 x1
ON t1.kjwo_52 = x1.kjwo
JOIN dbp_view.v_woche_2 x2
ON x1.akt_wo+2 = x2.akt_wo
JOIN dbp_msi_v_view.v_tupel_mat_2 t2
ON t1.mandant_id=t2.mandant_id
AND t1.matching_id=t2.matching_id
AND x2.kjwo = t2.a500_kjwo_update
GROUP BY 1,2,3,4,5,6,7;