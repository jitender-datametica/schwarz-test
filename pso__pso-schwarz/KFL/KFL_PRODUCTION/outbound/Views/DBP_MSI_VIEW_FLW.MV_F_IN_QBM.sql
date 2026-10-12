CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_in_qbm (dat, rekl_grund_id, in_art_id, in_art_nr,
in_kunde_id, mandant_id, gp_id, basismenge_einh_id, mhd, los_charge, vk_menge_re_org, vk_menge_re_st, vk_menge_re_kg) AS
SELECT V01.dat,
 V01.reklamationsgrund_id AS rekl_grund_id,
 V03.flw_art_id AS in_art_id,
 V03.in_art_nr,
 V05.flw_kunde_id AS in_kunde_id,
 V01.mandant_id,
 V01.gp_id,
 V03.basismenge_einh_id,
 V01.mhd,
 V01.los_charge,
 SUM(V01.vk_menge_re) AS vk_menge_re_org,
 SUM(CASE
   WHEN V03.basismenge_einh_id = 'KG' AND V03.flw_art_id >= 0
   THEN ROUND(CAST(V01.vk_menge_re * V06.umrech_faktor AS NUMERIC), 6)
   WHEN V03.basismenge_einh_id = 'KG' AND V03.flw_art_id < 0
   THEN ROUND(CAST(V01.vk_menge_re * V07.umrech_faktor AS NUMERIC), 6)
   WHEN V03.basismenge_einh_id = 'ST'
   THEN V01.vk_menge_re
   ELSE NULL
   END) AS vk_menge_re_st,
 SUM(CASE
   WHEN V03.basismenge_einh_id = 'KG'
   THEN V01.vk_menge_re
   WHEN V03.basismenge_einh_id = 'ST' AND V03.flw_art_id >= 0
   THEN ROUND(CAST(V01.vk_menge_re * V06.umrech_faktor AS NUMERIC), 6)
   WHEN V03.basismenge_einh_id = 'ST' AND V03.flw_art_id < 0
   THEN ROUND(CAST(V01.vk_menge_re * V07.umrech_faktor AS NUMERIC), 6)
   ELSE NULL
   END) AS vk_menge_re_kg
FROM kfl_production_dbp_view.v_rekl AS V01
 LEFT JOIN kfl_production_dbp_view.v_art AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id AND V01.dat
   BETWEEN V02.dat_von AND V02.dat_bis
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art AS V03 ON V02.art_id = V03.art_id AND V02.mandant_id = V03.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde AS V05 ON V01.wup_id = V05.wup_id AND V01.mandant_id = V05.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per AS V06 ON V03.mandant_id = V06.mandant_id AND V03.flw_art_id
     = V06.flw_art_id AND CASE
    WHEN V03.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V03.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V06.altnv_menge_einh_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS V07 ON V03.mandant_id = V07.mandant_id AND V03.art_id
     = V07.art_id AND CASE
     WHEN V03.basismenge_einh_id = 'ST'
     THEN 'KG'
     WHEN V03.basismenge_einh_id = 'KG'
     THEN 'ST'
     ELSE NULL
     END = V07.altnv_menge_einh_id AND V07.dat_bis = DATE '9999-12-31'
WHERE V01.mandant_id = 1
 AND V02.dat_bis = DATE '9999-12-31'
 AND V01.bon_storno_fg = 0
GROUP BY V01.dat,
 rekl_grund_id,
 in_art_id,
 V03.in_art_nr,
 in_kunde_id,
 V01.mandant_id,
 V01.gp_id,
 V03.basismenge_einh_id,
 V01.mhd,
 V01.los_charge;