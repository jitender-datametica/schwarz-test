create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_KALK_OUTPUT(
	MANDANT_ID,
	SCHNITTLISTE_ID,
	SEK_SCHL_ID,
	SEK_SCHL_TYP_ID,
	WERK_ID,
	IN_ART_ID,
	DAT_KALK_AB,
	DAT_KALK_BIS,
	KALK_NR,
	KALK_BEZ,
	KALK_KENNZ,
	WRG_ID_ORG,
	WRG_ID,
	SCHNITT_ID,
	SCHNITT_POS_ID,
	MENGE_SCHNITT,
	BETRAG_SCHNITT_OUTPUT,
	FERTIG_EINZEL_KOSTEN_KG,
	FERTIG_EINZEL_KOSTEN_GESAMT,
	KALK_VARIANTE_ID
) as
SELECT
    v10.mandant_id,
    v10.schnittliste_id,
    v17.sek_schl_id,
    v17.sek_schl_typ_id,
    v10.werk_id,
    v17.flw_art_id AS in_art_id,
    v10.dat_kalk_ab,
    v10.dat_kalk_bis,
    v10.kalk_nr,
    v10.kalk_bez,
    v10.kalk_kennz,
    v19.wrg_id AS wrg_org,
    v400.wrg_id,
    v17.schnitt_id,
    v17.schnitt_pos_id,
    MAX(v17.menge_schnitt) AS menge_schnitt,
    SUM(
        CAST(
            CASE
                WHEN v17.wrg_id <> v100.default_wrg
                AND v200.wrg_typ_id = 0 THEN COALESCE(v17.betrag_schnitt_output, 0)
                WHEN v17.wrg_id <> v100.default_wrg
                AND v200.wrg_typ_id = 1 THEN (
                    COALESCE(v17.betrag_schnitt_output, 0) / v500.umrechnungskurs
                )
                WHEN v17.wrg_id = v100.default_wrg
                AND v200.wrg_typ_id = 0 THEN COALESCE(v17.betrag_schnitt_output, 0) * v500.umrechnungskurs
                WHEN v17.wrg_id = v100.default_wrg
                AND v200.wrg_typ_id = 1 THEN COALESCE(v17.betrag_schnitt_output, 0)
            END AS DECIMAL(18, 6)
        )
    ) AS betrag_schnitt_output,
    SUM(
        CAST(
            CASE
                WHEN v19.wrg_id <> v100.default_wrg
                AND v200.wrg_typ_id = 0 THEN COALESCE(v19.fertig_einzel_kosten_kg, 0)
                WHEN v19.wrg_id <> v100.default_wrg
                AND v200.wrg_typ_id = 1 THEN (
                    COALESCE(v19.fertig_einzel_kosten_kg, 0) / v500.umrechnungskurs
                )
                WHEN v19.wrg_id = v100.default_wrg
                AND v200.wrg_typ_id = 0 THEN COALESCE(v19.fertig_einzel_kosten_kg, 0) * v500.umrechnungskurs
                WHEN v19.wrg_id = v100.default_wrg
                AND v200.wrg_typ_id = 1 THEN COALESCE(v19.fertig_einzel_kosten_kg, 0)
            END AS DECIMAL(18, 6)
        )
    ) AS fertig_einzel_kosten_kg,
    SUM(
        CAST(
            CASE
                WHEN v19.wrg_id <> v100.default_wrg
                AND v200.wrg_typ_id = 0 THEN COALESCE(v19.fertig_einzel_kosten_gesamt, 0)
                WHEN v19.wrg_id <> v100.default_wrg
                AND v200.wrg_typ_id = 1 THEN (
                    COALESCE(v19.fertig_einzel_kosten_gesamt, 0) / v500.umrechnungskurs
                )
                WHEN v19.wrg_id = v100.default_wrg
                AND v200.wrg_typ_id = 0 THEN COALESCE(v19.fertig_einzel_kosten_gesamt, 0) * v500.umrechnungskurs
                WHEN v19.wrg_id = v100.default_wrg
                AND v200.wrg_typ_id = 1 THEN COALESCE(v19.fertig_einzel_kosten_gesamt, 0)
            END AS DECIMAL(18, 6)
        )
    ) AS fertig_einzel_kosten_gesamt,
    v10.kalk_variante_id
FROM
    (
        SELECT
            v01.mandant_id,
            v01.schnittliste_id,
            v01.werk_id,
            v01.dat_kalk_ab,
            v01.dat_kalk_bis,
            v01.plan_kalk_id AS kalk_nr,
            v02.plan_kalk_bez AS kalk_bez,
            CAST('PK' AS CHAR(3)) AS kalk_kennz,
            v01.kalk_variante_id AS kalk_variante_id
        FROM
            dbp_view.v_flw_kalk_plan v01
            LEFT OUTER JOIN dbp_view.v_flw_kalk_plan_spr_zu v02 ON v01.mandant_id = v02.mandant_id
            AND v01.plan_kalk_id = v02.plan_kalk_id
            JOIN dbp_msi.akt_msi_user_spr_zu v03 ON v02.spr_id = v03.spr_id
        UNION
        ALL
        SELECT
            v04.mandant_id,
            v04.schnittliste_id,
            v04.werk_id,
            v04.dat_kalk_ab,
            v04.dat_kalk_bis,
            v04.materialwert_kalk_id AS kalk_nr,
            v05.material_kalk_bez AS kalk_bez,
            'MWK' AS kalk_kennz,
            v04.kalk_variante_id
        FROM
            dbp_view.v_flw_kalk_material v04
            LEFT OUTER JOIN dbp_view.v_flw_kalk_material_spr_zu v05 ON v04.mandant_id = v05.mandant_id
            AND v04.materialwert_kalk_id = v05.materialwert_kalk_id
            JOIN dbp_msi.akt_msi_user_spr_zu v06 ON v05.spr_id = v06.spr_id
    ) v10
    JOIN dbp_view.v_flw_schnitt_output_det v17 ON v10.mandant_id = v17.mandant_id
    AND v10.kalk_nr = v17.sek_schl_id
    AND v17.sek_schl_typ_id in ('M', 'P')
    LEFT OUTER JOIN (
        SELECT
            mandant_id,
            sek_schl_id,
            sek_schl_typ_id,
            schnitt_id,
            schnitt_pos_id,
            MAX(wrg_id) AS wrg_id,
            SUM(fertig_einzel_kosten_kg) AS fertig_einzel_kosten_kg,
            SUM(fertig_einzel_kosten_gesamt) AS fertig_einzel_kosten_gesamt
        FROM
            dbp_view.v_flw_schnitt_output_kosten
        WHERE
            sek_schl_typ_id in ('M', 'P')
        GROUP BY
            mandant_id,
            sek_schl_id,
            sek_schl_typ_id,
            schnitt_id,
            schnitt_pos_id
    ) v19 ON v17.mandant_id = v19.mandant_id
    AND v17.sek_schl_id = v19.sek_schl_id
    AND v17.sek_schl_typ_id = v19.sek_schl_typ_id
    AND v17.schnitt_id = v19.schnitt_id
    AND v17.schnitt_pos_id = v19.schnitt_pos_id
    JOIN dbp_view.v_mandant v100 ON v10.mandant_id = v100.mandant_id
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
    CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300
    JOIN dbp_view.v_mandant_wrg_typ_zu v400 ON v10.mandant_id = v400.mandant_id
    AND v200.wrg_typ_id = v400.wrg_typ_id
    LEFT OUTER JOIN dbp_view.v_kurs v500 ON v300.kurstyp_id = v500.kurstyp_id
    AND v19.wrg_id = v500.von_wrg_id
    AND v500.nach_wrg_id = 'EUR'
    AND v10.dat_kalk_ab BETWEEN v500.dat_von
    AND v500.dat_bis
GROUP BY
    v10.mandant_id,
    v10.schnittliste_id,
    v17.sek_schl_id,
    v17.sek_schl_typ_id,
    v10.werk_id,
    v17.flw_art_id,
    v10.dat_kalk_ab,
    v10.dat_kalk_bis,
    v10.kalk_nr,
    v10.kalk_bez,
    v10.kalk_kennz,
    v19.wrg_id,
    v400.wrg_id,
    v17.schnitt_id,
    v17.schnitt_pos_id,
    v10.kalk_variante_id;