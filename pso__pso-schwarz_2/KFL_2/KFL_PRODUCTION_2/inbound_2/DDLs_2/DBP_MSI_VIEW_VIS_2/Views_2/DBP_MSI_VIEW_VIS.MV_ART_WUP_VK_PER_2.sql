CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WUP_VK_PER_2
AS

-- 30.06.2020 snik1809 AP0029549-SPEC0068832
-- 2022-09-30 ssch0611 : Calculation EUR with new logic [P16167]

SELECT
  art_id
, mandant_id
, wup_id
, nb_id
, dat_von
, dat_bis
, vk_brutto * umrechnungskurs AS vk_brutto
, krs.nach_wrg_id             AS wrg_id
FROM dbp_data.art_wup_vk_per_2 fkt 

INNER JOIN (
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
    FROM dbp_data.kurs_2 krs1
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31'
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
    UNION ALL
    SELECT krs2.von_wrg_id, krs2.von_wrg_id AS nach_wrg_id, 1.00000 AS umrechnungskurs
    FROM dbp_data.kurs_2 krs2
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' 
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')
) krs
ON krs.von_wrg_id = fkt.wrg_id;