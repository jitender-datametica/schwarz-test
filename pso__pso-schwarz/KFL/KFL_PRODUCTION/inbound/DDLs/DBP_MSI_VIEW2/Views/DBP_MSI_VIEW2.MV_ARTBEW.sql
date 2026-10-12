CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTBEW (
    art_id,
    bewart_id,
    bewart_det_id,
    dat,
    diff_logkostenzuschlag_konz,
    diff_ek_brutto_ums_konz,
    diff_ek_kbasis_ums_konz,
    diff_ek_mep_ums_konz,
    diff_ek_n_ums_konz,
    diff_ek_nn_ums_konz,
    diff_mwst_betrag_ums_konz,
    diff_netto_ums_konz,
    ek_brutto_Umsatz,
    ek_kbasis_Umsatz,
    ek_mep_Umsatz,
    ek_n_Umsatz,
    ek_nn_Umsatz,
    gp_id,
    herst_id,
    mandant_id,
    mwst_id,
    nb_id,
    umsatz_mwst_betrag,
    umsatz_netto,
    VK_Menge,
    wrg,
    wup_id,
    diff_ek_nn2_ums_konz,
    diff_ek_kl_ums_konz,
    ek_kl_umsatz,
    ek_nn2_Umsatz,
    bezugsweg_id,
    logkostenzuschlag,
    ek_netto_bnk_umsatz,
    ek_netto_bnk_sachk_umsatz,
    aktion_id,
    posten_id,
    posten_kz,
    posten_id_per,
    posten_kz_per,
    ean_kasse,
    bq_findung_id,
    wup_bereinigt_fg,
    wup_bereinigt_fg_vj,
    wup_bereinigt_fg_vj_wo
) AS
-- 20231205 WUP Bereinigt Berechnung voruebergehend hier berechnen. Zukuenftig soll es direkt in der ARTBEW vorhanden sein  
WITH t_wup_bereinigt AS(
    SELECT
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        --SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' 
            THEN wup_bereinigt_fg_vj_wo
        WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) 
            THEN 1 
        ELSE 0 END AS wup_bereinigt_fg_vj
    FROM dbp_view.v_tag v01
    JOIN dbp_view.v_wup v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN dbp_view.v_tag v03
        ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN dbp_view.v_tag v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
        AND v02.nb_id = 0
        AND v02.mandant_id = 1
)

SELECT
    v1.art_id,
    bewart_id,
    bewart_det_id,
    v1.dat,
    CAST(diff_logkostenzuschlag_konz AS NUMBER(38, 5)),
    CAST(diff_ek_brutto_konz AS NUMBER(38, 5)),
    CAST(diff_ek_kal_basis_konz AS NUMBER(38, 5)),
    CAST(diff_ek_mep_konz AS NUMBER(38, 5)),
    CAST(diff_ek_netto_konz AS NUMBER(38, 5)),
    CAST(diff_ek_nettonetto_konz AS NUMBER(38, 5)),
    CAST(diff_umsatz_mwst_betrag_konz AS NUMBER(38, 5)),
    CAST(diff_umsatz_netto_konz AS NUMBER(38, 5)),
    CAST(ek_brutto AS NUMBER(38, 5)),
    CAST(ek_kal_basis AS NUMBER(38, 5)),
    CAST(ek_mep AS NUMBER(38, 5)),
    CAST(ek_netto AS NUMBER(38, 5)),
    CAST(ek_nettonetto AS NUMBER(38, 5)),
    gp_id,
    herst_id,
    v1.mandant_id,
    v1.mwst_id,
    nb_id,
    CAST(umsatz_mwst_betrag AS NUMBER(38, 5)),
    CAST(umsatz_netto AS NUMBER(38, 5)),
    CAST(menge AS NUMBER(38, 5)),
    wrg,
    v1.wup_id,
    (
        diff_ek_kal_basis_konz - diff_logkostenzuschlag_konz
    ) diff_ek_nn2_ums_konz,
    CAST(diff_einstandspreis_konz AS NUMBER(38, 5)),
    CAST(einstandspreis AS NUMBER(38, 5)),
    (ek_kal_basis - logkostenzuschlag) ek_nn2_Umsatz,
    bezugsweg_id,
    CAST(logkostenzuschlag AS NUMBER(38, 5)),
    CAST(ek_netto_bnk AS NUMBER(38, 5)),
    CAST(ek_netto_bnk_sachk AS NUMBER(38, 5)),
    COALESCE (v1.standard_aktion_id, v1.aktion_id, '0') AS aktion_id,
    CASE
        WHEN BEWART_ID = 1001
        AND v1.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN ''
        ELSE 'PN'
    END :: CHAR(2) AS POSTEN_ID_,
    CASE
        WHEN v1.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
        ELSE 'PN'
    END :: CHAR(2) AS POSTEN_KZ,
    CASE
        WHEN BEWART_ID = 1001
        AND v2.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN ''
        ELSE 'PN'
    END :: CHAR(2) AS POSTEN_ID_PER,
    CASE
        WHEN v2.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO'
        ELSE 'PN'
    END :: CHAR(2) AS POSTEN_KZ_PER,
    (
        CASE
            WHEN ean_kasse BETWEEN 100000
            AND 999999 THEN ean_kasse * 10000000 -- 10 Millionen
            ELSE ean_kasse
        END
    ) AS ean_kasse,
    bq_findung_id,
    wup_bereinigt_fg_akt AS wup_bereinigt_fg,
    wup_bereinigt_fg_vj,
    wup_bereinigt_fg_vj_wo
FROM
    dbp_view.v_artbew v1

LEFT JOIN dbp_view.v_art_per v2
ON v1.art_id = v2.art_id
AND v1.mandant_id = v2.mandant_id
AND v1.dat BETWEEN v2.dat_von-1 AND v2.dat_bis-1

LEFT JOIN t_wup_bereinigt v3
ON v1.dat = v3.dat 
AND v1.mandant_id = v3.mandant_id 
AND v1.wup_id = v3.wup_id

WHERE v1.mandant_id = 1;