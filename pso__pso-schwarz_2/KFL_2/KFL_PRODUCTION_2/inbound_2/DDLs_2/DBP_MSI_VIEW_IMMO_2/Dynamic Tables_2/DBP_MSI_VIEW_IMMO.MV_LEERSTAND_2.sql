CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_LEERSTAND_2(
	MANDANT_ID,
	MO_INTRENO,
	MV_INTRENO,
	DAT_VON,
	DAT_BIS,
	DAT_RUECKGABE,
	DAT_UEBERGABE,
	LEERSTAND_SEIT_2101,
	FLAECHE_FREI_SEIT_TAGEN,
	BRANCHE_ID,
	VERTRAGSART_ID,
	AKTIVITAETEN_GESAMT,
	ERGEBNISS,
	MO_ART_KZ,
	MO_STATUS_ID,
	FLAECHEART_LEERSTAND_ID,
	FLAECHEART_LEERSTAND_BEZ,
	DAT_MO_GUELTIG_VON,
	DAT_MO_GUELTIG_BIS,
	GROESSE,
	LEER_FLAECHE_GROESSE_OHNE_BM,
	MIETAUFWAND_AKT_MONAT,
	MIETAUFWAND_AUFG_GJ,
	LEER_PLAN_WERT_AVG,
	LEER_PLAN_WERT_TAG1,
	LEER_PLAN_WERT_TAG,
	VORHER_LEER_FG,
	LEERSTANDSBERICHT_FG,
	ECHTER_LEERSTAND_FG,
	MIETE_BETRAG,
	WRG_ID,
	WRG_TYP_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   mvs.mandant_id, mvs.mo_intreno, mvs.mv_intreno, mvmo.dat_von, mvmo.dat_bis, t2.dat_rueckgabe, mvs.dat_uebergabe, mo.leerstand_seit_2101, CASE WHEN CURRENT_DATE >= mo. leerstand_seit_2101
   THEN CURRENT_DATE - mo. leerstand_seit_2101
   END AS flaeche_frei_seit_tagen, CASE WHEN mo.mo_status_id IN (4, 2, 3)
   THEN mv.branche_id
   ELSE mo.mo_branche_id
   END branche_id, COALESCE(mv.vertragsart_id,0) AS vertragsart_id, akt.aktivitaeten_gesamt, akt.ergebniss, mo.mo_art_kz, mo.mo_status_id, mo.flaecheart_leerstand_id, mo.flaecheart_leerstand_bez, mo.dat_mo_gueltig_von, mo.dat_mo_gueltig_bis, mess.groesse, CASE WHEN COALESCE(mv.branche_id,mo.mo_branche_id) IN ('107','150','143')
   THEN 0
   ELSE mess.groesse
   END leer_flaeche_groesse_ohne_BM, (mess.groesse * o.planmiete_per_qm)*kurs.kurs_2 AS  mietaufwand_akt_monat, CASE WHEN mo.mo_art_kz = 'T'
   THEN (mietaufwand_akt_monat * ((CURRENT_DATE - temp.gj_anfang) / 30.00):: NUMBER(38,2)) ::NUMBER(38,2)
   ELSE CASE WHEN mo.leerstand_seit_2101 > temp.gj_anfang THEN (mietaufwand_akt_monat * (flaeche_frei_seit_tagen / 30.00):: NUMBER(38,2)) :: NUMBER(38,2)
   WHEN mo.leerstand_seit_2101 IS NULL          THEN NULL
   ELSE (mietaufwand_akt_monat * ((CURRENT_DATE - temp.gj_anfang) / 30.00):: NUMBER(38,2)) ::NUMBER(38,2)
   END
   END  mietaufwand_aufg_gj, plan.plan_wert_avg*kurs.kurs_2 AS  leer_plan_wert_avg
   , CASE WHEN mo.mo_art_kz = 'T'
   THEN plan.plan_wert_tag * (CURRENT_DATE - temp.gj_anfang)
   ELSE CASE WHEN mo.leerstand_seit_2101 > temp.gj_anfang THEN plan.plan_wert_tag * (flaeche_frei_seit_tagen)
   WHEN mo.leerstand_seit_2101 IS NULL THEN NULL
   ELSE plan.plan_wert_tag * (CURRENT_DATE - temp.gj_anfang)
   END
   END  leer_plan_wert_tag1  
   , CAST(leer_plan_wert_tag1*kurs.kurs_2 AS NUMBER(38,2)) AS leer_plan_wert_tag, CASE WHEN COALESCE (CASE WHEN t2.dat_rueckgabe = '9999-12-31' THEN NULL  ELSE t2.dat_rueckgabe END, mo.dat_mo_gueltig_von)   + 30 <= mvs.dat_uebergabe
   THEN 1 ELSE 0 END::INTEGER vorher_leer_fg, CASE WHEN (mo.mo_status_id NOT IN (4, 6, 7) AND flaeche_frei_seit_tagen >= 30)
   OR (CURRENT_DATE - mvs.dat_uebergabe BETWEEN 0 AND 30 AND vorher_leer_fg = 1)
   OR mo.mo_art_kz IN ('T')
   THEN 1
   ELSE 0
   END  leerstandsbericht_fg, CASE WHEN (CURRENT_DATE - mvs.dat_uebergabe BETWEEN 0 AND 30 AND vorher_leer_fg = 1)
   THEN 0
   ELSE 1
   END echter_leerstand_fg, v1.f_miete_pa_wrg/12 AS miete_betrag, kurs.wrg_id, kurs.wrg_typ_id

   FROM (

   SELECT v1.mandant_id, v1.mo_intreno, v1.mv_intreno, MAX(v1.dat_status_von) AS dat_status_von, MAX(v1.dat_uebergabe) AS dat_uebergabe
   FROM dbp_view.v_immo_mo_status_per_2 v1
   JOIN (
   SELECT mandant_id, mo_intreno, MAX(dat_status_von) AS dat_status_von FROM dbp_view.v_immo_mo_status_per_2
   GROUP BY 1,2) AS v2
   ON v1.mandant_id=v2.mandant_id AND v1.mo_intreno=v2.mo_intreno AND v1.dat_status_von=v2.dat_status_von
   GROUP BY 1,2,3
   ) mvs
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 mvmo
   ON mvs.mo_intreno = mvmo.mo_intreno
   AND mvs.mv_intreno = mvmo.mv_intreno

   JOIN dbp_msi_view_immo.mv_mietobjekt_2 mo
   ON mo.mo_intreno = mvs.mo_intreno
   LEFT JOIN (
   SELECT mandant_id, mo_intreno, MAX(dat_bis) dat_rueckgabe
   FROM dbp_view.v_immo_mietvertrag_mo_zu_per_2
   WHERE dat_bis < '9999-12-31'
   GROUP BY 1,2
   ) t2
   ON mvs.mo_intreno = t2.mo_intreno
   LEFT JOIN dbp_view.v_immo_mietvertrag_per_2 mv
   ON mvs.mv_intreno = mv.mv_intreno
   LEFT JOIN dbp_msi_view_immo.mv_mietobjekt_aktivitaet_2 akt
   ON mvs.mo_intreno = akt.mo_intreno
   LEFT JOIN (
   
   SELECT
   mandant_id, mo_intreno, bemessung_art_id, dat_bis, dat_von, groesse, groesse_einheit
   FROM dbp_view.v_immo_mietobjekt_messung_2
   WHERE "CURRENT_DATE" BETWEEN dat_von AND dat_bis
   AND bemessung_art_id IN ('0300','0310','0320','0380')) mess
   ON mo.mo_intreno = mess.mo_intreno
   LEFT JOIN (
   SELECT
   p1.mandant_id, p1.plan_objekt_id  mo_intreno, SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END) anzahl, CASE WHEN anzahl = 0 THEN SUM(p1.plan_wert)
   ELSE  SUM(p1.plan_wert) / CAST(anzahl AS DECIMAL(18,6))
   END plan_wert_avg, plan_wert_avg / 30 AS  plan_wert_tag
   FROM dbp_view.v_ivs_plan_2 p1

   JOIN dbp_view.v_monat_2 mo1
   ON p1.kjmo = mo1.kjmo

   WHERE p1.plantyp_id = 1 AND p1.plandetail_id IN (1, 80)
   AND (CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3
   THEN mo1.akt_gj + 1
   ELSE mo1.akt_gj
   END) = 0

   GROUP BY
   p1.mandant_id
   ,p1.plan_objekt_id
   )  plan
   ON mo.mo_intreno = plan.mo_intreno

   JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_2  kurs_2
   ON kurs.mandant_id = mvs.mandant_id
   AND CURRENT_DATE BETWEEN kurs.kurs_dat_von AND kurs.kurs_dat_bis
   LEFT JOIN dbp_msi_view_immo.mv_f_mietuebersicht_akt_2 AS v1
   ON v1.mandant_id=mvs.mandant_id AND v1.mo_intreno=mvs.mo_intreno AND v1.mv_intreno=mvs.mv_intreno 
   AND kurs.wrg_id=v1.wrg_id AND kurs.wrg_typ_id=v1.wrg_typ_id
   LEFT JOIN dbp_view.v_immo_planung_mieteinnahmen_2 AS o
   ON o.mandant_id=mvs.mandant_id AND o.we_intreno=mo.we_intreno
   CROSS JOIN
   (
   SELECT
   
     
 TO_DATE(kjmo || '01','YYYYMMDD') AS gj_anfang
     
   FROM dbp_view.v_monat_2
   WHERE akt_gj = 0 AND mo_gj = 1
   ) TEMP

   WHERE CURRENT_DATE BETWEEN mo.dat_mo_gueltig_von AND mo.dat_mo_gueltig_bis;