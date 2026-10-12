CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTBEW_2 (
	DAT,
	KJWO,
	KJMO,
	ART_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	VK_MENGE,
	VK_MENGE_OPA,
	VK_MENGE_AF,
	VK_MENGE_SA,
	UMSATZ_NETTO,
	UMSATZ_NETTO_AF,
	UMSATZ_NETTO_SA
) AS
-- AP0138978 |dknop | adding vk_menge_opa
-- removing  BEWART_ID, BQ_FINDUNG_ID,BEZUGSWEG_ID,GP_ID,EAN_KASSE from artbew_2 and pre-aggreagation of artbew_2
--2023-11-27, AP0194246, dknop,  + 1010 bewart_id for AF, + umsatz_netto_af / _sa
--2024-03-16, dknop, u-- 27.08.2014 twie: belastungs_kz, bestell_text, ref_buchungskreis_id, belegart_id neu

-- 10.06.2013 AL psp_id <> -1 anstatt psp_id > -1 wegen generierten I PSP

-- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen

-- 15.07.2013 AL HB1/HB2 Sicht Auswahl und Ausschluss definierten Kostenarten

-- 24.05.2013 twie: Ermittlung Planungselement

… INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_…_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs

 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis
   -- WHERE Bedingung ist bereits in der materialisierten View enthalten
;pdating umsatz_netto_af / _sa
--2024-04-09, dknop, adding umsatz_netto
--2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
SELECT
   artbew.dat,
   t.kjwo,
   t.kjmo,
   artbew.art_id,
   artbew.mandant_id,  
    /*v01.gp_id,*/
   artbew.nb_id,
   --artbew.wup_id,
   --CASE WHEN TRY_CAST(artbew.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id,
   v05.aktuell_wup_id wup_id,
  /*v01.bewart_id,
   v01.bq_findung_id,
   v01.bezugsweg_id,*/
      artbew.vk_menge,
   COALESCE(vk_menge, 0)- COALESCE(CASE WHEN artbew.mandant_id = 1 THEN absch_de.menge_preisabschriften ELSE absch_kmo.menge_preisabschriften END, 0) AS vk_menge_opa,
   artbew.vk_menge_af,
   artbew.vk_menge_sa,
        /*   CASE
      WHEN v01.bewart_id = 1002 THEN v01.menge
   END vk_menge_sa,
   (
      CASE
         WHEN v01.ean_kasse BETWEEN 100000
         AND 999999 THEN v01.ean_kasse * 10000000 -- 10 Millionen
         ELSE v01.ean_kasse
      END
   ) AS ean_kasse*/
   artbew.umsatz_netto,
   artbew.umsatz_netto_af,
   artbew.umsatz_netto_sa
FROM
   (SELECT 
   v01.dat,
   v01.art_id,
   v01.mandant_id,
   v01.nb_id,
   v01.wup_id,
   SUM(v01.menge) AS vk_menge,
   SUM(CASE WHEN v01.bewart_id IN (1001, 1010) THEN v01.menge ELSE NULL END) AS vk_menge_af,
   SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END) AS vk_menge_sa,
   
   /*SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
             WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END)AS umsatz_netto_af,
   
    SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
             WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END) AS umsatz_netto_sa,*/
    SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto,
    SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v-- 27.08.2014 twie: belastungs_kz, bestell_text, ref_buchungskreis_id, belegart_id neu

-- 10.06.2013 AL psp_id <> -1 anstatt psp_id > -1 wegen generierten I PSP

-- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen

-- 15.07.2013 AL HB1/HB2 Sicht Auswahl und Ausschluss definierten Kostenarten

-- 24.05.2013 twie: Ermittlung Planungselement

… INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_…_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs

 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis
   -- WHERE Bedingung ist bereits in der materialisierten View enthalten
;02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto_af,
    SUM(CASE WHEN v02.wrg_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto_sa
    
    
   FROM dbp_view.v_artbew_2 v01


CROSS JOIN dbp_msi_view_scm.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v02 
    GROUP BY
   v01.dat,
   v01.art_id,
   v01.mandant_id,
   v01.nb_id,
   v01.wup_id) artbew_2
   
 INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = artbew.mandant_id
   --AND v05.wup_id = CASE WHEN TRY_CAST(artbew.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(artbew.wup_id AS INTEGER) END
   AND v05.wup_id = artbew.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))
  
  
--marktabschriften_2 de

LEFT JOIN (SELECT
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat
,SUM(CASE WHEN abschrift_menge_einh_id = 'G' THEN menge_abschrift/1000 ELSE menge_abschrift END) menge_preisabschriften 
FROM dbp_view.v_marktabschriften_2 v01 
WHERE v01.MANDANT_ID=1 AND v01.abschriftart_id IN (5,7)
GROUP BY
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat

)absch_de
ON  artbew.mandant_id = absch_de.mandant_id
AND artbew.wup_id = absch_de.wup_id
AND artbew.art_id = absch_de.art_id
AND artbew.dat = absch_de.dat

--marktabschriften_2 kmo 

LEFT JOIN (SELECT absch.mandant_id, absch.wup_id, absch.art_id, DAT_UMBEW AS dat, SUM( MENGE_ERF) menge_preisabschriften
FROM dbp_view.v_art_umbewertung_2 absch
   WHERE ( absch.mandant_id= 6 AND PREIS_AEND_GRUND_ID = 2 ) OR
( absch.mandant_id IN (2,4,5,7,8) AND PREIS_AEND_GRUND_ID = 7 ) OR
( absch.mandant_id= 3 AND PREIS_AEND_GRUND_ID = 11 ) 
GROUP BY 1,2,3,4
)absch_kmo
ON  artbew.mandant_id = absch_kmo.mandant_id
AND artbew.wup_id = absch_kmo.wup_id
AND artbew.art_id = absch_kmo.art_id
AND artbew.dat = absch_kmo.dat  
 
JOIN dbp_view.v_tag_2 t ON artbew.dat = t.dat

--where artbew.wup_id=4533 and artbew.art_id=47877600 and artbew.dat='2023-05-03'
;