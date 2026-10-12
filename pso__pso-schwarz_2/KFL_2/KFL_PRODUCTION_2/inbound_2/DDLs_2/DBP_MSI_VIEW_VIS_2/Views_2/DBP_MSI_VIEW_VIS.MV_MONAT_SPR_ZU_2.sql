CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MONAT_SPR_ZU_2 (
KJMO,
KJ,
MO_KJ,
GJ,
MO_GJ,
GJMO,
SPR_ID,
MO_BEZ,
MO_BEZ_DE,
MO_BEZ_CZ,
MO_BEZ_SK,
MO_BEZ_HR,
MO_BEZ_PL,
MO_BEZ_RO,
MO_BEZ_BG,
MO_BEZ_LANG,
MO_BEZ_LANG_DE,
MO_BEZ_LANG_CZ,
MO_BEZ_LANG_SK,
MO_BEZ_LANG_HR,
MO_BEZ_LANG_PL,
MO_BEZ_LANG_RO,
MO_BEZ_LANG_BG,
MO_KBEZ,
MO_KBEZ_DE,
MO_KBEZ_CZ,
MO_KBEZ_SK,
MO_KBEZ_HR,
MO_KBEZ_PL,
MO_KBEZ_RO,
MO_KBEZ_BG,
MO_KBEZ_KJ,
MO_KBEZ_KJ_DE,
MO_KBEZ_KJ_CZ,
MO_KBEZ_KJ_SK,
MO_KBEZ_KJ_HR,
MO_KBEZ_KJ_PL,
MO_KBEZ_KJ_RO,
MO_KBEZ_KJ_BG,
MO_BEZ_AUFG,
MO_BEZ_AUFG_DE,
MO_BEZ_AUFG_CZ,
MO_BEZ_AUFG_SK,
MO_BEZ_AUFG_HR,
MO_BEZ_AUFG_PL,
MO_BEZ_AUFG_RO,
MO_BEZ_AUFG_BG,
MO_KBEZ_AUFG,
MO_KBEZ_AUFG_DE,
MO_KBEZ_AUFG_CZ,
MO_KBEZ_AUFG_SK,
MO_KBEZ_AUFG_HR,
MO_KBEZ_AUFG_PL,
MO_KBEZ_AUFG_RO,
MO_KBEZ_AUFG_BG,
MO_BEZ_GJ_AUFG,
MO_BEZ_GJ_AUFG_DE,
MO_BEZ_GJ_AUFG_CZ,
MO_BEZ_GJ_AUFG_SK,
MO_BEZ_GJ_AUFG_HR,
MO_BEZ_GJ_AUFG_PL,
MO_BEZ_GJ_AUFG_RO,
MO_BEZ_GJ_AUFG_BG,
MO_KBEZ_GJ_AUFG,
MO_KBEZ_GJ_AUFG_DE,
MO_KBEZ_GJ_AUFG_CZ,
MO_KBEZ_GJ_AUFG_SK,
MO_KBEZ_GJ_AUFG_HR,
MO_KBEZ_GJ_AUFG_PL,
MO_KBEZ_GJ_AUFG_RO,
MO_KBEZ_GJ_AUFG_BG,
MO_KBEZ_KJ_KBEZ,
MO_KBEZ_KJ_KBEZ_DE,
MO_KBEZ_KJ_KBEZ_CZ,
MO_KBEZ_KJ_KBEZ_SK,
MO_KBEZ_KJ_KBEZ_HR,
MO_KBEZ_KJ_KBEZ_PL,
MO_KBEZ_KJ_KBEZ_RO,
MO_KBEZ_KJ_KBEZ_BG
) AS 
 
/*
	ZEIT_2 - Sprache Monat_2
	2009KW47: Neue Felder + where Bedingung entfernt
	2011KW37: Internationalisierung (feste Sprache)
	2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
	2018.1025 ssch0611 : Ergaenzung aufg. Spalten
	2018.1129 ssch0611 : aufg. Spalten fuer Monat_2 und GJ
	2024-07-16 muellerpatri: Weitere Spalten für mo_kbez_kj_kbez
	2024-09-02 ssch0611 : kbez für CZ(124) angepasst + Review
*/
 
SELECT
  v01.kjmo, v01.kj, v01.mo_kj, v01.gj, v01.mo_gj, v01.gjmo, 0::SMALLINT AS spr_id
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez    -- MMMM
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez) ELSE NULL END)::VARCHAR(20) AS mo_bez_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang    -- MMMM YYYY
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_bez_lang_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez    -- MMM
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez03) ELSE NULL END)::VARCHAR(20) AS mo_kbez_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj    -- MMM YYYY
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg    -- MMMM YYYY 'aufg.'
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' skum.' ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' cum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) || ' кум.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_aufg_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg    -- MMM YYYY aufg.
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez03) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez03) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez03) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez03) || ' skum.' ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez03) || ' cum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez03) || ' кум.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_aufg_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(v01.gj) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg    -- MMMM 'GJ' YYYY 'aufg.'
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(v01.gj) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(v01.gj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(v01.gj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez) || ' PG ' || TRIM(v01.gj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez) || ' RO ' || TRIM(v01.gj) || ' skum.' ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez) || ' AF ' || TRIM(v01.gj) || ' cum.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez) || ' ФГ ' || TRIM(v01.gj) || ' кум.'  ELSE NULL END)::VARCHAR(40) AS mo_bez_gj_aufg_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(v01.gj) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg    -- MMM 'GJ' YYYY 'aufg.'
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(v01.gj) || ' aufg.' ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(v01.gj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(v01.gj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez03) || ' PG ' || TRIM(v01.gj) || ' kum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez03) || ' RO ' || TRIM(v01.gj) || ' skum.' ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez03) || ' AF ' || TRIM(v01.gj) || ' cum.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez03) || ' ФГ ' || TRIM(v01.gj) || ' кум.'  ELSE NULL END)::VARCHAR(40) AS mo_kbez_gj_aufg_bg --bulgarisch
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez    -- MMM YY
, MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez_de --deutsch
, MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez_cz --tschechisch
, MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez_sk --slowakisch
, MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez_hr --kroatisch
, MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez_pl --polnisch
, MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez_ro --rumänisch
, MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTRING(v01.kj,3,4)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_kj_kbez_bg --bulgarisch
FROM dbp_view.v_monat_2 v01
 
INNER JOIN ( /* Ausnahme_2 Abkürzung für CZ */
	SELECT msz.mo_id, msz.spr_id, msz.mo_bez
	, CASE 
		WHEN msz.spr_id = 124 AND msz.mo_id = 6 THEN 'Cvn'
		WHEN msz.spr_id = 124 AND msz.mo_id = 7 THEN 'Cvc'
		ELSE TRIM(SUBSTRING(msz.mo_bez, 1, 3)) 
	  END AS mo_bez03
	FROM dbp_view.v_monat_spr_zu_2 msz
) v02
ON v01.mo_kj = v02.mo_id
 
GROUP BY ALL;