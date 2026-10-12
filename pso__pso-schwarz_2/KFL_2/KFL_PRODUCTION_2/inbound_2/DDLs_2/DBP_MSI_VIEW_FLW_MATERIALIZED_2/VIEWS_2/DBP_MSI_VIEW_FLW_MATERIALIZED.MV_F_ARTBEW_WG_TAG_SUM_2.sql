create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_ARTBEW_WG_TAG_SUM_2(
	DAT,
	MANDANT_ID,
	WG_ID,
	ARTHIERTYP_ID,
	IN_KUNDE_ID,
	UMSATZ_NETTO,
	EK_MEP_UMSATZ_TEMP,
	EK_MEP_UMSATZ,
	BEWART_ID,
	WRG_ID
) as
SELECT
    v01.dat,
    v01.mandant_id,
    v01.wg_id,
    v01.arthiertyp_id,
    in_kunde_id,
    CAST(
        CASE
            WHEN v200.wrg_typ_id = 0 THEN COALESCE(v01.umsatz_netto, 0) * v500.umrechnungskurs -- umsatz_netto ist immer in Landeswaehrung -> wird fuer User in Landeswaehrung angezeigt
            WHEN v200.wrg_typ_id = 1 THEN COALESCE(v01.umsatz_netto, 0)
        END AS DECIMAL(18, 4)
    ) AS umsatz_netto,
    ek_mep_umsatz_temp,
    CAST(
        CASE
            WHEN v200.wrg_typ_id = 0 THEN COALESCE(ek_mep_umsatz_temp, 0) * v500.umrechnungskurs -- ek_mep_umsatz_temp ist immer in Landeswaehrung -> wird fuer User in Landeswaehrung angezeigt
            WHEN v200.wrg_typ_id = 1 THEN COALESCE(ek_mep_umsatz_temp, 0)
        END AS DECIMAL(18, 4)
    ) AS ek_mep_umsatz,
    v01.bewart_id,
    v400.wrg_id
FROM
    DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_ARTBEW_WG_TAG_SUM_2 v01
       CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
       CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300
       JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
       ON v01.mandant_id = v400.mandant_id
       AND v200.wrg_typ_id = v400.wrg_typ_id
       LEFT OUTER JOIN dbp_view.v_kurs_2 v500
       ON v300.kurstyp_id = v500.kurstyp_id
       AND v01.default_wrg = v500.von_wrg_id
       AND v500.nach_wrg_id ='EUR'
       AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis
WHERE
    v01.mandant_id IN (1, 2)
    AND v01.arthiertyp_id = 2;