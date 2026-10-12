-- und aufgabenart_id in ('A2','Z1')
 -- ,massnahme_typ_id

-- 20160511 k.kaiser: SPEC0009788, bauabschnitte aus der cpr_aufgabe_per_1 werden auch mitberücksichtigt, wenn cpr_suchfeld_id 161 (= cpr_suchfeld_bez = 'CPR_REALISIERUNG')

-- ,massnahme_typ_bez
 -- 20241205 alavih: Filialumgliederung

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_termin_1 (checkliste_punkt_id, cpr_suchfeld_id,
suchfeld_bez, ok_fg, dat_ende_ist, cl_punkt_bez, cl_punkt_langtext, cpr_checkliste_id, checkliste_nr, cpr_checkliste_bez
, cpr_checkliste_langtext, projekt_phase_id, phasenart_id, teil_massn_fg, teil_massnahme_id, einzel_massnahme,
cpr_phase_bez, cpr_phase_langtext, projekt_id, mandant_id, land_id, techn_platz_id, projekt_nr, cpr_systemstatus1_id,
neu_projekt_fg, massnahme_id, massnahmentyp_id, massnahmentyp_bez, wup_id, cpr_standort, cpr_filialtyp_bez,
investor_eigenobj, cpr_general_planer, cpr_objekt_steurer, cpr_projekt_bez, cpr_projekt_langtext, spr_id, dat_extrakt,
cpr_phase_version_id, cpr_phase_version_dat, bauabschnitt_id, dat_realisierung) AS
-- ,COALESCE(msz.massnahmentyp_id,-1) AS massnahme_typ_id
 -- ,COALESCE(msz.massnahmentyp_bez,'') AS massnahme_typ_bez

-- ,COALESCE(pt.wup_id,0) AS wup_id
 -- ,COALESCE(pt.cpr_projekt_langtext, '') AS cpr_projekt_langtext

-- ON COALESCE(el.massnahmentyp_id, -1) = msz.massnahmentyp_id
 -- AND au.cpr_suchfeld_id = 161

/* UNION

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

FROM KFL_PRODUCTION.dbp_view.v_cpr_cl_punkt_termin_1 upt

LEFT JOIN KFL_PRODUCTION.dbp_view.v_l_massnahme_1 AS umn
ON umn.massnahme_id = upt.massnahme_id

JOIN KFL_PRODUCTION.dbp_view.v_massnahme_typ_spr_zu AS umsz
ON COALESCE(umn.massnahme_typ_id, 99) = umsz.massnahme_typ_id
AND umsz.spr_id = 22

JOIN KFL_PRODUCTION.dbp_view.v_cpr_projekt_per_1 upr
ON upr.projekt_id = upt.projekt_id
--AND pt.dat_ende_ist BETWEEN pr.dat_von and pr.dat_bis
AND upr.dat_bis = '9999-12-31'

LEFT JOIN KFL_PRODUCTION.dbp_view.v_cpr_phase_spr_zu_per_1 uph
ON upt.projekt_phase_id = uph.projekt_phase_id
AND upt.dat_ende_ist BETWEEN uph.dat_von and uph.dat_bis
AND uph.dat_bis = '9999-12-31'
AND uph.spr_id = 22

JOIN KFL_PRODUCTION.dbp_view.v_cpr_aufgabe_per_1 uau
ON upt.projekt_phase_id = uau.projekt_phase_id
AND upt.dat_ende_ist BETWEEN uau.dat_von and uau.dat_bis
AND uau.dat_bis = '9999-12-31'
AND uau.cpr_suchfeld_id = 161

WHERE upr.cpr_systemstatus1_id <> 4 or  upr.cpr_systemstatus1_id IS NULL; */
SELECT PT.checkliste_punkt_id,
 PT.cpr_suchfeld AS cpr_suchfeld_id,
 PT.suchfeld_bez,
 COALESCE(PT.ok_fg, 0) AS ok_fg,
 PT.dat_ende_ist,
 COALESCE(PT.cl_punkt_bez, '0') AS cl_punkt_bez,
 COALESCE(PT.cl_punkt_langtext, '0') AS cl_punkt_langtext,
 COALESCE(PT.cpr_checkliste_id, '0') AS cpr_checkliste_id,
 PT.checkliste_nr,
 PT.cpr_checkliste_bez,
 PT.cpr_checkliste_langtext,
 PT.projekt_phase_id,
 PT.phasenart_id,
 COALESCE(PT.teil_massn_fg, 0) AS teil_massn_fg,
 COALESCE(PT.teil_massnahme_id, '0') AS teil_massnahme_id,
 COALESCE(PT.einzel_massnahme, '0') AS einzel_massnahme,
 COALESCE(PT.cpr_phase_bez, '0') AS cpr_phase_bez,
 COALESCE(PT.cpr_phase_langtext, '0') AS cpr_phase_langtext,
 PT.projekt_id,
 PT.mandant_id,
 COALESCE(PT.land_id, '0') AS land_id,
 COALESCE(PT.techn_platz_id, '0') AS techn_platz_id,
 COALESCE(PT.projekt_nr, '') AS projekt_nr,
 COALESCE(PR.cpr_systemstatus1_id, 9) AS cpr_systemstatus1_id,
  CASE
  WHEN CAST(SUBSTR(PT.projekt_nr, 9, 4) AS FLOAT64) >= 9000
  THEN 0
  ELSE 1
  END AS neu_projekt_fg,
 COALESCE(PT.massnahme_id, ' -1') AS massnahme_id,
 COALESCE(MSZ.massnahmentyp_id, - 1) AS massnahmentyp_id,
 COALESCE(MSZ.massnahmentyp_bez, '') AS massnahmentyp_bez,
 COALESCE(W.aktuell_wup_id, PT.wup_id, 0) AS wup_id,
 COALESCE(PT.cpr_standort, '0') AS cpr_standort,
 PT.cpr_filialtyp_bez,
 PT.investor_eigenobj,
 PT.cpr_general_planer,
 PT.cpr_objekt_steurer,
 COALESCE(PT.cpr_projekt_bez, '0') AS cpr_projekt_bez,
 COALESCE(PT.cpr_projekt_langtext, PT.cpr_phase_langtext, '') AS cpr_projekt_langtext,
 PT.spr_id,
 PT.dat_extrakt,
 PT.cpr_phase_version_id,
 PT.cpr_phase_version_dat,
  CASE
  WHEN PT.teil_massn_fg > 1
  THEN PT.projekt_id || PT.projekt_phase_id
  ELSE TRIM(PT.projekt_id) || '0000'
  END AS bauabschnitt_id,
 AU.dat_start_ist AS dat_realisierung
FROM kfl_production_dbp_view.v_cpr_cl_punkt_termin_1 AS PT
 LEFT JOIN kfl_production_dbp_view.v_l_massnahme_1 AS MN ON PT.massnahme_id
  -- CROSS JOIN KFL_PRODUCTION.dbp_view.v_massnahme_typ_spr_zu AS msz

  -- ON COALESCE(mn.massnahme_typ_id, 99) = msz.massnahme_typ_id
 -- AND msz.spr_id = 22
 = MN.massnahme_id
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR ON PT.projekt_id
   -- AND pt.dat_ende_ist BETWEEN pr.dat_von and pr.dat_bis
 = PR.projekt_id AND PR.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_rpm_element_per_1 AS EL ON PR.projekt_id = EL.projekt_id AND EL.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_massnahmentyp_spr_zu_1 AS MSZ ON EL.massnahmentyp_id = MSZ.massnahmentyp_id AND MSZ.spr_id
    = 22
 LEFT JOIN kfl_production_dbp_view.v_cpr_phase_spr_zu_per_1 AS PH ON PT.projekt_phase_id = PH.projekt_phase_id AND PT.dat_ende_ist
     BETWEEN PH.dat_von AND PH.dat_bis AND PH.dat_bis = DATE '9999-12-31' AND PH.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_cpr_aufgabe_per_1 AS AU ON PT.projekt_phase_id = AU.projekt_phase_id AND PT.dat_ende_ist
    BETWEEN AU.dat_von AND AU.dat_bis AND AU.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_projekt_bauabschnitt_1 AS BAS ON PR.cpr_ext_id = BAS.projekt_nr
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W ON COALESCE(PT.wup_id, 0) = W.wup_id AND PT.mandant_id = W.mandant_id
WHERE PR.cpr_systemstatus1_id IS NULL
 OR PR.cpr_systemstatus1_id <> 4;