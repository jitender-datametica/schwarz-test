CREATE OR REPLACE VIEW DBP_VIEW.V_LAGERBEW_DET_WWC_2 AS 
    SELECT 
        lagerbew_beleg_id
        ,lagerbew_beleg_pos_id
        ,kj
        ,mandant_id
        ,dat_buch
        ,menge_bestand_bme
        ,wert_bestand
        ,system_id
        ,buchungskreis_id
        ,wrg_id
        ,shkum
        ,kostenstelle_id
        ,sachkonto_id
        ,art_id_empfaenger
        ,lagerort_id_empfaenger
        ,art_id_bf
        ,lagerbew_beleg_pos_mutter_id
        ,line_id
        ,endlief_fg
        ,xruem_fg
        ,betrag_exbwr
        ,betrag_bnk
        ,betrag_umbewertung
FROM DBP_DATA.lagerbew_det_wwc_2 ;