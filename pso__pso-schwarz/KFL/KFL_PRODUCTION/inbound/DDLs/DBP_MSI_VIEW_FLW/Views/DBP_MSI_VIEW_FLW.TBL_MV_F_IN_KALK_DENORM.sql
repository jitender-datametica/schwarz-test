CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_KALK_DENORM AS 
   SELECT
   v01.mandant_id, v01.dat_kalk   AS dat, 
   v01.dat_kalk_ab AS dat_kalk_ab, 
   v01.dat_kalk_bis AS dat_kalk_bis, 
   v01.flw_art_id AS in_art_id, 
   v01.werk_id, v01.kalk_id, 
   v01.bewertung_variante_id,  
   v01.losgroesse, 
   v01.wrg_id, 
   datediff(day,v01.dat_kalk_ab,v01.dat_kalk_bis) as gueltig,
   v01.kalkulationsart_id AS kalkulationsart_id, v01.kalk_variante_id AS kalk_variante_id, v01.kalk_version_id AS kalk_version_id
   , v100.default_wrg, v01.mek_rohmaterial, v01.mek_verarbeitungsmaterial, v01.mek_zusaetze, v01.mek_fertigerzeugnis,
   v01.mek_verpackung, v01.fek_trennprozess, v01.fek_mischprozess, v01.vertriebs_einzelkosten, v01.material_gemeinkosten,
   v01.fertigungs_gemeinkosten, v01.vertriebs_gemeinkosten, v01.verwaltungs_gemeinkosten, v01.mbew_preis

   FROM dbp_view.v_flw_kalk_denorm v01

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id;