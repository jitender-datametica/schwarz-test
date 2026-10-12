CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_tupel_13_1
AS
SELECT
t1.mandant_id,
t1.kjwo_13,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E284,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E288,
Cast(CASE
WHEN Sum(t1.absatz_af_kl) = 0 THEN null
ELSE Sum(t1.absatz_af_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,1)) AS E250,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)*100 AS DECIMAL(18,1)) AS E268,
Cast(Sum(absatz_kl) AS DECIMAL(18,0)) AS E248,
Cast(Sum(absatz_sst1) AS DECIMAL(18,0)) AS E196,
Cast(Sum(absatz_sst2) AS DECIMAL(18,0)) AS E198,
Cast(Sum(absatz_sst3) AS DECIMAL(18,0)) AS E200,
Cast(Sum(absatz_sst4) AS DECIMAL(18,0)) AS E202,
Cast(Sum(absatz_sst5) AS DECIMAL(18,0)) AS E204,
Cast(Sum(absatz_sst6) AS DECIMAL(18,0)) AS E206,
Cast(Sum(absatz_sst7) AS DECIMAL(18,0)) AS E208,
Cast(Sum(absatz_ksst1) AS DECIMAL(18,0)) AS E182,
Cast(Sum(absatz_ksst2) AS DECIMAL(18,0)) AS E184,
Cast(Sum(absatz_ksst3) AS DECIMAL(18,0)) AS E186,
Cast(Sum(absatz_ksst4) AS DECIMAL(18,0)) AS E188,
Cast(Sum(absatz_ksst5) AS DECIMAL(18,0)) AS E190,
Cast(Sum(absatz_ksst6) AS DECIMAL(18,0)) AS E192,
Cast(Sum(absatz_ksst7) AS DECIMAL(18,0)) AS E194,
Cast(Sum(absatz_ost_basis) AS DECIMAL(18,0)) AS E210,
Cast(Sum(absatz_ost_gross) AS DECIMAL(18,0)) AS E212,
Cast(Sum(absatz_sued_ost) AS DECIMAL(18,0)) AS E214,
Cast(Sum(absatz_sued_west) AS DECIMAL(18,0)) AS E216,
Cast(Sum(absatz_west) AS DECIMAL(18,0)) AS E218,
Cast(Sum(absatz_nord) AS DECIMAL(18,0)) AS E220,
Cast(CASE
WHEN Sum(absatz_sst1) = 0 THEN null
ELSE Sum(absatz_sst1) END / CASE
WHEN Sum(t1.markt_wochen_sst1) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst1) END AS DECIMAL(18,1)) AS E197,
Cast(CASE
WHEN Sum(absatz_sst2) = 0 THEN null
ELSE Sum(absatz_sst2) END / CASE
WHEN Sum(t1.markt_wochen_sst2) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst2) END AS DECIMAL(18,1))AS E199,
Cast(CASE
WHEN Sum(absatz_sst3) = 0 THEN null
ELSE Sum(absatz_sst3) END / CASE
WHEN Sum(t1.markt_wochen_sst3) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst3) END AS DECIMAL(18,1)) AS E201,
Cast(CASE
WHEN Sum(absatz_sst4) = 0 THEN null
ELSE Sum(absatz_sst4) END / CASE
WHEN Sum(t1.markt_wochen_sst4) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst4) END AS DECIMAL(18,1)) AS E203,
Cast(CASE
WHEN Sum(absatz_sst5) = 0 THEN null
ELSE Sum(absatz_sst5) END / CASE
WHEN Sum(t1.markt_wochen_sst5) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst5) END AS DECIMAL(18,1)) AS E205,
Cast(CASE
WHEN Sum(absatz_sst6) = 0 THEN null
ELSE Sum(absatz_sst6) END / CASE
WHEN Sum(t1.markt_wochen_sst6) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst6) END AS DECIMAL(18,1)) AS E207,
Cast(CASE
WHEN Sum(absatz_sst7) = 0 THEN null
ELSE Sum(absatz_sst7) END / CASE
WHEN Sum(t1.markt_wochen_sst7) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst7) END AS DECIMAL(18,1)) AS E209,
Cast(CASE
WHEN Sum(absatz_ksst1) = 0 THEN null
ELSE Sum(absatz_ksst1) END / CASE
WHEN Sum(t1.markt_wochen_ksst1) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst1) END AS DECIMAL(18,1)) AS E183,
Cast(CASE
WHEN Sum(absatz_ksst2) = 0 THEN null
ELSE Sum(absatz_ksst2) END / CASE
WHEN Sum(t1.markt_wochen_ksst2) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst2) END AS DECIMAL(18,1)) AS E185,
Cast(CASE
WHEN Sum(absatz_ksst3) = 0 THEN null
ELSE Sum(absatz_ksst3) END / CASE
WHEN Sum(t1.markt_wochen_ksst3) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst3) END AS DECIMAL(18,1)) AS E187,
Cast(CASE
WHEN Sum(absatz_ksst4) = 0 THEN null
ELSE Sum(absatz_ksst4) END / CASE
WHEN Sum(t1.markt_wochen_ksst4) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst4) END AS DECIMAL(18,1)) AS E189,
Cast(CASE
WHEN Sum(absatz_ksst5) = 0 THEN null
ELSE Sum(absatz_ksst5) END / CASE
WHEN Sum(t1.markt_wochen_ksst5) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst5) END AS DECIMAL(18,1)) AS E191,
Cast(CASE
WHEN Sum(absatz_ksst6) = 0 THEN null
ELSE Sum(absatz_ksst6) END / CASE
WHEN Sum(t1.markt_wochen_ksst6) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst6) END AS DECIMAL(18,1)) AS E193,
Cast(CASE
WHEN Sum(absatz_ksst7) = 0 THEN null
ELSE Sum(absatz_ksst7) END / CASE
WHEN Sum(t1.markt_wochen_ksst7) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst7) END AS DECIMAL(18,1)) AS E195,
Cast(CASE
WHEN Sum(t1.absatz_ost_basis) = 0 THEN null
ELSE Sum(t1.absatz_ost_basis) END / CASE
WHEN Sum(t1.markt_wochen_ost_basis) = 0 THEN null
ELSE Sum(t1.markt_wochen_ost_basis) END AS DECIMAL(18,1)) AS E211,
Cast(CASE
WHEN Sum(t1.absatz_ost_gross) = 0 THEN null
ELSE Sum(t1.absatz_ost_gross) END / CASE
WHEN Sum(t1.markt_wochen_ost_gross) = 0 THEN null
ELSE Sum(t1.markt_wochen_ost_gross) END AS DECIMAL(18,1)) AS E213,
Cast(CASE
WHEN Sum(t1.absatz_sued_ost) = 0 THEN null
ELSE Sum(t1.absatz_sued_ost) END / CASE
WHEN Sum(t1.markt_wochen_sued_ost) = 0 THEN null
ELSE Sum(t1.markt_wochen_sued_ost) END AS DECIMAL(18,1)) AS E215,
Cast(CASE
WHEN Sum(t1.absatz_sued_west) = 0 THEN null
ELSE Sum(t1.absatz_sued_west) END / CASE
WHEN Sum(t1.markt_wochen_sued_west) = 0 THEN null
ELSE Sum(t1.markt_wochen_sued_west) END AS DECIMAL(18,1)) AS E217,
Cast(CASE
WHEN Sum(t1.absatz_west) = 0 THEN null
ELSE Sum(t1.absatz_west) END / CASE
WHEN Sum(t1.markt_wochen_west) = 0 THEN null
ELSE Sum(t1.markt_wochen_west) END AS DECIMAL(18,1)) AS E219,
Cast(CASE
WHEN Sum(t1.absatz_nord) = 0 THEN null
ELSE Sum(t1.absatz_nord) END / CASE
WHEN Sum(t1.markt_wochen_nord) = 0 THEN null
ELSE Sum(t1.markt_wochen_nord) END AS DECIMAL(18,1)) AS E221,
Cast (Cast(Sum(t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS DEC (18,4)) / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_listung) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_listung) END *100 AS DEC (18,1)) AS E363,
Cast(Sum(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS E254,
Cast((Sum(kassenumsatz_kl_absolut_netto) - (Sum(rohertrag_ekmep_olk_4n))) / CASE
WHEN Sum(absatz_kl) = 0 THEN null
ELSE Sum(absatz_kl) END AS DECIMAL(18,2)) AS E260,
Cast(CASE
WHEN Sum(t1.absatz_sa_kl) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,1)) AS E264,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E272,
Cast((CASE
WHEN Sum(t1.absatz_sa_kl) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl) END / CASE
WHEN Sum(t1.absatz_kl) = 0 THEN null
ELSE Sum(t1.absatz_kl) END) * 100 AS DECIMAL(18,1)) AS E251,
--,Cast((NullIfZero(Sum(Cast(t1.anz_bons_sa AS DECIMAL(18,4)))) / NullIfZero(Sum(Cast(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E355
--,Cast((NullIfZero(Sum(Cast(t1.anz_bons_af AS DECIMAL(18,4)))) / NullIfZero(Sum(Cast(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E351
--Bons aktuell nicht möglich
NULL AS E351,
NULL AS E355,
Cast(CASE
WHEN (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN null
ELSE (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS E255,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E296,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E300,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E304,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E308,
Cast(CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_brutto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_brutto) END / CASE
WHEN Sum(t1.absatz_af_kl) = 0 THEN null
ELSE Sum(t1.absatz_af_kl) END AS DECIMAL(18,2)) AS E375,
Cast((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS E256,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS E257,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS E312,
Cast(((CASE
WHEN Sum(t1.absatz_kl) = 0 THEN null
ELSE Sum(t1.absatz_kl) END - CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) / CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS E249,
Cast(Sum(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS E252,
Cast(CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E280,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E292,
Cast(((CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS E253,
Cast(Sum(t1.kassenumsatz_kl_absolut_brutto) AS DECIMAL(18,0)) AS E276,
Cast(Sum(t1.totalabschriften_wert_netto_absolut) AS DECIMAL(18,0)) AS E258,
Cast(Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) AS DECIMAL(18,0)) AS E316,
Cast((CASE
WHEN Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E320,
Cast((CASE
WHEN Sum(t1.totalabschriften_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E259,
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
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E328,
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
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E332,
Cast ((Sum(t1.totalabschriften_wert_netto_absolut) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) / CASE
WHEN (Sum(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_wg) END) = 0 THEN null
ELSE (Sum(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_wg) END) END AS DEC (18,2)) AS E324
FROM dbp_msi_v_view.v_tupel_13_wochen_1 t1_1
JOIN dbp_view.v_woche_1 x1
ON t1.kjwo_13 = x1.kjwo
JOIN dbp_view.v_woche_1 x2
ON x1.akt_wo+2 = x2.akt_wo
JOIN dbp_msi_v_view.v_tupel_mat_1 t2
ON t1.mandant_id=t2.mandant_id
AND t1.matching_id=t2.matching_id
AND x2.kjwo = t2.a500_kjwo_update
GROUP BY 1,2,3,4,5,6,7;