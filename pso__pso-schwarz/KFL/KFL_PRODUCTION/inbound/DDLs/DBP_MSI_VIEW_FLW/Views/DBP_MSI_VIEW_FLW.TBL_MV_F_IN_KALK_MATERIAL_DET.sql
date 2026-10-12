CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_KALK_MATERIAL_DET 
-- 26.10.2011 system_id entfernt
-- 25.09.2012 twie: weitere 8 Kostenstellen hinzugefuegt
--15.10.2012 twie: Filter auf vorstufe_fg = 0
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2016 twie SPEC0005119: KST023 gefiltert auf DE und CZ
-- 26.08.2019 twie: SPEC0049505 kalk_variante_id hinzugefuegt, damit nicht aus der mv_f_in_kalk_denorm ermittelt werden muss
AS
SELECT
    v01.mandant_id,
    v01.kalk_id,
    v01.kalkulationsart_id,
    v01.dat_kalk,
    v01.kalk_version_id,
    v01.bewertung_variante_id,
    v01.vorstufe_fg,
    v02.dat_kalk_ab,
    v02.dat_kalk_bis,
    t.dat,
    v02.werk_id,
    v02.flw_art_id AS in_art_id,
    v02.kalk_variante_id,
    v01.wrg_id,
    v100.default_wrg,
    v01.KST001,
    v01.KST002,
    v01.KST003,
    v01.KST004,
    v01.KST005,
    v01.KST006,
    v01.KST007, 
    v01.KST008,
    v01.KST010,
    v01.KST012,
    v01.KST014,
    v01.KST017,
    v01.KST019,
    v01.KST021,
    v01.KST023
FROM
    dbp_view.v_flw_kalk_erzeugnis_det v01 -- keph
    JOIN dbp_view.v_flw_kalk_erzeugnis v02 -- keko
    ON v01.mandant_id = v02.mandant_id
    AND v01.kalk_id = v02.kalk_id
    AND v01.kalkulationsart_id = v02.kalkulationsart_id
    AND v01.dat_kalk = v02.dat_kalk
    AND v01.kalk_version_id = v02.kalk_version_id
    AND v01.bewertung_variante_id = v02.bewertung_variante_id
    JOIN dbp_view.v_tag t ON t.dat BETWEEN v02.dat_kalk_ab
    AND v02.dat_kalk_bis
    JOIN dbp_view.v_mandant v100 ON v01.mandant_id = v100.mandant_id
where
    v01.vorstufe_fg = 0;