CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MIETOBJEKT_AKTIVITAET(
	MANDANT_ID,
	MO_INTRENO,
	AKTIVITAET1,
	AKTIVITAET2,
	AKTIVITAET3,
	AKTIVITAET4,
	AKTIVITAET5,
	AKTIVITAET6,
	AKTIVITAET7,
	AKTIVITAET8,
	AKTIVITAET9,
	AKTIVITAET10,
	AKTIVITAET11,
	AKTIVITAET12,
	AKTIVITAET13,
	AKTIVITAET14,
	AKTIVITAET15,
	AKTIVITAET16,
	AKTIVITAET17,
	AKTIVITAETEN_GESAMT,
	ERGEBNISS
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   mo.mandant_id, mo.mo_intreno
   , MAX(CASE WHEN dat_akqu_vor_ort>= CURRENT_DATE - 45 THEN '(1) ' || TO_CHAR(dat_akqu_vor_ort, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet1
   , MAX(CASE WHEN dat_akqu_wettbewerber>= CURRENT_DATE - 45  THEN '(2) ' || TO_CHAR(dat_akqu_wettbewerber,'DD.MM.YYYY') ||  '    ' END) AS aktivitaet2
   , MAX(CASE WHEN dat_akqu_ansprache_filialist>= CURRENT_DATE - 45 THEN '(3) ' || TO_CHAR(dat_akqu_ansprache_filialist, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet3
   , MAX(CASE WHEN dat_akqu_ansprache_mieter>= CURRENT_DATE - 45 THEN '(4) ' || TO_CHAR(dat_akqu_ansprache_mieter, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet4
   , MAX(CASE WHEN dat_akqu_info_hl_ma_praemie>= CURRENT_DATE - 45 THEN '(5) ' || TO_CHAR(dat_akqu_info_hl_ma_praemie, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet5
   , MAX(CASE WHEN dat_akqu_flaeche_verblendung>= CURRENT_DATE - 45 THEN '(6) ' || TO_CHAR(dat_akqu_flaeche_verblendung, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet6
   , MAX(CASE WHEN dat_akqu_teambesprechung>= CURRENT_DATE - 45 THEN '(7) ' ||TO_CHAR(dat_akqu_teambesprechung, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet7
   , MAX(CASE WHEN dat_akqu_angebot_homepage>= CURRENT_DATE - 45 THEN '(8) ' || TO_CHAR(dat_akqu_angebot_homepage,'DD.MM.YYYY') ||  '    ' END) AS aktivitaet8
   , MAX(CASE WHEN dat_akqu_internetrecherche>= CURRENT_DATE - 45 THEN '(9) ' ||TO_CHAR(dat_akqu_internetrecherche,'DD.MM.YYYY') ||  '    ' END) AS aktivitaet9
   , MAX(CASE WHEN dat_akqu_spanntranspar_geb>= CURRENT_DATE - 45 THEN '(10) ' || TO_CHAR(dat_akqu_spanntranspar_geb,'DD.MM.YYYY') ||  '    ' END) AS aktivitaet10
   , MAX(CASE WHEN dat_akqu_inserat_tageszeitung>= CURRENT_DATE - 45 THEN '(11) ' || TO_CHAR(dat_akqu_inserat_tageszeitung, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet11
   , MAX(CASE WHEN dat_akqu_inserat_tip>= CURRENT_DATE - 45 THEN '(12) ' || TO_CHAR(dat_akqu_inserat_tip, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet12
   , MAX(CASE WHEN dat_akqu_telefon>= CURRENT_DATE - 45 THEN '(13) ' ||TO_CHAR(dat_akqu_telefon, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet13
   , MAX(CASE WHEN dat_akqu_amt_wirtschaftsfoerderung>= CURRENT_DATE - 45 THEN '(14) ' || TO_CHAR(dat_akqu_amt_wirtschaftsfoerderung, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet14
   , MAX(CASE WHEN dat_akqu_suche_biete>= CURRENT_DATE - 45 THEN '(15) ' ||TO_CHAR (dat_akqu_suche_biete, 'DD.MM.YYYY') ||  '    ' END) AS aktivitaet15
   , MAX(CASE WHEN dat_akqu_internetauktion>= CURRENT_DATE - 45 THEN '(16) ' || TO_CHAR(dat_akqu_internetauktion,'DD.MM.YYYY') ||  '    ' END) AS aktivitaet16
   , MAX(CASE WHEN dat_akqu_sonstige>= CURRENT_DATE - 45 THEN '(17) ' || TO_CHAR(dat_akqu_sonstige,'DD.MM.YYYY') ||  '    ' END) AS aktivitaet17
   , COALESCE(aktivitaet1 , '') ||
     COALESCE(aktivitaet2 , '') ||
     COALESCE(aktivitaet3 , '') ||
     COALESCE(aktivitaet4 , '') ||
     COALESCE(aktivitaet5 , '') ||
     COALESCE(aktivitaet6 , '') ||
     COALESCE(aktivitaet7 , '') ||
     COALESCE(aktivitaet8 , '') ||
     COALESCE(aktivitaet9 , '') ||
     COALESCE(aktivitaet10, '') ||
     COALESCE(aktivitaet11, '') ||
     COALESCE(aktivitaet12, '') ||
     COALESCE(aktivitaet13, '') ||
     COALESCE(aktivitaet14, '') ||
     COALESCE(aktivitaet15, '') ||
     COALESCE(aktivitaet16, '') ||
     COALESCE(aktivitaet17, '')::VARCHAR(350) AS aktivitaeten_gesamt
   , MAX(mo.akqu_ergebnis) AS ergebniss
   FROM dbp_view.v_immo_mietobjekt mo
   GROUP BY
   mo.mandant_id
   , mo.mo_intreno;