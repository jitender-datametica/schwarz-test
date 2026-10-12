CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_GANZPALETTE_FG_1 as
   SELECT
   v01.mandant_id, v01.art_id, CASE WHEN v01.ausg_menge_einh_id = 'PAL' THEN 1 ELSE 0 END AS ganzpalette_pg
   FROM dbp_view.v_art_vorschlagswert_per_1 v01
   WHERE v01.mandant_id <> 1 AND v01.dat_bis = '9999-12-31'
   UNION ALL
   SELECT
   v01.mandant_id, v01.art_id, CASE WHEN v01.ausg_menge_einh_id=v01.paletten_faktor_einh_id AND trim(v01.ausg_menge_einh_id) <> '' THEN 1 ELSE 0 END AS ganzpalette_fg
   FROM dbp_view.v_art_vorschlagswert_per_1 v01
   WHERE v01.mandant_id=1 AND v01.dat_bis='9999-12-31';