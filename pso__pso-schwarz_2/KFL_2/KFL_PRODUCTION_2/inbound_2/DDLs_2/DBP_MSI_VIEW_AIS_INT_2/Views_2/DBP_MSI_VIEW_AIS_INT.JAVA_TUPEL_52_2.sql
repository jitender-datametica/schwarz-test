CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_52_2
(
	MANDANT_ID,
	KJWO_52,
	MATCHING_ID,
	A5,
	A7,
	A9,
	WUG_ID,
	E282,
	E286,
	E224,
	E266,
	E222,
	E116,
	E118,
	E120,
	E122,
	E124,
	E126,
	E128,
	E102,
	E104,
	E106,
	E108,
	E110,
	E112,
	E114,
	E130,
	E132,
	E134,
	E136,
	E138,
	E140,
	E117,
	E119,
	E121,
	E123,
	E125,
	E127,
	E129,
	E103,
	E105,
	E107,
	E109,
	E111,
	E113,
	E115,
	E131,
	E133,
	E135,
	E137,
	E139,
	E141,
	E361,
	E228,
	E234,
	E262,
	E270,
	E225,
	E349,
	E353,
	E229,
	E294,
	E298,
	E302,
	E306,
	E373,
	E230,
	E231,
	E310,
	E223,
	E226,
	E278,
	E290,
	E227,
	E274,
	E232,
	E314,
	E318,
	E233,
	E326,
	E330,
	E322
) 
AS
SELECT
t1.mandant_id,
t1.kjwo_52,
t1.matching_id,
t2.A5_owg_id AS A5,
t2.A7_wg_id AS A7,
CASE WHEN a7_wg_id < 10 THEN '00' || CAST(a7_wg_id AS VARCHAR(3))
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E282,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E286,
CAST(CASE
WHEN SUM(t1.absatz_af_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,1)) AS E224,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)*100 AS DECIMAL(18,1)) AS E266,
CAST(SUM(absatz_kl) AS DECIMAL(18,0)) AS E222,
CAST(SUM(absatz_sst1) AS DECIMAL(18,0)) AS E116,
CAST(SUM(absatz_sst2) AS DECIMAL(18,0)) AS E118,
CAST(SUM(absatz_sst3) AS DECIMAL(18,0)) AS E120,
CAST(SUM(absatz_sst4) AS DECIMAL(18,0)) AS E122,
CAST(SUM(absatz_sst5) AS DECIMAL(18,0)) AS E124,
CAST(SUM(absatz_sst6) AS DECIMAL(18,0)) AS E126,
CAST(SUM(absatz_sst7) AS DECIMAL(18,0)) AS E128,
CAST(SUM(absatz_ksst1) AS DECIMAL(18,0)) AS E102,
CAST(SUM(absatz_ksst2) AS DECIMAL(18,0)) AS E104,
CAST(SUM(absatz_ksst3) AS DECIMAL(18,0)) AS E106,
CAST(SUM(absatz_ksst4) AS DECIMAL(18,0)) AS E108,
CAST(SUM(absatz_ksst5) AS DECIMAL(18,0)) AS E110,
CAST(SUM(absatz_ksst6) AS DECIMAL(18,0)) AS E112,
CAST(SUM(absatz_ksst7) AS DECIMAL(18,0)) AS E114,
CAST(SUM(absatz_ost_basis) AS DECIMAL(18,0)) AS E130,
CAST(SUM(absatz_ost_gross) AS DECIMAL(18,0)) AS E132,
CAST(SUM(absatz_sued_ost) AS DECIMAL(18,0)) AS E134,
CAST(SUM(absatz_sued_west) AS DECIMAL(18,0)) AS E136,
CAST(SUM(absatz_west) AS DECIMAL(18,0)) AS E138,
CAST(SUM(absatz_nord) AS DECIMAL(18,0)) AS E140,
CAST(CASE
WHEN SUM(absatz_sst1) = 0 THEN NULL
ELSE SUM(absatz_sst1) END / CASE
WHEN SUM(t1.markt_wochen_sst1) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst1) END AS DECIMAL(18,1)) AS E117,
CAST(CASE
WHEN SUM(absatz_sst2) = 0 THEN NULL
ELSE SUM(absatz_sst2) END / CASE
WHEN SUM(t1.markt_wochen_sst2) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst2) END AS DECIMAL(18,1))AS E119,
CAST(CASE
WHEN SUM(absatz_sst3) = 0 THEN NULL
ELSE SUM(absatz_sst3) END / CASE
WHEN SUM(t1.markt_wochen_sst3) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst3) END AS DECIMAL(18,1)) AS E121,
CAST(CASE
WHEN SUM(absatz_sst4) = 0 THEN NULL
ELSE SUM(absatz_sst4) END / CASE
WHEN SUM(t1.markt_wochen_sst4) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst4) END AS DECIMAL(18,1)) AS E123,
CAST(CASE
WHEN SUM(absatz_sst5) = 0 THEN NULL
ELSE SUM(absatz_sst5) END / CASE
WHEN SUM(t1.markt_wochen_sst5) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst5) END AS DECIMAL(18,1)) AS E125,
CAST(CASE
WHEN SUM(absatz_sst6) = 0 THEN NULL
ELSE SUM(absatz_sst6) END / CASE
WHEN SUM(t1.markt_wochen_sst6) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst6) END AS DECIMAL(18,1)) AS E127,
CAST(CASE
WHEN SUM(absatz_sst7) = 0 THEN NULL
ELSE SUM(absatz_sst7) END / CASE
WHEN SUM(t1.markt_wochen_sst7) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst7) END AS DECIMAL(18,1)) AS E129,
CAST(CASE
WHEN SUM(absatz_ksst1) = 0 THEN NULL
ELSE SUM(absatz_ksst1) END / CASE
WHEN SUM(t1.markt_wochen_ksst1) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst1) END AS DECIMAL(18,1)) AS E103,
CAST(CASE
WHEN SUM(absatz_ksst2) = 0 THEN NULL
ELSE SUM(absatz_ksst2) END / CASE
WHEN SUM(t1.markt_wochen_ksst2) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst2) END AS DECIMAL(18,1)) AS E105,
CAST(CASE
WHEN SUM(absatz_ksst3) = 0 THEN NULL
ELSE SUM(absatz_ksst3) END / CASE
WHEN SUM(t1.markt_wochen_ksst3) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst3) END AS DECIMAL(18,1)) AS E107,
CAST(CASE
WHEN SUM(absatz_ksst4) = 0 THEN NULL
ELSE SUM(absatz_ksst4) END / CASE
WHEN SUM(t1.markt_wochen_ksst4) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst4) END AS DECIMAL(18,1)) AS E109,
CAST(CASE
WHEN SUM(absatz_ksst5) = 0 THEN NULL
ELSE SUM(absatz_ksst5) END / CASE
WHEN SUM(t1.markt_wochen_ksst5) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst5) END AS DECIMAL(18,1)) AS E111,
CAST(CASE
WHEN SUM(absatz_ksst6) = 0 THEN NULL
ELSE SUM(absatz_ksst6) END / CASE
WHEN SUM(t1.markt_wochen_ksst6) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst6) END AS DECIMAL(18,1)) AS E113,
CAST(CASE
WHEN SUM(absatz_ksst7) = 0 THEN NULL
ELSE SUM(absatz_ksst7) END / CASE
WHEN SUM(t1.markt_wochen_ksst7) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst7) END AS DECIMAL(18,1)) AS E115,
CAST(CASE
WHEN SUM(t1.absatz_ost_basis) = 0 THEN NULL
ELSE SUM(t1.absatz_ost_basis) END / CASE
WHEN SUM(t1.markt_wochen_ost_basis) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ost_basis) END AS DECIMAL(18,1)) AS E131,
CAST(CASE
WHEN SUM(t1.absatz_ost_gross) = 0 THEN NULL
ELSE SUM(t1.absatz_ost_gross) END / CASE
WHEN SUM(t1.markt_wochen_ost_gross) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ost_gross) END AS DECIMAL(18,1)) AS E133,
CAST(CASE
WHEN SUM(t1.absatz_sued_ost) = 0 THEN NULL
ELSE SUM(t1.absatz_sued_ost) END / CASE
WHEN SUM(t1.markt_wochen_sued_ost) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sued_ost) END AS DECIMAL(18,1)) AS E135,
CAST(CASE
WHEN SUM(t1.absatz_sued_west) = 0 THEN NULL
ELSE SUM(t1.absatz_sued_west) END / CASE
WHEN SUM(t1.markt_wochen_sued_west) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sued_west) END AS DECIMAL(18,1)) AS E137,
CAST(CASE
WHEN SUM(t1.absatz_west) = 0 THEN NULL
ELSE SUM(t1.absatz_west) END / CASE
WHEN SUM(t1.markt_wochen_west) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_west) END AS DECIMAL(18,1)) AS E139,
CAST(CASE
WHEN SUM(t1.absatz_nord) = 0 THEN NULL
ELSE SUM(t1.absatz_nord) END / CASE
WHEN SUM(t1.markt_wochen_nord) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_nord) END AS DECIMAL(18,1)) AS E141,
CAST (CAST(SUM(t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS DEC (18,4)) / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_listung) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_listung) END *100 AS DEC (18,1)) AS  E361,
CAST(SUM(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS E228,
CAST((SUM(kassenumsatz_kl_absolut_netto) - (SUM(rohertrag_ekmep_olk_4n))) / CASE
WHEN SUM(absatz_kl) = 0 THEN NULL
ELSE SUM(absatz_kl) END AS DECIMAL(18,2)) AS E234,
CAST(CASE
WHEN SUM(t1.absatz_sa_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,1)) AS E262,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E270,
CAST((CASE
WHEN SUM(t1.absatz_sa_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl) END / CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END) * 100 AS DECIMAL(18,1)) AS E225,
--,CAST((NULLIfZero(SUM(CAST(t1.anz_bons_sa AS DECIMAL(18,4)))) / NULLIfZero(SUM(CAST(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E353
--,CAST((NULLIfZero(SUM(CAST(t1.anz_bons_af AS DECIMAL(18,4)))) / NULLIfZero(SUM(CAST(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E349
--Bons aktuell nicht möglich
NULL AS E349,
NULL AS E353,
CAST(CASE
WHEN (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN NULL
ELSE (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS E229,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E294,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E298,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E302,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E306,
CAST(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_brutto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_brutto) END / CASE
WHEN SUM(t1.absatz_af_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl) END AS DECIMAL(18,2)) AS E373,
CAST((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS E230,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS E231,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS E310,
CAST(((CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END - CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) / CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS E223,
CAST(SUM(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS E226,
CAST(CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E278,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E290,
CAST(((CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS E227,
CAST(SUM(t1.kassenumsatz_kl_absolut_brutto) AS DECIMAL(18,0)) AS E274,
CAST(SUM(t1.totalabschriften_wert_netto_absolut) AS DECIMAL(18,0)) AS E232,
CAST(SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) AS DECIMAL(18,0)) AS E314,
CAST((CASE
WHEN SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E318,
CAST((CASE
WHEN SUM(t1.totalabschriften_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E233,
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
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E326,
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
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E330,
CAST ((SUM(t1.totalabschriften_wert_netto_absolut) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) / CASE
WHEN (SUM(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_wg) END) = 0 THEN NULL
ELSE (SUM(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_wg) END) END AS DEC (18,2)) AS E322
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