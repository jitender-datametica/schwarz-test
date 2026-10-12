CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_PROJEKT_HISTORIE
(
checkliste_punkt_id
,cpr_suchfeld_id
,ok_fg
,ENDE_DATUM
,KJMO_STILLE_EROEFF
,cl_punkt_bez
,cl_punkt_langtext
,cpr_checkliste_id
,checkliste_nr
,cpr_checkliste_bez
,cpr_checkliste_langtext
,projekt_phase_id
,phasenart_id
,teil_massn_fg
,teil_massnahme_id
,einzel_massnahme
,cpr_phase_bez
,cpr_phase_langtext
,projekt_id
,mandant_id
,land_id
,techn_platz_id
,projekt_nr
,massnahme_kz
,wup_id
,cpr_standort
,cpr_filialtyp_bez
,investor_eigenobj
,cpr_general_planer
,cpr_projekt_steurer
,cpr_projekt_bez
,cpr_projekt_langtext
,spr_id
,dat_extrakt
,bauabschnitt_id
,bauabschnitt_bez
,bauabschnitt_langtext
,art_massnahme_id
,BAUBEGINN
,BEGINN_EINRICHTUNG
,STILLE_EROEFFNUNG
,EROEFFNUNG_TIP_TOP
,historie_fg
,cpr_phase_version_id
,cpr_phase_version_dat

)
AS
   -- 20081217:
   -- cpr_suchfeld_id zu suchfeld_bez geändert
   -- 20090114: cpr_suchfeld wird wieder geliefert statt suchfeld_bez
   -- 20090608 (A.Wenzel) Feld Objektsteurer als Projektsteurer ausgegeben
   -- 2009-06-23, awen
   -- Umgebaut LIKEs zu Ist gleich
   -- 101124 cdab Erweiterung Anforderung 355134
   -- 110527 cdab Erweiterung cpr_cl_punkt_termin.ok_fg
   -- 20120215: k.kaiser 2 Felder cpr_phase_version_id, cpr_phase_version_dat (Anfo 559154)
   --1130729Msch1907: Änderung auf Grund neuer Massnahmenarten durch SAKO-Projekt
   --20241122 alavih: Anpassung für Filialumgliederung

   SELECT
   pt.checkliste_punkt_id,
   pt.cpr_suchfeld AS cpr_suchfeld_id, 
   pt.ok_fg, 
   CASE WHEN pt.dat_ende_ist IS NOT NULL AND pt.dat_ende_ist <> '1900-01-01' THEN pt.dat_ende_ist ELSE NULL END  AS ENDE_DATUM,
   MAX(pt01.KJMO_STILLE_EROEFF) KJMO_STILLE_EROEFF, 
   pt.cl_punkt_bez, 
   pt.cl_punkt_langtext, 
   pt.cpr_checkliste_id, 
   pt.checkliste_nr, 
   pt.cpr_checkliste_bez, 
   pt.cpr_checkliste_langtext, 
   pt.projekt_phase_id, 
   pt.phasenart_id, 
   pt.teil_massn_fg, 
   pt.teil_massnahme_id, 
   pt.einzel_massnahme, 
   pt.cpr_phase_bez, 
   pt.cpr_phase_langtext, 
   pt.projekt_id, 
   pt.mandant_id, 
   pt.land_id, 
   pt.techn_platz_id, 
   pt.projekt_nr, 
   CASE WHEN SUBSTR( pt.massnahme_id, 1, 5) = 'ZPPM_' THEN SUBSTR(pt.massnahme_id,6,LENGTH(pt.massnahme_id)-5) ELSE pt.massnahme_id END  AS massnahme_id, 
 --pt.wup_id,
   COALESCE(wup.aktuell_wup_id, pt.wup_id,0) AS wup_id, 
   pt.cpr_standort, 
   pt.cpr_filialtyp_bez, 
   pt.investor_eigenobj, 
   pt.cpr_general_planer,
   pt.cpr_objekt_steurer AS cpr_projekt_steurer, 
   pt.cpr_projekt_bez, 
   pt.cpr_projekt_langtext, 
   pt.spr_id, pt.dat_extrakt, 
   CASE WHEN pt.teil_massn_fg > 1 THEN pt.projekt_id || pt.projekt_phase_id ELSE pt.projekt_id|| '0000' END  bauabschnitt_id, 
   CASE WHEN pt.teil_massn_fg > 1 THEN pt.cpr_phase_bez ELSE pt.cpr_projekt_bez END  bauabschnitt_bez, 
   CASE WHEN pt.teil_massn_fg > 1 THEN COALESCE(pt.cpr_phase_langtext,'') WHEN pt.teil_massn_fg = 1 THEN COALESCE(pt.cpr_projekt_langtext || '' ,'') || COALESCE(pt.cpr_phase_langtext, '') ELSE COALESCE(pt.cpr_projekt_langtext,'') END  bauabschnitt_langtext, 
   pr_m.massnahme_id, 
   MAX(CASE WHEN pt.cpr_suchfeld = 'BAUBEGINN' THEN pt.dat_ende_ist ELSE NULL END)  AS BAUBEGINN, 
   MAX(CASE WHEN pt.cpr_suchfeld = 'BEGINN_EINRICHTUNG' THEN pt.dat_ende_ist  ELSE NULL END)  AS  BEGINN_EINRICHTUNG, 
   MAX(CASE WHEN pt.cpr_suchfeld = 'STILLE_EROEFFNUNG' THEN pt.dat_ende_ist  ELSE NULL END)  AS  STILLE_EROEFFNUNG, 
   MAX(CASE WHEN pt.cpr_suchfeld = 'EROEFFNUNG_TIP_TOP' THEN pt.dat_ende_ist ELSE NULL END)  AS  EROEFFNUNG_TIP_TOP,
   CASE WHEN SUBSTRING(pt.techn_platz_id, 4, 8)  = '9900'  THEN 1 WHEN pj.cpr_systemstatus1_id <> 2 THEN 1 WHEN pt.teil_massn_fg > 1 THEN CASE WHEN so.STILLE_EROEFF > CURRENT_DATE  THEN 1 ELSE CASE WHEN pp.cpr_systemstatus1_id <>2 THEN 1 ELSE  0 END END ELSE 0 END  historie_fg, 
   pp.cpr_phase_version_id AS cpr_phase_version_id, 
   pp.cpr_phase_version_dat AS cpr_phase_version_dat

   FROM dbp_view.v_cpr_cl_punkt_termin   pt
   LEFT JOIN dbp_view.v_l_massnahme  pr_m
   ON   pt.massnahme_id = pr_m.massnahme_id
   LEFT JOIN dbp_view.v_cpr_projekt_per pj
   ON pt.projekt_id = pj.projekt_id AND pj.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_cpr_phase_per pp
   ON pt.projekt_id = pp.projekt_id AND pp.dat_bis = '9999-12-31'
   LEFT OUTER JOIN
      (SELECT
      pt.projekt_id, 
      pt.projekt_phase_id, 
      MAX(pt.dat_ende_ist) STILLE_EROEFF
      FROM dbp_view.v_cpr_cl_punkt_termin pt
      WHERE pt.cpr_suchfeld = 'STILLE_EROEFFNUNG' AND pt.ok_fg = 1
      GROUP BY 1,2) so
   ON pt.projekt_id = so.projekt_ID AND pt.projekt_phase_id = so.projekt_phase_id
   
   LEFT OUTER JOIN
      (SELECT
      pt.projekt_id, 
      pt.projekt_phase_id, 
      MAX(CASE WHEN pt.cpr_suchfeld = 'STILLE_EROEFFNUNG' THEN TO_VARCHAR(pt.dat_ende_ist, 'YYYYMM')ELSE NULL END) KJMO_STILLE_EROEFF
      FROM dbp_view.v_cpr_cl_punkt_termin pt
      WHERE pt.ok_fg = 1
      GROUP BY
      pt.projekt_id,
      pt.projekt_phase_id) pt01
   ON pt.projekt_id = pt01.projekt_ID AND pt.projekt_phase_id = pt01.projekt_phase_id
   
   LEFT JOIN
   dbp_view.v_wup wup
   ON pt.wup_id = wup.wup_id AND pt.mandant_id = wup.mandant_id --Nur aktuell gültige WUP

   WHERE pt.ok_fg = 1

   
   GROUP BY
   pt.checkliste_punkt_id
   ,pt.cpr_suchfeld
   ,pt.ok_fg
   ,ENDE_DATUM
   ,pt.cl_punkt_bez
   ,pt.cl_punkt_langtext
   ,pt.cpr_checkliste_id
   ,pt.checkliste_nr
   ,pt.cpr_checkliste_bez
   ,pt.cpr_checkliste_langtext
   ,pt.projekt_phase_id
   ,pt.phasenart_id
   ,pt.teil_massn_fg
   ,pt.teil_massnahme_id
   ,pt.einzel_massnahme
   ,pt.cpr_phase_bez
   ,pt.cpr_phase_langtext
   ,pt.projekt_id
   ,pt.mandant_id
   ,pt.land_id
   ,pt.techn_platz_id
   ,pt.projekt_nr
   --,case when pt.massnahme_id like 'ZPPM_%' then substr(pt.massnahme_id,6,length(pt.massnahme_id)-5) else pt.massnahme_id end
   ,pt.massnahme_id
   --,pt.wup_id
   ,wup.aktuell_wup_id
   ,pt.wup_id
   ,pt.cpr_standort
   ,pt.cpr_filialtyp_bez
   ,pt.investor_eigenobj
   ,pt.cpr_general_planer
   ,pt.cpr_objekt_steurer
   ,pt.cpr_projekt_bez
   ,pt.cpr_projekt_langtext
   ,pt.spr_id
   ,pt.dat_extrakt
   ,bauabschnitt_id
   ,bauabschnitt_bez
   ,bauabschnitt_langtext
   ,pr_m.massnahme_id
   ,historie_fg
   ,pp.einzel_massnahme
   ,pp.dat_freigabe
   ,pp.cpr_phase_version_id
   ,pp.cpr_phase_version_dat;