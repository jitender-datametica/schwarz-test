CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_projekt_historie (checkliste_punkt_id, cpr_suchfeld_id, ok_fg
, ende_datum, kjmo_stille_eroeff, cl_punkt_bez, cl_punkt_langtext, cpr_checkliste_id, checkliste_nr, cpr_checkliste_bez
, cpr_checkliste_langtext, projekt_phase_id, phasenart_id, teil_massn_fg, teil_massnahme_id, einzel_massnahme,
cpr_phase_bez, cpr_phase_langtext, projekt_id, mandant_id, land_id, techn_platz_id, projekt_nr, massnahme_kz, wup_id,
cpr_standort, cpr_filialtyp_bez, investor_eigenobj, cpr_general_planer, cpr_projekt_steurer, cpr_projekt_bez,
cpr_projekt_langtext, spr_id, dat_extrakt, bauabschnitt_id, bauabschnitt_bez, bauabschnitt_langtext, art_massnahme_id,
baubeginn, beginn_einrichtung, stille_eroeffnung, eroeffnung_tip_top, historie_fg, cpr_phase_version_id,
cpr_phase_version_dat) AS SELECT t9.checkliste_punkt_id,
 t9.cpr_suchfeld_id,
 t9.ok_fg,
 t9.ende_datum,
 t9.kjmo_stille_eroeff,
 t9.cl_punkt_bez,
 t9.cl_punkt_langtext,
 t9.cpr_checkliste_id,
 t9.checkliste_nr,
 t9.cpr_checkliste_bez,
 t9.cpr_checkliste_langtext,
 t9.projekt_phase_id,
 t9.phasenart_id,
 t9.teil_massn_fg,
 t9.teil_massnahme_id,
 t9.einzel_massnahme,
 t9.cpr_phase_bez,
 t9.cpr_phase_langtext,
 t9.projekt_id,
 t9.mandant_id,
 t9.land_id,
 t9.techn_platz_id,
 t9.projekt_nr,
  CASE
  WHEN SUBSTR(t9.massnahme_id, 1, 5) = 'ZPPM_'
  THEN SUBSTR(t9.massnahme_id, 6, LENGTH(t9.massnahme_id) - 5)
  ELSE t9.massnahme_id
  END AS massnahme_id,
 COALESCE(t9.aktuell_wup_id, t9.wup_id, 0) AS wup_id,
 t9.cpr_standort,
 t9.cpr_filialtyp_bez,
 t9.investor_eigenobj,
 t9.cpr_general_planer,
 t9.cpr_projekt_steurer,
 t9.cpr_projekt_bez,
 t9.cpr_projekt_langtext,
 t9.spr_id,
 t9.dat_extrakt,
 t9.bauabschnitt_id,
 t9.bauabschnitt_bez,
 t9.bauabschnitt_langtext,
 t9.massnahme_id0 AS art_massnahme_id,
 t9.baubeginn,
 t9.beginn_einrichtung,
 t9.stille_eroeffnung,
 t9.eroeffnung_tip_top,
 t9.historie_fg,
 t9.cpr_phase_version_id,
 t9.cpr_phase_version_dat
FROM (SELECT PT.checkliste_punkt_id,
   PT.cpr_suchfeld AS cpr_suchfeld_id,
   PT.ok_fg,
    CASE
    WHEN PT.dat_ende_ist <> DATE '1900-01-01'
    THEN PT.dat_ende_ist
    ELSE NULL
    END AS ende_datum,
   PT.cl_punkt_bez,
   PT.cl_punkt_langtext,
   PT.cpr_checkliste_id,
   PT.checkliste_nr,
   PT.cpr_checkliste_bez,
   PT.cpr_checkliste_langtext,
   PT.projekt_phase_id,
   PT.phasenart_id,
   PT.teil_massn_fg,
   PT.teil_massnahme_id,
   PT.einzel_massnahme,
   PT.cpr_phase_bez,
   PT.cpr_phase_langtext,
   PT.projekt_id,
   PT.mandant_id,
   PT.land_id,
   PT.techn_platz_id,
   PT.projekt_nr,
   PT.massnahme_id,
   WUP.aktuell_wup_id,
   PT.wup_id,
   PT.cpr_standort,
   PT.cpr_filialtyp_bez,
   PT.investor_eigenobj,
   PT.cpr_general_planer,
   PT.cpr_objekt_steurer AS cpr_projekt_steurer,
   PT.cpr_projekt_bez,
   PT.cpr_projekt_langtext,
   PT.spr_id,
   PT.dat_extrakt,
    CASE
    WHEN PT.teil_massn_fg > 1
    THEN PT.projekt_id || PT.projekt_phase_id
    ELSE PT.projekt_id || '0000'
    END AS bauabschnitt_id,
    CASE
    WHEN PT.teil_massn_fg > 1
    THEN PT.cpr_phase_bez
    ELSE PT.cpr_projekt_bez
    END AS bauabschnitt_bez,
    CASE
    WHEN PT.teil_massn_fg > 1
    THEN COALESCE(PT.cpr_phase_langtext, '')
    WHEN PT.teil_massn_fg = 1
    THEN COALESCE(PT.cpr_projekt_langtext || '', '') || COALESCE(PT.cpr_phase_langtext, '')
    ELSE COALESCE(PT.cpr_projekt_langtext, '')
    END AS bauabschnitt_langtext,
   PR_M.massnahme_id AS massnahme_id0,
    CASE
    WHEN SUBSTR(PT.techn_platz_id, 4, 8) = '9900' OR PJ.cpr_systemstatus1_id <> 2
    THEN 1
    WHEN PT.teil_massn_fg > 1
    THEN CASE
     WHEN so.stille_eroeff > CURRENT_DATE
     THEN 1
     ELSE CASE
      WHEN PP.cpr_systemstatus1_id <> 2
      THEN 1
      ELSE 0
      END
     END
    ELSE 0
    END AS historie_fg,
   PP.einzel_massnahme AS einzel_massnahme0,
   PP.dat_freigabe,
   PP.cpr_phase_version_id,
   PP.cpr_phase_version_dat,
   MAX(pt01.kjmo_stille_eroeff) AS kjmo_stille_eroeff,
   MAX(CASE
     WHEN PT.cpr_suchfeld = 'BAUBEGINN'
     THEN PT.dat_ende_ist
     ELSE NULL
     END) AS baubeginn,
   MAX(CASE
     WHEN PT.cpr_suchfeld = 'BEGINN_EINRICHTUNG'
     THEN PT.dat_ende_ist
     ELSE NULL
     END) AS beginn_einrichtung,
   MAX(CASE
     WHEN PT.cpr_suchfeld = 'STILLE_EROEFFNUNG'
     THEN PT.dat_ende_ist
     ELSE NULL
     END) AS stille_eroeffnung,
   MAX(CASE
     WHEN PT.cpr_suchfeld = 'EROEFFNUNG_TIP_TOP'
     THEN PT.dat_ende_ist
     ELSE NULL
     END) AS eroeffnung_tip_top
  FROM kfl_production_dbp_view.v_cpr_cl_punkt_termin AS PT
   LEFT JOIN kfl_production_dbp_view.v_l_massnahme AS PR_M ON PT.massnahme_id = PR_M.massnahme_id
   LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_per AS PJ ON PT.projekt_id = PJ.projekt_id AND PJ.dat_bis =
     DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_cpr_phase_per AS PP ON PT.projekt_id = PP.projekt_id AND PP.dat_bis =
     DATE '9999-12-31'
   LEFT JOIN (SELECT projekt_id,
     projekt_phase_id,
     MAX(dat_ende_ist) AS stille_eroeff
    FROM kfl_production_dbp_view.v_cpr_cl_punkt_termin AS PT
    WHERE cpr_suchfeld = 'STILLE_EROEFFNUNG'
     AND ok_fg = 1
    GROUP BY projekt_id,
     projekt_phase_id) AS so ON PT.projekt_id = so.projekt_id AND PT.projekt_phase_id = so.projekt_phase_id
   LEFT JOIN (SELECT projekt_id,
     projekt_phase_id,
     MAX(CASE
       WHEN cpr_suchfeld = 'STILLE_EROEFFNUNG'
       THEN FORMAT_DATE('%Y%m', dat_ende_ist)
       ELSE NULL
       END) AS kjmo_stille_eroeff
    FROM kfl_production_dbp_view.v_cpr_cl_punkt_termin AS PT
    WHERE ok_fg = 1
    GROUP BY projekt_id,
     projekt_phase_id) AS pt01 ON PT.projekt_id = pt01.projekt_id AND PT.projekt_phase_id = pt01.projekt_phase_id
   LEFT JOIN kfl_production_dbp_view.v_wup AS WUP ON PT.wup_id = WUP.wup_id AND PT.mandant_id = WUP.mandant_id
  WHERE PT.ok_fg = 1
  GROUP BY PT.checkliste_punkt_id,
   cpr_suchfeld_id,
   PT.ok_fg,
   ende_datum,
   PT.cl_punkt_bez,
   PT.cl_punkt_langtext,
   PT.cpr_checkliste_id,
   PT.checkliste_nr,
   PT.cpr_checkliste_bez,
   PT.cpr_checkliste_langtext,
   PT.projekt_phase_id,
   PT.phasenart_id,
   PT.teil_massn_fg,
   PT.teil_massnahme_id,
   PT.einzel_massnahme,
   PT.cpr_phase_bez,
   PT.cpr_phase_langtext,
   PT.projekt_id,
   PT.mandant_id,
   PT.land_id,
   PT.techn_platz_id,
   PT.projekt_nr,
   PT.massnahme_id,
   WUP.aktuell_wup_id,
   PT.wup_id,
   PT.cpr_standort,
   PT.cpr_filialtyp_bez,
   PT.investor_eigenobj,
   PT.cpr_general_planer,
   cpr_projekt_steurer,
   PT.cpr_projekt_bez,
   PT.cpr_projekt_langtext,
   PT.spr_id,
   PT.dat_extrakt,
   bauabschnitt_id,
   bauabschnitt_bez,
   bauabschnitt_langtext,
   massnahme_id0,
   historie_fg,
   einzel_massnahme0,
   PP.dat_freigabe,
   PP.cpr_phase_version_id,
   PP.cpr_phase_version_dat) AS t9;