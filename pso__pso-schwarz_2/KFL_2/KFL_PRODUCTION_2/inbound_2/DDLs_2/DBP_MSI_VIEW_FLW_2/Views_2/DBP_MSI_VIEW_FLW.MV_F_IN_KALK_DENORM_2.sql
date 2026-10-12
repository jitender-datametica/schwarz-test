CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_KALK_DENORM_2
AS 
   SELECT 
   CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN 1
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( 1 / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN  v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN 1
   END AS umrechnungsfaktor
   , 
   v01.mandant_id, dat, 
   dat_kalk_ab, 
   dat_kalk_bis, 
   in_art_id, 
   v01.werk_id, v01.kalk_id, 
   v01.bewertung_variante_id, 
  CAST(v01.mek_rohmaterial * umrechnungsfaktor AS DECIMAL(18,6)) AS mek_rohmaterial, 
   CAST(v01.mek_verarbeitungsmaterial * umrechnungsfaktor AS DECIMAL(18,6)) AS mek_verarbeitungsmaterial, 
   CAST(v01.mek_zusaetze * umrechnungsfaktor AS DECIMAL(18,6)) AS mek_zusaetze, 
   CAST(v01.mek_fertigerzeugnis * umrechnungsfaktor AS DECIMAL(18,6)) AS mek_fertigerzeugnis, 
   CAST(v01.mek_verpackung * umrechnungsfaktor AS DECIMAL(18,6)) AS mek_verpackung, 
   CAST(v01.fek_trennprozess * umrechnungsfaktor AS DECIMAL(18,6)) AS fek_trennprozess, 
   CAST(v01.fek_mischprozess * umrechnungsfaktor AS DECIMAL(18,6)) AS fek_mischprozess, 
   CAST(v01.vertriebs_einzelkosten * umrechnungsfaktor AS DECIMAL(18,6)) AS vertriebs_einzelkosten, 
   CAST(v01.material_gemeinkosten * umrechnungsfaktor AS DECIMAL(18,6)) AS material_gemeinkosten, 
   CAST(v01.fertigungs_gemeinkosten * umrechnungsfaktor AS DECIMAL(18,6)) AS fertigungs_gemeinkosten, 
   CAST(v01.vertriebs_gemeinkosten * umrechnungsfaktor AS DECIMAL(18,6)) AS vertriebs_gemeinkosten, 
   CAST(v01.verwaltungs_gemeinkosten * umrechnungsfaktor AS DECIMAL(18,6)) AS verwaltungs_gemeinkosten, 
   v01.losgroesse, CAST(v01.mbew_preis * umrechnungsfaktor AS DECIMAL(18,6)) AS mbew_preis,
   v01.wrg_id, 
   gueltig,
   kalkulationsart_id, kalk_variante_id, kalk_version_id
FROM DBP_MSI_VIEW_FLW.TBL_MV_F_IN_KALK_DENORM_2 v01 
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_2 v500
   ON V300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis;