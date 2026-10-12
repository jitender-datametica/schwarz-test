CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_tupel_26_2
AS
SELECT
t1.mandant_id,
t1.kjwo_26,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E283,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E287,
Cast(CASE
WHEN Sum(t1.absatz_af_kl) = 0 THEN null
ELSE Sum(t1.absatz_af_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,1)) AS E237,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)*100 AS DECIMAL(18,1)) AS E267,
Cast(Sum(absatz_kl) AS DECIMAL(18,0)) AS E235,
Cast(Sum(absatz_sst1) AS DECIMAL(18,0)) AS E156,
Cast(Sum(absatz_sst2) AS DECIMAL(18,0)) AS E158,
Cast(Sum(absatz_sst3) AS DECIMAL(18,0)) AS E160,
Cast(Sum(absatz_sst4) AS DECIMAL(18,0)) AS E162,
Cast(Sum(absatz_sst5) AS DECIMAL(18,0)) AS E164,
Cast(Sum(absatz_sst6) AS DECIMAL(18,0)) AS E166,
Cast(Sum(absatz_sst7) AS DECIMAL(18,0)) AS E168,
Cast(Sum(absatz_ksst1) AS DECIMAL(18,0)) AS E142,
Cast(Sum(absatz_ksst2) AS DECIMAL(18,0)) AS E144,
Cast(Sum(absatz_ksst3) AS DECIMAL(18,0)) AS E146,
Cast(Sum(absatz_ksst4) AS DECIMAL(18,0)) AS E148,
Cast(Sum(absatz_ksst5) AS DECIMAL(18,0)) AS E150,
Cast(Sum(absatz_ksst6) AS DECIMAL(18,0)) AS E152,
Cast(Sum(absatz_ksst7) AS DECIMAL(18,0)) AS E154,
Cast(Sum(absatz_ost_basis) AS DECIMAL(18,0)) AS E170,
Cast(Sum(absatz_ost_gross) AS DECIMAL(18,0)) AS E172,
Cast(Sum(absatz_sued_ost) AS DECIMAL(18,0)) AS E174,
Cast(Sum(absatz_sued_west) AS DECIMAL(18,0)) AS E176,
Cast(Sum(absatz_west) AS DECIMAL(18,0)) AS E178,
Cast(Sum(absatz_nord) AS DECIMAL(18,0)) AS E180,
Cast(CASE
WHEN Sum(absatz_sst1) = 0 THEN null
ELSE Sum(absatz_sst1) END / CASE
WHEN Sum(t1.markt_wochen_sst1) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst1) END AS DECIMAL(18,1)) AS E157,
Cast(CASE
WHEN Sum(absatz_sst2) = 0 THEN null
ELSE Sum(absatz_sst2) END / CASE
WHEN Sum(t1.markt_wochen_sst2) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst2) END AS DECIMAL(18,1))AS E159,
Cast(CASE
WHEN Sum(absatz_sst3) = 0 THEN null
ELSE Sum(absatz_sst3) END / CASE
WHEN Sum(t1.markt_wochen_sst3) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst3) END AS DECIMAL(18,1)) AS E161,
Cast(CASE
WHEN Sum(absatz_sst4) = 0 THEN null
ELSE Sum(absatz_sst4) END / CASE
WHEN Sum(t1.markt_wochen_sst4) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst4) END AS DECIMAL(18,1)) AS E163,
Cast(CASE
WHEN Sum(absatz_sst5) = 0 THEN null
ELSE Sum(absatz_sst5) END / CASE
WHEN Sum(t1.markt_wochen_sst5) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst5) END AS DECIMAL(18,1)) AS E165,
Cast(CASE
WHEN Sum(absatz_sst6) = 0 THEN null
ELSE Sum(absatz_sst6) END / CASE
WHEN Sum(t1.markt_wochen_sst6) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst6) END AS DECIMAL(18,1)) AS E167,
Cast(CASE
WHEN Sum(absatz_sst7) = 0 THEN null
ELSE Sum(absatz_sst7) END / CASE
WHEN Sum(t1.markt_wochen_sst7) = 0 THEN null
ELSE Sum(t1.markt_wochen_sst7) END AS DECIMAL(18,1)) AS E169,
Cast(CASE
WHEN Sum(absatz_ksst1) = 0 THEN null
ELSE Sum(absatz_ksst1) END / CASE
WHEN Sum(t1.markt_wochen_ksst1) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst1) END AS DECIMAL(18,1)) AS E143,
Cast(CASE
WHEN Sum(absatz_ksst2) = 0 THEN null
ELSE Sum(absatz_ksst2) END / CASE
WHEN Sum(t1.markt_wochen_ksst2) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst2) END AS DECIMAL(18,1)) AS E145,
Cast(CASE
WHEN Sum(absatz_ksst3) = 0 THEN null
ELSE Sum(absatz_ksst3) END / CASE
WHEN Sum(t1.markt_wochen_ksst3) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst3) END AS DECIMAL(18,1)) AS E147,
Cast(CASE
WHEN Sum(absatz_ksst4) = 0 THEN null
ELSE Sum(absatz_ksst4) END / CASE
WHEN Sum(t1.markt_wochen_ksst4) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst4) END AS DECIMAL(18,1)) AS E149,
Cast(CASE
WHEN Sum(absatz_ksst5) = 0 THEN null
ELSE Sum(absatz_ksst5) END / CASE
WHEN Sum(t1.markt_wochen_ksst5) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst5) END AS DECIMAL(18,1)) AS E151,
Cast(CASE
WHEN Sum(absatz_ksst6) = 0 THEN null
ELSE Sum(absatz_ksst6) END / CASE
WHEN Sum(t1.markt_wochen_ksst6) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst6) END AS DECIMAL(18,1)) AS E153,
Cast(CASE
WHEN Sum(absatz_ksst7) = 0 THEN null
ELSE Sum(absatz_ksst7) END / CASE
WHEN Sum(t1.markt_wochen_ksst7) = 0 THEN null
ELSE Sum(t1.markt_wochen_ksst7) END AS DECIMAL(18,1)) AS E155,
Cast(CASE
WHEN Sum(t1.absatz_ost_basis) = 0 THEN null
ELSE Sum(t1.absatz_ost_basis) END / CASE
WHEN Sum(t1.markt_wochen_ost_basis) = 0 THEN null
ELSE Sum(t1.markt_wochen_ost_basis) END AS DECIMAL(18,1)) AS E171,
Cast(CASE
WHEN Sum(t1.absatz_ost_gross) = 0 THEN null
ELSE Sum(t1.absatz_ost_gross) END / CASE
WHEN Sum(t1.markt_wochen_ost_gross) = 0 THEN null
ELSE Sum(t1.markt_wochen_ost_gross) END AS DECIMAL(18,1)) AS E173,
Cast(CASE
WHEN Sum(t1.absatz_sued_ost) = 0 THEN null
ELSE Sum(t1.absatz_sued_ost) END / CASE
WHEN Sum(t1.markt_wochen_sued_ost) = 0 THEN null
ELSE Sum(t1.markt_wochen_sued_ost) END AS DECIMAL(18,1)) AS E175,
Cast(CASE
WHEN Sum(t1.absatz_sued_west) = 0 THEN null
ELSE Sum(t1.absatz_sued_west) END / CASE
WHEN Sum(t1.markt_wochen_sued_west) = 0 THEN null
ELSE Sum(t1.markt_wochen_sued_west) END AS DECIMAL(18,1)) AS E177,
Cast(CASE
WHEN Sum(t1.absatz_west) = 0 THEN null
ELSE Sum(t1.absatz_west) END / CASE
WHEN Sum(t1.markt_wochen_west) = 0 THEN null
ELSE Sum(t1.markt_wochen_west) END AS DECIMAL(18,1)) AS E179,
Cast(CASE
WHEN Sum(t1.absatz_nord) = 0 THEN null
ELSE Sum(t1.absatz_nord) END / CASE
WHEN Sum(t1.markt_wochen_nord) = 0 THEN null
ELSE Sum(t1.markt_wochen_nord) END AS DECIMAL(18,1)) AS E181,
Cast (Cast(Sum(t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS DEC (18,4)) / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_listung) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_listung) END *100 AS DEC (18,1)) AS E362,
Cast(Sum(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS E241,
Cast((Sum(kassenumsatz_kl_absolut_netto) - (Sum(rohertrag_ekmep_olk_4n))) / CASE
WHEN Sum(absatz_kl) = 0 THEN null
ELSE Sum(absatz_kl) END AS DECIMAL(18,2)) AS E247,
Cast(CASE
WHEN Sum(t1.absatz_sa_kl) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,1)) AS E263,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E271,
Cast((CASE
WHEN Sum(t1.absatz_sa_kl) = 0 THEN null
ELSE Sum(t1.absatz_sa_kl) END / CASE
WHEN Sum(t1.absatz_kl) = 0 THEN null
ELSE Sum(t1.absatz_kl) END) * 100 AS DECIMAL(18,1)) AS E238,
--,Cast((NullIfZero(Sum(Cast(t1.anz_bons_sa AS DECIMAL(18,4)))) / NullIfZero(Sum(Cast(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E354
--,Cast((NullIfZero(Sum(Cast(t1.anz_bons_af AS DECIMAL(18,4)))) / NullIfZero(Sum(Cast(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E350
--Bons aktuell nicht möglich
NULL AS E350,
NULL AS E354,
Cast(CASE
WHEN (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN null
ELSE (Sum(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS E242,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E295,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E299,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E303,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E307,
Cast(CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_brutto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_brutto) END / CASE
WHEN Sum(t1.absatz_af_kl) = 0 THEN null
ELSE Sum(t1.absatz_af_kl) END AS DECIMAL(18,2)) AS E374,
Cast((CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS E243,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN Sum(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS E244,
Cast(CASE
WHEN Sum(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN null
ELSE Sum(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS E311,
Cast(((CASE
WHEN Sum(t1.absatz_kl) = 0 THEN null
ELSE Sum(t1.absatz_kl) END - CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) / CASE
WHEN Sum(t1.absatz_kl_vj) = 0 THEN null
ELSE Sum(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS E236,
Cast(Sum(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS E239,
Cast(CASE
WHEN Sum(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN null
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E279,
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
ELSE Sum(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E291,
Cast(((CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS E240,
Cast(Sum(t1.kassenumsatz_kl_absolut_brutto) AS DECIMAL(18,0)) AS E275,
Cast(Sum(t1.totalabschriften_wert_netto_absolut) AS DECIMAL(18,0)) AS E245,
Cast(Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) AS DECIMAL(18,0)) AS E315,
Cast((CASE
WHEN Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E319,
Cast((CASE
WHEN Sum(t1.totalabschriften_wert_netto_absolut) = 0 THEN null
ELSE Sum(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E246,
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
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E327,
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
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E331,
Cast ((Sum(t1.totalabschriften_wert_netto_absolut) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto) END) / CASE
WHEN (Sum(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_wg) END) = 0 THEN null
ELSE (Sum(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN Sum(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN null
ELSE Sum(t1.kassenumsatz_kl_absolut_netto_wg) END) END AS DEC (18,2)) AS E323
FROM dbp_msi_v_view.v_tupel_26_wochen_2 t1_2
JOIN dbp_view.v_woche_2 x1
ON t1.kjwo_26 = x1.kjwo
JOIN dbp_view.v_woche_2 x2
ON x1.akt_wo+2 = x2.akt_wo
JOIN dbp_msi_v_view.v_tupel_mat_2 t2
ON t1.mandant_id=t2.mandant_id
AND t1.matching_id=t2.matching_id
AND x2.kjwo = t2.a500_kjwo_update
GROUP BY 1,2,3,4,5,6,7;