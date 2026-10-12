CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WUP_RUECKGABE_VERWENDUNG(
    MANDANT_ID,
	RUECKGABE_NR,
	DAT,
    DAT_RUECKGABE,
	WUP_ID,
	NB_ID,
	REKLAMATIONSGRUND_ID,
	ART_ID,
	EINH_ID,
	WRG_ID,
	DAT_MHD,
	RUECKGABE_VERWENDUNG_KZ,
	VERARBEITET_FG,
	DAT_VERARBEITUNG,
    MENGE_ART,
    BETRAG_VK_NETTO_RUECKGABE,
	BETRAG_VK_NETTO_KAUF
) AS 
/* 
   2024-10-01 muellerpatri : Initiale Erstellung der View, AP0212768
*/
SELECT 
    rv.mandant_id
    , rv.rueckgabe_nr
    , rv.dat_rueckgabe                              AS dat
    , rv.dat_rueckgabe
    , wup.aktuell_wup_id 						AS wup_id
    , rv.nb_id
    , rv.reklamationsgrund_id
    , rv.art_id
    , rv.einh_id
    , rv.wrg_id
    , rv.dat_mhd
    , rv.rueckgabe_verwendung_kz
    , rv.verarbeitet_fg
    , rv.dat_verarbeitung
    , rv.menge_art
    , rv.betrag_vk_netto_rueckgabe * krs.umrechnungskurs
    , rv.betrag_vk_netto_kauf * krs.umrechnungskurs
FROM 
DBP_VIEW.V_ART_WUP_RUECKGABE_VERWENDUNG rv

INNER JOIN ( 
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
    FROM dbp_data.kurs krs1 
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
    UNION ALL 
    SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
    FROM dbp_data.kurs krs2 
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = rv.wrg_id

INNER JOIN dbp_view.v_wup wup
ON rv.mandant_id = wup.mandant_id AND rv.wup_id = wup.wup_id
;
