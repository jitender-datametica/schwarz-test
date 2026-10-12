CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_CL_PUNKT_TERMIN_2
-- 20160511 k.kaiser: SPEC0009788, bauabschnitte aus der cpr_aufgabe_per_2 werden auch mitberücksichtigt, wenn cpr_suchfeld_id 161 (= cpr_suchfeld_bez = 'CPR_REALISIERUNG')
--                                                                 und aufgabenart_id in ('A2','Z1')
-- 20241205 alavih: Filialumgliederung
(
checkliste_punkt_id
,cpr_suchfeld_id
,suchfeld_bez
,ok_fg
,dat_ende_ist
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
,cpr_systemstatus1_id
,neu_projekt_fg
,massnahme_id
,massnahmentyp_id
,massnahmentyp_bez
--,massnahme_typ_id
--,massnahme_typ_bez
,wup_id
,cpr_standort
,cpr_filialtyp_bez
,investor_eigenobj
,cpr_general_planer
,cpr_objekt_steurer
,cpr_projekt_bez
,cpr_projekt_langtext
,spr_id
,dat_extrakt
,cpr_phase_version_id
,cpr_phase_version_dat
,bauabschnitt_id
,dat_realisierung
)
AS

SELECT
pt.checkliste_punkt_id
,pt.cpr_suchfeld
,pt.suchfeld_bez
,COALESCE(pt.ok_fg,0)  AS ok_fg
,pt.dat_ende_ist
,COALESCE(pt.cl_punkt_bez,'0') AS cl_punkt_bez
,COALESCE(pt.cl_punkt_langtext,'0') AS cl_punkt_langtext
,COALESCE(pt.cpr_checkliste_id,'0') AS cpr_checkliste_id
,pt.checkliste_nr
,pt.cpr_checkliste_bez
,pt.cpr_checkliste_langtext
,pt.projekt_phase_id
,pt.phasenart_id
,COALESCE(pt.teil_massn_fg,0) AS teil_massn_fg
,COALESCE(pt.teil_massnahme_id,'0') AS teil_massnahme_id
,COALESCE(pt.einzel_massnahme,'0') AS einzel_massnahme
,COALESCE(pt.cpr_phase_bez,'0') AS cpr_phase_bez
,COALESCE(pt.cpr_phase_langtext,'0') AS cpr_phase_langtext
,pt.projekt_id
,pt.mandant_id
,COALESCE(pt.land_id,'0') AS land_id
,COALESCE(pt.techn_platz_id,'0') AS techn_platz_id
,COALESCE(pt.projekt_nr,'') AS projekt_nr
,COALESCE(pr.cpr_systemstatus1_id,9) AS cpr_systemstatus1_id
,CASE WHEN SUBSTR(pt.projekt_nr,9,4) >= 9000 THEN  0  ELSE  1 END AS  neu_projekt_fg
,COALESCE(pt.massnahme_id,' -1') AS massnahme_id
,COALESCE(msz.massnahmentyp_id,-1) AS massnahmentyp_id
,COALESCE(msz.massnahmentyp_bez,'') AS massnahmentyp_bez
--,COALESCE(msz.massnahmentyp_id,-1) AS massnahme_typ_id
--,COALESCE(msz.massnahmentyp_bez,'') AS massnahme_typ_bez
--,COALESCE(pt.wup_id,0) AS wup_id
,COALESCE(w.aktuell_wup_id,pt.wup_id,0) AS wup_id
,COALESCE(pt.cpr_standort,'0') AS cpr_standort
,pt.cpr_filialtyp_bez
,pt.investor_eigenobj
,pt.cpr_general_planer
,pt.cpr_objekt_steurer
,COALESCE(pt.cpr_projekt_bez,'0') AS cpr_projekt_bez
,COALESCE(pt.cpr_projekt_langtext,pt.cpr_phase_langtext, '') AS cpr_projekt_langtext
--,COALESCE(pt.cpr_projekt_langtext, '') AS cpr_projekt_langtext
,pt.spr_id
,pt.dat_extrakt
,pt.cpr_phase_version_id
,pt.cpr_phase_version_dat
,CASE WHEN pt.teil_massn_fg > 1
THEN pt.projekt_id  || pt.projekt_phase_id
ELSE TRIM(pt.projekt_id )|| '0000'
END  bauabschnitt_id
,COALESCE(au.dat_start_ist,NULL) AS dat_realisierung

FROM dbp_view.v_cpr_cl_punkt_termin_2 pt

LEFT JOIN dbp_view.v_l_massnahme_2 AS mn
ON mn.massnahme_id = pt.massnahme_id

--JOIN dbp_view.v_massnahme_typ_spr_zu AS msz
--ON COALESCE(mn.massnahme_typ_id, 99) = msz.massnahme_typ_id
--AND msz.spr_id = 22

LEFT JOIN dbp_view.v_cpr_projekt_per_2 pr
ON pr.projekt_id = pt.projekt_id
--AND pt.dat_ende_ist BETWEEN pr.dat_von and pr.dat_bis
AND pr.dat_bis = '9999-12-31'

LEFT JOIN dbp_view.v_rpm_element_per_2 el
ON pr.projekt_id = el.projekt_id
AND el.dat_bis = '9999-12-31'

LEFT JOIN dbp_view.v_massnahmentyp_spr_zu_2 AS msz
--ON COALESCE(el.massnahmentyp_id, -1) = msz.massnahmentyp_id
ON el.massnahmentyp_id = msz.massnahmentyp_id
AND msz.spr_id = 22

LEFT JOIN dbp_view.v_cpr_phase_spr_zu_per_2 ph
ON pt.projekt_phase_id = ph.projekt_phase_id
AND pt.dat_ende_ist BETWEEN ph.dat_von AND ph.dat_bis
AND ph.dat_bis = '9999-12-31'
AND ph.spr_id = 22

LEFT JOIN dbp_view.v_cpr_aufgabe_per_2 au
ON pt.projekt_phase_id = au.projekt_phase_id
AND pt.dat_ende_ist BETWEEN au.dat_von AND au.dat_bis
AND au.dat_bis = '9999-12-31'
--AND au.cpr_suchfeld_id = 161

JOIN dbp_msi_view_ios.mv_projekt_bauabschnitt_2 bas
ON pr.cpr_ext_id = bas.projekt_nr

LEFT JOIN dbp_view.v_wup_2 w
ON COALESCE(pt.wup_id,0) = w.wup_id AND
pt.mandant_id = w.mandant_id

WHERE pr.cpr_systemstatus1_id <> 4 OR  pr.cpr_systemstatus1_id IS NULL
/*
UNION

SELECT

upt.checkliste_punkt_id
, 'CPR_REALISIERUNG' AS cpr_suchfeld
,'CPR_REALISIERUNG' AS suchfeld_bez
,COALESCE(upt.ok_fg,0)  AS ok_fg
,upt.dat_ende_ist
,COALESCE(upt.cl_punkt_bez,0) AS cl_punkt_bez
,COALESCE(upt.cl_punkt_langtext,0) AS cl_punkt_langtext
,COALESCE(upt.cpr_checkliste_id,0) AS cpr_checkliste_id
,upt.checkliste_nr
,upt.cpr_checkliste_bez
,upt.cpr_checkliste_langtext
,uau.projekt_phase_id
,upt.phasenart_id
,COALESCE(upt.teil_massn_fg,0) AS teil_massn_fg
,COALESCE(upt.teil_massnahme_id,0) AS teil_massnahme_id
,COALESCE(upt.einzel_massnahme,0) AS einzel_massnahme
,COALESCE(upt.cpr_phase_bez,0) AS cpr_phase_bez
,COALESCE(upt.cpr_phase_langtext,0) AS cpr_phase_langtext
,upt.projekt_id
,upt.mandant_id
,COALESCE(upt.land_id,0) AS land_id
,COALESCE(upt.techn_platz_id,0) AS techn_platz_id
,COALESCE(upt.projekt_nr,'') AS projekt_nr
,COALESCE(upr.cpr_systemstatus1_id,9) AS cpr_systemstatus1_id
,CASE	WHEN substr(upt.projekt_nr,9,4) >= 9000 THEN  0  ELSE	 1 END	AS  neu_projekt_fg
,COALESCE(upt.massnahme_id,'') AS massnahme_id
,COALESCE(umsz.massnahme_typ_id,0) AS massnahme_typ_id
,COALESCE(umsz.massnahme_typ_bez,'') AS massnahme_typ_bez
,COALESCE(upt.wup_id,0) AS wup_id
,COALESCE(upt.cpr_standort,0) AS cpr_standort
,upt.cpr_filialtyp_bez
,upt.investor_eigenobj
,upt.cpr_general_planer
,upt.cpr_objekt_steurer
,COALESCE(upt.cpr_projekt_bez,0) AS cpr_projekt_bez
,COALESCE(upt.cpr_projekt_langtext,upt.cpr_phase_langtext, '') AS cpr_projekt_langtext
--,COALESCE(pt.cpr_projekt_langtext, '') AS cpr_projekt_langtext
,upt.spr_id
,upt.dat_extrakt
,upt.cpr_phase_version_id
,upt.cpr_phase_version_dat
,CASE WHEN upt.teil_massn_fg > 1
THEN upt.projekt_id  || upt.projekt_phase_id
ELSE TRIM(upt.projekt_id )|| '0000'
END  bauabschnitt_id
,COALESCE(uau.dat_start_ist,NULL) AS dat_realisierung

FROM dbp_view.v_cpr_cl_punkt_termin_2 upt

LEFT JOIN dbp_view.v_l_massnahme_2 AS umn
ON umn.massnahme_id = upt.massnahme_id

JOIN dbp_view.v_massnahme_typ_spr_zu AS umsz
ON COALESCE(umn.massnahme_typ_id, 99) = umsz.massnahme_typ_id
AND umsz.spr_id = 22

JOIN dbp_view.v_cpr_projekt_per_2 upr
ON upr.projekt_id = upt.projekt_id
--AND pt.dat_ende_ist BETWEEN pr.dat_von and pr.dat_bis
AND upr.dat_bis = '9999-12-31'

LEFT JOIN dbp_view.v_cpr_phase_spr_zu_per_2 uph
ON upt.projekt_phase_id = uph.projekt_phase_id
AND upt.dat_ende_ist BETWEEN uph.dat_von and uph.dat_bis
AND uph.dat_bis = '9999-12-31'
AND uph.spr_id = 22

JOIN dbp_view.v_cpr_aufgabe_per_2 uau
ON upt.projekt_phase_id = uau.projekt_phase_id
AND upt.dat_ende_ist BETWEEN uau.dat_von and uau.dat_bis
AND uau.dat_bis = '9999-12-31'
AND uau.cpr_suchfeld_id = 161

WHERE upr.cpr_systemstatus1_id <> 4 or  upr.cpr_systemstatus1_id IS NULL;*/

;
