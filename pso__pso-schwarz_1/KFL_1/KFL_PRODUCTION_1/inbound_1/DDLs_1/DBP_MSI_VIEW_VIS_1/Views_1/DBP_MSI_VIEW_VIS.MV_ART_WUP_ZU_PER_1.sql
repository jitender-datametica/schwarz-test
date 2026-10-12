CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WUP_ZU_PER_1
AS

-- RELATION
-- 2020-05-29, snik1809 - AP0047448, SPEC0067726
-- 2020-12-01 ssch0611 : Review, moved  MaxKapa to vis_tag_fwws, AP0047448_SPEC0095251
-- 2022-09-30 ssch0611 : Calculation EUR with new logic [P16167]

SELECT
awp.mandant_id,
awp.nb_id,
awp.wup_id,
awp.dat_von,
awp.dat_bis,
awp.art_id,
awp.bezugsweg_id,
awp.listung_id,
awp.kdis,
awp.vk_brutto * krs.umrechnungskurs AS vk_brutto,
krs.nach_wrg_id AS wrg_id
FROM dbp_view.v_art_wup_zu_per_1 awp

INNER JOIN (
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
    FROM dbp_data.kurs_1 krs1
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31'
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
    UNION ALL
    SELECT krs2.von_wrg_id, krs2.von_wrg_id AS nach_wrg_id, 1.00000 AS umrechnungskurs
    FROM dbp_data.kurs_1 krs2
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' 
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')
) krs
ON krs.von_wrg_id = awp.wrg_id;