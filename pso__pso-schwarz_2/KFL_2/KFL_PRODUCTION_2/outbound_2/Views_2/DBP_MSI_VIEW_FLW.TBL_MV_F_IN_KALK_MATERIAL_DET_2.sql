-- 26.10.2011 system_id entfernt
 -- 21.06.2016 twie SPEC0005119: KST023 gefiltert auf DE und CZ

-- 25.09.2012 twie: weitere 8 Kostenstellen hinzugefuegt
 -- 15.10.2012 twie: Filter auf vorstufe_fg = 0

-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 26.08.2019 twie: SPEC0049505 kalk_variante_id hinzugefuegt, damit nicht aus der mv_f_in_kalk_denorm_2 ermittelt werden muss

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_in_kalk_material_det_2 AS -- keph
 -- keko
 SELECT V01.mandant_id
 ,
 V01.kalk_id,
 V01.kalkulationsart_id,
 V01.dat_kalk,
 V01.kalk_version_id,
 V01.bewertung_variante_id,
 V01.vorstufe_fg,
 V02.dat_kalk_ab,
 V02.dat_kalk_bis,
 T.dat,
 V02.werk_id,
 V02.flw_art_id AS in_art_id,
 V02.kalk_variante_id,
 V01.wrg_id,
 V100.default_wrg,
 V01.kst001,
 V01.kst002,
 V01.kst003,
 V01.kst004,
 V01.kst005,
 V01.kst006,
 V01.kst007,
 V01.kst008,
 V01.kst010,
 V01.kst012,
 V01.kst014,
 V01.kst017,
 V01.kst019,
 V01.kst021,
 V01.kst023
FROM kfl_production_dbp_view.v_flw_kalk_erzeugnis_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kalk_erzeugnis_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kalk_id = V02
       .kalk_id AND V01.kalkulationsart_id = V02.kalkulationsart_id AND V01.dat_kalk = V02.dat_kalk AND V01.kalk_version_id
     = V02.kalk_version_id AND V01.bewertung_variante_id = V02.bewertung_variante_id
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON T.dat BETWEEN V02.dat_kalk_ab AND V02.dat_kalk_bis
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.vorstufe_fg = 0;