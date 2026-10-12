CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_DAT_LEERGUT_1 (
	  MANDANT_ID,
	  WUP_ID,
    NB_ID,
	  DAT,
	  WRG_ID,
	  BETRAG_LEERGUT_ZAEHLUNG,
    BETRAG_LEERGUT_INVENTUR,
    TD_UPDATE,
    TD_INSERT
) AS  
/* 
   FAKT Leergut - Eingabe 
   2025-03-20 muellerpatri : initiale Erstellung [AP0228745]
*/
SELECT 
  lg.mandant_id
  , wup.aktuell_wup_id                AS wup_id
  , lg.nb_id
  , lg.dat
  , krs.nach_wrg_id                   AS wrg_id
  , lg.betrag_leergut_zaehlung
  , lg.betrag_leergut_inventur
  , lg.td_update
  , lg.td_insert
FROM DBP_MSI_DATA.TS_WUP_DAT_LEERGUT_1  lg
INNER JOIN ( 
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM DBP_DATA.KURS_1  krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM DBP_DATA.KURS_1  krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = lg.wrg_id

INNER JOIN dbp_view.v_wup_1 wup_1
ON lg.mandant_id = wup.mandant_id AND lg.wup_id = wup.wup_id

;