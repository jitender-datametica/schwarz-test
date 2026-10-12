create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_ARTBEW(
	DAT,
	MANDANT_ID,
	ART_ID,
	IN_KUNDE_ID,
	KUNDE_NR,
	KUNDE_NAME,
	IN_ART_ID,
	IN_ART_NR,
	VK_MENGE_ORG,
	BASISMENGE_EINH_ID,
	VK_MENGE_ST,
	VK_MENGE_KG,
	UMSATZ_NETTO,
	EK_MEP_UMSATZ_TEMP,
	EK_MEP_UMSATZ,
	BEWART_ID,
	GP_ID,
	WRG_ID
) as
SELECT
   v01.dat,
   v01.mandant_id,
   v01.art_id,
   in_kunde_id,
   kunde_nr,
   kunde_name,
   in_art_id,
   in_art_nr,
   vk_menge_org,
   basismenge_einh_id,
   vk_menge_st,
   vk_menge_kg,
   CAST(
      CASE
         WHEN v01.wrg <> v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(v01.umsatz_netto, 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
         WHEN v01.wrg <> v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN (
            COALESCE(v01.umsatz_netto, 0) / v500.umrechnungskurs
         ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
         WHEN v01.wrg = v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(v01.umsatz_netto, 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
         WHEN v01.wrg = v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN COALESCE(v01.umsatz_netto, 0)
      END AS DECIMAL(18, 4)
   ) AS umsatz_netto,
   ek_mep_umsatz_temp,
   CAST(
      CASE
         WHEN v01.wrg <> v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(ek_mep_umsatz_temp, 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
         WHEN v01.wrg <> v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN (
            COALESCE(ek_mep_umsatz_temp, 0) / v500.umrechnungskurs
         ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
         WHEN v01.wrg = v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(ek_mep_umsatz_temp, 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
         WHEN v01.wrg = v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN COALESCE(ek_mep_umsatz_temp, 0)
      END AS DECIMAL(18, 4)
   ) AS ek_mep_umsatz,
   v01.bewart_id,
   v01.gp_id,
   v400.wrg_id
FROM
   DBP_MSI_VIEW_FLW_MATERIALIZED.tbl_MV_F_ARTBEW v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300
   JOIN dbp_view.v_mandant_wrg_typ_zu v400 ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs v500 ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v01.dat BETWEEN v500.dat_von
   AND v500.dat_bis;