CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WEWA_2 (
	MANDANT_ID ,
	WUP_ID,
	DAT,
	ART_ID,
	WRG_ID,
	WEWA_BELEG_POS_ID,
    LAGER_BEWART_ID,
	GP_ID,
    WEWA_JAHR,
    WEWA_BELEG_ID,
	WEWA_MENGE_ZL,
	WEWA_MENGE_DZ,
	WEWA_MENGE_RET_ZL,
	WEWA_MENGE_RET_DZ,
	WEWA_BETRAG_VK_NETTO 
	)
AS
/*	
    2025-7-01 muellerpatri : Initiale Erstellung der View (AP0274731)
*/
SELECT
	wewa.mandant_id
	, wup.aktuell_wup_id                                                                               AS wup_id
	, dat_buch                                                                                         AS dat
	, art_id
	, krs.nach_wrg_id                                                                                  AS wrg_id
	, wewa_beleg_pos_id
    , lager_bewart_id
    , gp_id
    , wewa_jahr
	, wewa_beleg_id
    , SUM(IFF(lager_bewart_id IN (101, 102, 901, 902) AND wewa.nb_id = -111, menge_basis, 0))          AS wewa_menge_zl  
    , SUM(IFF(lager_bewart_id IN (101, 102, 901, 902) AND wewa.nb_id = 0, menge_basis, 0))             AS wewa_menge_dz 
    , SUM(IFF(lager_bewart_id IN (161, 162) AND wewa.nb_id = -111, menge_basis, 0))                    AS wewa_menge_ret_dz 
    , SUM(IFF(lager_bewart_id IN (161, 162) AND wewa.nb_id = 0, menge_basis, 0))                       AS wewa_menge_ret_dz 
	, ZEROIFNULL(SUM(betrag_vk_netto))                                                                 AS wewa_betrag_vk_netto
FROM dbp_view.v_wewa_2 wewa_2

INNER JOIN dbp_view.v_wup_2 wup_2
ON wewa.mandant_id = wup.mandant_id AND wewa.wup_id = wup.wup_id 

INNER JOIN ( 
  SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
  FROM dbp_data.kurs_2 krs1 
  WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
  AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
  UNION ALL 
  SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
  FROM dbp_data.kurs_2 krs2 
  WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
  AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = wewa.wrg_id

GROUP BY ALL
;