CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_13_2
(
	MANDANT_ID,
	KJWO_13,
	MATCHING_ID,
	A5,
	A7,
	A9,
	WUG_ID,
	E284,
	E288,
	E250,
	E268,
	E248,
	E196,
	E198,
	E200,
	E202,
	E204,
	E206,
	E208,
	E182,
	E184,
	E186,
	E188,
	E190,
	E192,
	E194,
	E210,
	E212,
	E214,
	E216,
	E218,
	E220,
	E197,
	E199,
	E201,
	E203,
	E205,
	E207,
	E209,
	E183,
	E185,
	E187,
	E189,
	E191,
	E193,
	E195,
	E211,
	E213,
	E215,
	E217,
	E219,
	E221,
	E363,
	E254,
	E260,
	E264,
	E272,
	E251,
	E351,
	E355,
	E255,
	E296,
	E300,
	E304,
	E308,
	E375,
	E256,
	E257,
	E312,
	E249,
	E252,
	E280,
	E292,
	E253,
	E276,
	E258,
	E316,
	E320,
	E259,
	E328,
	E332,
	E324
) 
AS
SELECT
t1.mandant_id,
t1.kjwo_13,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E284,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E288,
CAST(CASE
WHEN SUM(t1.absatz_af_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,1)) AS E250,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END END)*100 AS DECIMAL(18,1)) AS E268,
CAST(SUM(absatz_kl) AS DECIMAL(18,0)) AS E248,
CAST(SUM(absatz_sst1) AS DECIMAL(18,0)) AS E196,
CAST(SUM(absatz_sst2) AS DECIMAL(18,0)) AS E198,
CAST(SUM(absatz_sst3) AS DECIMAL(18,0)) AS E200,
CAST(SUM(absatz_sst4) AS DECIMAL(18,0)) AS E202,
CAST(SUM(absatz_sst5) AS DECIMAL(18,0)) AS E204,
CAST(SUM(absatz_sst6) AS DECIMAL(18,0)) AS E206,
CAST(SUM(absatz_sst7) AS DECIMAL(18,0)) AS E208,
CAST(SUM(absatz_ksst1) AS DECIMAL(18,0)) AS E182,
CAST(SUM(absatz_ksst2) AS DECIMAL(18,0)) AS E184,
CAST(SUM(absatz_ksst3) AS DECIMAL(18,0)) AS E186,
CAST(SUM(absatz_ksst4) AS DECIMAL(18,0)) AS E188,
CAST(SUM(absatz_ksst5) AS DECIMAL(18,0)) AS E190,
CAST(SUM(absatz_ksst6) AS DECIMAL(18,0)) AS E192,
CAST(SUM(absatz_ksst7) AS DECIMAL(18,0)) AS E194,
CAST(SUM(absatz_ost_basis) AS DECIMAL(18,0)) AS E210,
CAST(SUM(absatz_ost_gross) AS DECIMAL(18,0)) AS E212,
CAST(SUM(absatz_sued_ost) AS DECIMAL(18,0)) AS E214,
CAST(SUM(absatz_sued_west) AS DECIMAL(18,0)) AS E216,
CAST(SUM(absatz_west) AS DECIMAL(18,0)) AS E218,
CAST(SUM(absatz_nord) AS DECIMAL(18,0)) AS E220,
CAST(CASE
WHEN SUM(absatz_sst1) = 0 THEN NULL
ELSE SUM(absatz_sst1) END / CASE
WHEN SUM(t1.markt_wochen_sst1) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst1) END AS DECIMAL(18,1)) AS E197,
CAST(CASE
WHEN SUM(absatz_sst2) = 0 THEN NULL
ELSE SUM(absatz_sst2) END / CASE
WHEN SUM(t1.markt_wochen_sst2) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst2) END AS DECIMAL(18,1))AS E199,
CAST(CASE
WHEN SUM(absatz_sst3) = 0 THEN NULL
ELSE SUM(absatz_sst3) END / CASE
WHEN SUM(t1.markt_wochen_sst3) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst3) END AS DECIMAL(18,1)) AS E201,
CAST(CASE
WHEN SUM(absatz_sst4) = 0 THEN NULL
ELSE SUM(absatz_sst4) END / CASE
WHEN SUM(t1.markt_wochen_sst4) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst4) END AS DECIMAL(18,1)) AS E203,
CAST(CASE
WHEN SUM(absatz_sst5) = 0 THEN NULL
ELSE SUM(absatz_sst5) END / CASE
WHEN SUM(t1.markt_wochen_sst5) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst5) END AS DECIMAL(18,1)) AS E205,
CAST(CASE
WHEN SUM(absatz_sst6) = 0 THEN NULL
ELSE SUM(absatz_sst6) END / CASE
WHEN SUM(t1.markt_wochen_sst6) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst6) END AS DECIMAL(18,1)) AS E207,
CAST(CASE
WHEN SUM(absatz_sst7) = 0 THEN NULL
ELSE SUM(absatz_sst7) END / CASE
WHEN SUM(t1.markt_wochen_sst7) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sst7) END AS DECIMAL(18,1)) AS E209,
CAST(CASE
WHEN SUM(absatz_ksst1) = 0 THEN NULL
ELSE SUM(absatz_ksst1) END / CASE
WHEN SUM(t1.markt_wochen_ksst1) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst1) END AS DECIMAL(18,1)) AS E183,
CAST(CASE
WHEN SUM(absatz_ksst2) = 0 THEN NULL
ELSE SUM(absatz_ksst2) END / CASE
WHEN SUM(t1.markt_wochen_ksst2) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst2) END AS DECIMAL(18,1)) AS E185,
CAST(CASE
WHEN SUM(absatz_ksst3) = 0 THEN NULL
ELSE SUM(absatz_ksst3) END / CASE
WHEN SUM(t1.markt_wochen_ksst3) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst3) END AS DECIMAL(18,1)) AS E187,
CAST(CASE
WHEN SUM(absatz_ksst4) = 0 THEN NULL
ELSE SUM(absatz_ksst4) END / CASE
WHEN SUM(t1.markt_wochen_ksst4) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst4) END AS DECIMAL(18,1)) AS E189,
CAST(CASE
WHEN SUM(absatz_ksst5) = 0 THEN NULL
ELSE SUM(absatz_ksst5) END / CASE
WHEN SUM(t1.markt_wochen_ksst5) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst5) END AS DECIMAL(18,1)) AS E191,
CAST(CASE
WHEN SUM(absatz_ksst6) = 0 THEN NULL
ELSE SUM(absatz_ksst6) END / CASE
WHEN SUM(t1.markt_wochen_ksst6) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst6) END AS DECIMAL(18,1)) AS E193,
CAST(CASE
WHEN SUM(absatz_ksst7) = 0 THEN NULL
ELSE SUM(absatz_ksst7) END / CASE
WHEN SUM(t1.markt_wochen_ksst7) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ksst7) END AS DECIMAL(18,1)) AS E195,
CAST(CASE
WHEN SUM(t1.absatz_ost_basis) = 0 THEN NULL
ELSE SUM(t1.absatz_ost_basis) END / CASE
WHEN SUM(t1.markt_wochen_ost_basis) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ost_basis) END AS DECIMAL(18,1)) AS E211,
CAST(CASE
WHEN SUM(t1.absatz_ost_gross) = 0 THEN NULL
ELSE SUM(t1.absatz_ost_gross) END / CASE
WHEN SUM(t1.markt_wochen_ost_gross) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_ost_gross) END AS DECIMAL(18,1)) AS E213,
CAST(CASE
WHEN SUM(t1.absatz_sued_ost) = 0 THEN NULL
ELSE SUM(t1.absatz_sued_ost) END / CASE
WHEN SUM(t1.markt_wochen_sued_ost) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sued_ost) END AS DECIMAL(18,1)) AS E215,
CAST(CASE
WHEN SUM(t1.absatz_sued_west) = 0 THEN NULL
ELSE SUM(t1.absatz_sued_west) END / CASE
WHEN SUM(t1.markt_wochen_sued_west) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_sued_west) END AS DECIMAL(18,1)) AS E217,
CAST(CASE
WHEN SUM(t1.absatz_west) = 0 THEN NULL
ELSE SUM(t1.absatz_west) END / CASE
WHEN SUM(t1.markt_wochen_west) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_west) END AS DECIMAL(18,1)) AS E219,
CAST(CASE
WHEN SUM(t1.absatz_nord) = 0 THEN NULL
ELSE SUM(t1.absatz_nord) END / CASE
WHEN SUM(t1.markt_wochen_nord) = 0 THEN NULL
ELSE SUM(t1.markt_wochen_nord) END AS DECIMAL(18,1)) AS E221,
CAST (CAST(SUM(t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS DEC (18,4)) / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_listung) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_listung) END *100 AS DEC (18,1)) AS E363,
CAST(SUM(rohertrag_ekmep_olk_4n) AS DECIMAL(18,0)) AS E254,
CAST((SUM(kassenumsatz_kl_absolut_netto) - (SUM(rohertrag_ekmep_olk_4n))) / CASE
WHEN SUM(absatz_kl) = 0 THEN NULL
ELSE SUM(absatz_kl) END AS DECIMAL(18,2)) AS E260,
CAST(CASE
WHEN SUM(t1.absatz_sa_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,1)) AS E264,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E272,
CAST((CASE
WHEN SUM(t1.absatz_sa_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_sa_kl) END / CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END) * 100 AS DECIMAL(18,1)) AS E251,
--,CAST((NULLIfZero(SUM(CAST(t1.anz_bons_sa AS DECIMAL(18,4)))) / NULLIfZero(SUM(CAST(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E355
--,CAST((NULLIfZero(SUM(CAST(t1.anz_bons_af AS DECIMAL(18,4)))) / NULLIfZero(SUM(CAST(t1.anz_bons_gesamt AS DECIMAL(18,4))))) AS DECIMAL(18,4)) AS E351
--Bons aktuell nicht möglich
NULL AS E351,
NULL AS E355,
CAST(CASE
WHEN (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END = 0 THEN NULL
ELSE (SUM(t1.rohertrag_ekmep_olk_4n)) - CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END END / CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_vj) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_vj) END *100 AS DECIMAL(18,1)) AS E255,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af) END AS DECIMAL(18,2)) AS E296,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E300,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_af_vj) END))*100 AS DECIMAL(18,1)) AS E304,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E308,
CAST(CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_brutto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_brutto) END / CASE
WHEN SUM(t1.absatz_af_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_af_kl) END AS DECIMAL(18,2)) AS E375,
CAST((CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,2)) AS E256,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_af) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_af) END / CASE
WHEN SUM(t1.kassenumsatz_af_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_af_kl_absolut_netto) END AS DECIMAL(18,2)) AS E257,
CAST(CASE
WHEN SUM(t1.rohertrag_ekmep_olk_4n_sa) = 0 THEN NULL
ELSE SUM(t1.rohertrag_ekmep_olk_4n_sa) END / CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END AS DECIMAL(18,2)) AS E312,
CAST(((CASE
WHEN SUM(t1.absatz_kl) = 0 THEN NULL
ELSE SUM(t1.absatz_kl) END - CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) / CASE
WHEN SUM(t1.absatz_kl_vj) = 0 THEN NULL
ELSE SUM(t1.absatz_kl_vj) END) * 100 AS DECIMAL(18,1)) AS E249,
CAST(SUM(kassenumsatz_kl_absolut_netto) AS DECIMAL(18,0)) AS E252,
CAST(CASE
WHEN SUM(t1.kassenumsatz_sa_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_sa_kl_absolut_netto) END / CASE
WHEN SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) = 0 THEN NULL
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa) END AS DECIMAL(18,2)) AS E280,
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
ELSE SUM(t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj) END))*100 AS DECIMAL(18,1)) AS E292,
CAST(((CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END - CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_vj) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END) * 100 AS DECIMAL(18,1)) AS E253,
CAST(SUM(t1.kassenumsatz_kl_absolut_brutto) AS DECIMAL(18,0)) AS E276,
CAST(SUM(t1.totalabschriften_wert_netto_absolut) AS DECIMAL(18,0)) AS E258,
CAST(SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) AS DECIMAL(18,0)) AS E316,
CAST((CASE
WHEN SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.preisabschriften_preisanderungen_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E320,
CAST((CASE
WHEN SUM(t1.totalabschriften_wert_netto_absolut) = 0 THEN NULL
ELSE SUM(t1.totalabschriften_wert_netto_absolut) END / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) * 100 AS DECIMAL(18,1)) AS E259,
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
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E328,
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
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_vj) END)) * 100 AS DECIMAL(18,1)) AS E332,
CAST ((SUM(t1.totalabschriften_wert_netto_absolut) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto) END) / CASE
WHEN (SUM(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_wg) END) = 0 THEN NULL
ELSE (SUM(t1.totalabschriften_wert_netto_absolut_wg) / CASE
WHEN SUM(t1.kassenumsatz_kl_absolut_netto_wg) = 0 THEN NULL
ELSE SUM(t1.kassenumsatz_kl_absolut_netto_wg) END) END AS DEC (18,2)) AS E324
FROM dbp_msi_v_view.v_tupel_13_wochen_2 t1_2
JOIN dbp_view.v_woche_2 x1
ON t1.kjwo_13 = x1.kjwo
JOIN dbp_view.v_woche_2 x2
ON x1.akt_wo+2 = x2.akt_wo
JOIN dbp_msi_v_view.v_tupel_mat_2 t2
ON t1.mandant_id=t2.mandant_id
AND t1.matching_id=t2.matching_id
AND x2.kjwo = t2.a500_kjwo_update
GROUP BY 1,2,3,4,5,6,7;