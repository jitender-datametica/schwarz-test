create or replace view DBP_MSI_VIEW_EK_SORT.JAVA_TUPEL_13_NEW_2(
	MANDANT_ID,
	MATCHING_ID,
	A5,
	A7,
	A9,
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
	USER_ID
) as

SELECT

t1.mandant_id

,t1.matching_id

,t2.A5_owg_id AS A5

,t2.A7_wg_id AS A7

,t2.wug_id AS A9

,t1.kassenumsatz_af_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_af AS E284

,((t1.kassenumsatz_af_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.kassenumsatz_af_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.kassenumsatz_af_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 AS E288

,t1.absatz_af_kl / t1.anzahl_markt_wochen_kombis_abverkauf_af AS E250

,((t1.absatz_af_kl / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.absatz_af_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.absatz_af_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 AS E268

,absatz_kl AS E248

,absatz_sst1 AS E196

,absatz_sst2 AS E198

,absatz_sst3 AS E200

,absatz_sst4 AS E202

,absatz_sst5 AS E204

,absatz_sst6 AS E206

,absatz_sst7 AS E208

,absatz_ksst1 AS E182

,absatz_ksst2 AS E184

,absatz_ksst3 AS E186

,absatz_ksst4 AS E188

,absatz_ksst5 AS E190

,absatz_ksst6 AS E192

,absatz_ksst7 AS E194

,absatz_ost_basis AS E210

,absatz_ost_gross AS E212

,absatz_sued_ost AS E214

,absatz_sued_west AS E216

,absatz_west AS E218

,absatz_nord AS E220

,absatz_sst1 / t1.markt_wochen_sst1 AS E197

,absatz_sst2 / t1.markt_wochen_sst2 AS E199

,absatz_sst3 / t1.markt_wochen_sst3 AS E201

,absatz_sst4 / t1.markt_wochen_sst4 AS E203

,absatz_sst5 / t1.markt_wochen_sst5 AS E205

,absatz_sst6 / t1.markt_wochen_sst6 AS E207

,absatz_sst7 / t1.markt_wochen_sst7 AS E209

,absatz_ksst1 / t1.markt_wochen_ksst1 AS E183

,absatz_ksst2 / t1.markt_wochen_ksst2 AS E185

,absatz_ksst3 / t1.markt_wochen_ksst3 AS E187

,absatz_ksst4 / t1.markt_wochen_ksst4 AS E189

,absatz_ksst5 / t1.markt_wochen_ksst5 AS E191

,absatz_ksst6 / t1.markt_wochen_ksst6 AS E193

,absatz_ksst7 / t1.markt_wochen_ksst7 AS E195

,t1.absatz_ost_basis / t1.markt_wochen_ost_basis AS E211

,t1.absatz_ost_gross / t1.markt_wochen_ost_gross AS E213

,t1.absatz_sued_ost / t1.markt_wochen_sued_ost AS E215

,t1.absatz_sued_west / t1.markt_wochen_sued_west AS E217

,t1.absatz_west / t1.markt_wochen_west AS E219

,t1.absatz_nord / t1.markt_wochen_nord AS E221

,t1.anzahl_markt_wochen_kombis_abverkauf_mit_listung / t1.anzahl_markt_wochen_kombis_listung *100 AS E363

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE rohertrag_ekmep_olk_4n END AS E254

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE rohertrag_ekmep_olk_4n / absatz_kl END AS E260

,t1.absatz_sa_kl / t1.anzahl_markt_wochen_kombis_abverkauf_sa AS E264

,((t1.absatz_sa_kl / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.absatz_sa_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.absatz_sa_kl_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 AS E272

,t1.absatz_sa_kl / t1.absatz_kl * 100 AS E251

,t1.anz_bons_af / t1.anz_bons_gesamt AS E351

,t1.anz_bons_sa / t1.anz_bons_gesamt AS E355

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n - t1.rohertrag_ekmep_olk_4n_vj END AS E255

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_af / t1.anzahl_markt_wochen_kombis_abverkauf_af END AS E296

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_sa / t1.anzahl_markt_wochen_kombis_abverkauf_sa END AS E300

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE ((t1.rohertrag_ekmep_olk_4n_af / t1.anzahl_markt_wochen_kombis_abverkauf_af)-(t1.rohertrag_ekmep_olk_4n_af_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj))/(t1.rohertrag_ekmep_olk_4n_af_vj / t1.anzahl_markt_wochen_kombis_abverkauf_af_vj)*100 END AS E304

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE ((t1.rohertrag_ekmep_olk_4n_sa / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.rohertrag_ekmep_olk_4n_sa_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.rohertrag_ekmep_olk_4n_sa_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 END AS E308

,t1.kassenumsatz_af_kl_absolut_brutto / t1.absatz_af_kl AS E375

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE A23_rohertrag_ekmep_olk_4n / t1.kassenumsatz_kl_absolut_netto * 100 END AS E256

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_af / t1.kassenumsatz_af_kl_absolut_netto END AS E257

,CASE WHEN t3.user_id IS NULL THEN NULL ELSE t1.rohertrag_ekmep_olk_4n_sa / t1.kassenumsatz_sa_kl_absolut_netto END AS E312

,(t1.absatz_kl - t1.absatz_kl_vj) / t1.absatz_kl_vj * 100 AS E249

,kassenumsatz_kl_absolut_netto AS E252

,t1.kassenumsatz_sa_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_sa AS E280

,((t1.kassenumsatz_sa_kl_absolut_netto / t1.anzahl_markt_wochen_kombis_abverkauf_sa)-(t1.kassenumsatz_sa_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj))/(t1.kassenumsatz_sa_kl_absolut_netto_vj / t1.anzahl_markt_wochen_kombis_abverkauf_sa_vj)*100 AS E292

,(t1.kassenumsatz_kl_absolut_netto - t1.kassenumsatz_kl_absolut_netto_vj) / t1.kassenumsatz_kl_absolut_netto_vj * 100 AS E253

,t1.kassenumsatz_kl_absolut_brutto AS E276

,t1.totalabschriften_wert_netto_absolut AS E258

,t1.preisabschriften_preisanderungen_wert_netto_absolut AS E316

,t1.preisabschriften_preisanderungen_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto * 100 AS E320

,t1.totalabschriften_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto * 100 AS E259

,((t1.totalabschriften_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto) - (t1.totalabschriften_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj)) / (t1.totalabschriften_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj) * 100 AS E328

,((t1.preisabschriften_preisanderungen_wert_netto_absolut / t1.kassenumsatz_kl_absolut_netto) - (t1.preisabschriften_preisanderungen_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj)) / (t1.preisabschriften_preisanderungen_wert_netto_absolut_vj / t1.kassenumsatz_kl_absolut_netto_vj) * 100 AS E332

,t3.user_id

FROM dbp_msi_view_ek_sort.tupel_kw_hilfsview_2 t1_2

JOIN dbp_data.tupel_mat_2 t2

ON t1.mandant_id=t2.mandant_id

AND t1.matching_id=t2.matching_id

LEFT JOIN dbp_security.user_zek_zu_2 t3

ON t1.mandant_id=t3.mandant_id

AND t2.a389_zek_id=t3.zek_id;