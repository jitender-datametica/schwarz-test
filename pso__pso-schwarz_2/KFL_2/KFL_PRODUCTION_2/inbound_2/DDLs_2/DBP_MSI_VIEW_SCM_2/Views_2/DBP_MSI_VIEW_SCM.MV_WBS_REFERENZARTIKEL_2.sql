CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBS_REFERENZARTIKEL_2 AS
-- 26.01.2022 richternic: Neu Anlage_2 - Migration AI Cloud
-- 30.03.2022 richternic: Einschränkung auf max dat_berechnung 
WITH MAX_DAT_BERECHNUNG AS (
        Select mandant_id, 
                MAX(dat_berechnung) AS max_dat_berechnung
        FROM DBP_VIEW.V_WBS_REFERENZARTIKEL_2
        GROUP BY mandant_id
)
 SELECT 
        v01.mandant_id
        ,art_id
        ,ref_art_id
        ,ref_anz_maerkte
        ,avg_vk_brutto
        ,avg_ref_vk_brutto
        ,ref_score_rang
        ,ref_score
        ,diff_vk
        ,diff_absatz
        ,diff_absatz_absolut
        ,diff_absatz_kennz
        ,diff_cosinus
        ,diff_gewicht
        ,diff_wug
        ,aktion_id
        ,ref_ltz_dat_von
        ,dat_von
        ,ltz_dat_von
        ,berechnung_typ
        ,dat_berechnung
        ,selektor_fg
        ,berechnung_subtyp
FROM DBP_VIEW.V_WBS_REFERENZARTIKEL_2 v01
JOIN MAX_DAT_BERECHNUNG v02
ON v01.mandant_id = v02.mandant_id
AND v01.dat_berechnung = v02.max_dat_berechnung;