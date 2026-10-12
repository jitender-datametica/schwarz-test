CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_ART_1 AS 
SELECT DISTINCT
    v01.art_id,
    v01.mandant_id,
    v01.mwst_id,
    v01.land_id,
    v01.region_id,
    v01.kl_art_id,
    v01.dat_von,
    v01.dat_bis,
    v01.loesch_id,
    v01.mutter_wb_id,
    v02.KL_ART_ID AS mutter_wb_kl_art_id,
    --CASE WHEN v01.artikeltyp_id = 12 THEN 'X' ELSE ' ' END AS display_fg, 
    /*v04.ART_ID AS display_art_id,
    v05.KL_ART_ID AS display_kl_art_id,*/
    v01.posten_KZ_SAP,
    v01.zek_id, 
    v01.saison_id,
    CASE WHEN v001.art_id IS NOT NULL THEN 1 ELSE 0 END AS ART_PROMO_FLAG

FROM DBP_VIEW.V_ART_1 v01
-- Einschraekung auf nur die Artikel_1 die wirklich im Frontend relevant sind 
LEFT JOIN DBP_VIEW.V_NFMD_ART_PROMOTION_1 v001
ON v001.art_id = v01.art_id
AND v001.mandant_id = v001.mandant_id
-- Fuer die KL_ART_ID der Mutter_WB_ID
LEFT JOIN DBP_VIEW.V_ART_1 v02
ON v01.MANDANT_ID = v02.MANDANT_ID
AND v01.MUTTER_WB_ID = v02.ART_ID
;