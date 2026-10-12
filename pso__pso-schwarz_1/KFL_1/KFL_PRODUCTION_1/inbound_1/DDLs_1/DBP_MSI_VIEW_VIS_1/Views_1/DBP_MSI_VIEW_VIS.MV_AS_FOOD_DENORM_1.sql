CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AS_FOOD_DENORM_1 (
    ART_ID, 
    MANDANT_ID, 
    NB_ID, 
    WUP_ID, 
    WRG_ID, 
    AS_DAT_AUSLISTUNG, 
    AS_DAT_AEND, 
    AS_DAT_FINAL, 
    AS_FINAL_ERL_KZ, 
    AS_FINAL_STATUS_ID, 
    AS_MENGE_STARTBESTAND, 
    AS_MENGE_ENDBESTAND, 
    AS_ERL_FG, 
    AS_ERL_KZ, 
    AS_PHASE_STATUS,
    KJWO, 
    AS_MENGE_TOTALABSCHRIFT, 
    AS_MENGE_PREISABSCHRIFT, 
    AS_MENGE_ABSATZ, 
    AS_PREISABSCHRIFT_NETTO, 
    AS_TOTALABSCHRIFT_NETTO, 
    AS_UMSATZ_NETTO, 
    AS_PHASE_ID, 
    AS_PHASE_WO, 
    AS_PHASE_MENGE_ENDBESTAND, 
    AS_PHASE_VK_BRUTTO, 
    AS_PHASE_VK_NETTO,
    AS_MENGE_ENDBESTAND_DET
) AS 
 
/*
    FAKT DENORM : AS FOOD Daten (Kopf + Detail)
    2024-09-22 ssch0611 : Initial. Review mit neuen Spalten [AP0228698]
    2025-07-25 muellerpatri : Erweiterung um Spalte menge_endbestand
*/
 
SELECT
  asd.art_id
, asd.mandant_id
, asd.nb_id
, wup.aktuell_wup_id      AS wup_id 
, krs.nach_wrg_id         AS wrg_id
, asd.dat_auslistung      AS as_dat_auslistung
, asf.dat_aend            AS as_dat_aend 
 /* Daten finale Woche_1 */
, asd.dat_final           AS as_dat_final
, asd.erl_kz              AS as_final_erl_kz     /* enthält erl_kz in Finalwoche oder "SPACE" */
, asd.as_final_status_id  AS as_final_status_id /* 0 = kein Restbestand (default), 1 = Absatz trotz Finaldatum, 2 = Finaldatum ohne erl_kz D (= Abschrift) */
 /* Daten Kopftabelle */
, CASE 
    WHEN asd.kjwo = MIN(asd.kjwo) OVER(PARTITION BY asd.art_id, asd.mandant_id, wup.aktuell_wup_id, krs.nach_wrg_id, asd.dat_auslistung)
    THEN asf.menge_startbestand
  END AS as_menge_startbestand /* gemappt auf erste Woche_1 */
, CASE 
    WHEN asd.kjwo = MAX(asd.kjwo) OVER(PARTITION BY asd.art_id, asd.mandant_id, wup.aktuell_wup_id, krs.nach_wrg_id, asd.dat_auslistung) 
    THEN asf.menge_endbestand
  END AS as_menge_endbestand /* gemappt auf letzte Woche_1 */
, asf.erl_fg       AS as_erl_fg /* erl_fg : 0 = erl_kz (B,''), 1 = erl_kz (A,C,D,E,F,G,X),*/
, asf.erl_kz       AS as_erl_kz 
, asf.phase_status AS as_phase_status /* letzte Phase aus Kopf */
 /* Daten Woche_1 */
, asd.kjwo
, asd.menge_totalabschrift                              AS as_menge_totalabschrift
, asd.menge_preisabschrift                              AS as_menge_preisabschrift
, asd.menge_absatz                                      AS as_menge_absatz
, asd.betrag_preisabschrift_netto * krs.umrechnungskurs AS as_preisabschrift_netto
, asd.betrag_totalabschrift_netto * krs.umrechnungskurs AS as_totalabschrift_netto
, asd.umsatz_netto * krs.umrechnungskurs                AS as_umsatz_netto
 /* Daten Phase */
, asd.phase_id                              AS as_phase_id
, asd.phase_wo                              AS as_phase_wo 
, asd.menge_endbestand_phase                AS as_phase_menge_endbestand
, asd.phase_vk_brutto * krs.umrechnungskurs AS as_phase_vk_brutto
, asd.phase_vk_netto * krs.umrechnungskurs  AS as_phase_vk_netto
, asd.menge_endbestand                                  AS as_menge_endbestand_det
FROM DBP_DATA.AS_FOOD_DET_1 asd 
 
INNER JOIN DBP_DATA.AS_FOOD_1 asf_1 
ON asf.MANDANT_ID = asd.MANDANT_ID AND asf.wup_id = asd.wup_id
AND asf.art_id = asd.art_id AND asf.dat_auslistung = asd.dat_auslistung
 
INNER JOIN DBP_DATA.WUP_1 wup_1 
ON wup.MANDANT_ID = asd.MANDANT_ID AND wup.wup_id = asd.wup_id
 
INNER JOIN DBP_DATA.WOCHE_1 zeit_1 
ON zeit.kjwo = asd.kjwo
 
INNER JOIN ( /* 1 Umrechnung in EUR */
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
    FROM DBP_DATA.KURS_1 krs1 
    WHERE krs1.KURSTYP_ID = 3 AND krs1.DAT_BIS = '9999-12-31' 
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
    UNION ALL /* 2 Landeswährung */
    SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
    FROM DBP_DATA.KURS_1 krs2 
    WHERE krs2.KURSTYP_ID = 3 AND krs2.DAT_BIS = '9999-12-31'  
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = asd.wrg_id
;