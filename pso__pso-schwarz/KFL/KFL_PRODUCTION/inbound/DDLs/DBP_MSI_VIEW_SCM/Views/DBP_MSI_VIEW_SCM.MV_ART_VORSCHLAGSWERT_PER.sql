CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_art_vorschlagswert_per 
--- 16082019 dsim0608 - AP0043130_SPEC0056784
--- 31.03.2021, srom0404, AP0077805, SPEC0108204 - Lieferantenmanagement, Eingrenzung dat_bis
--- 20.07.2021, srom0404, AP0077805, SPEC0108204 - Lieferantenmanagement, COALESCE(ausg_menge_einh_id)
-- 2023-06-22, dknop, correction to ausg_menge_einh_id - adding ''
AS
SELECT v01.mandant_id
      ,v01.art_id
      ,v01.dat_von
      ,TRIM(CASE WHEN v01.ausg_menge_einh_id <> '' THEN v01.ausg_menge_einh_id ELSE '1' END) AS ausg_menge_einh_id
      ,v01.paletten_faktor_einh_id
      ,v01.dat_bis
      ,v01.sortimentslistenart_id
      ,v01.zl_kolli_menge_einh_id
      ,v01.lage_faktor_einh_id
      ,v01.auspack_fg
FROM DBP_VIEW.v_art_vorschlagswert_per v01
WHERE v01.dat_bis = '9999-12-31';