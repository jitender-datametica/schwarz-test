CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_BEREICH_SPR_ZU_1(
	BER_ID,
	BER_BEZ,
	BER_BEZ_DE,
	BER_BEZ_CZ,
	BER_BEZ_SK,
	BER_BEZ_HR,
	BER_BEZ_PL,
	BER_BEZ_RO,
	BER_BEZ_BG,
	MANDANT_ID,
	ARTHIERTYP_ID
) AS SELECT
    v01.wg_hierarchie_id AS ber_id, Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v02.wg_hierarchie_bez END),'N/A') AS ber_bez  -- Standard == DE
    ,Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v02.wg_hierarchie_bez END),'N/A') AS ber_bez_de                              -- DE
    ,Coalesce(Max(CASE WHEN v02.spr_id = 124  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_cz                         -- CZ
    ,Coalesce(Max(CASE WHEN v02.spr_id = 108  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_sk                         -- SK
    ,Coalesce(Max(CASE WHEN v02.spr_id =  65  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_hr                        -- HR
    ,Coalesce(Max(CASE WHEN v02.spr_id =  90  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_pl                        -- PL
    ,Coalesce(Max(CASE WHEN v02.spr_id =  95  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_ro                        -- RO
    ,Coalesce(Max(CASE WHEN v02.spr_id =  18  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_bg                        -- BG
    ,v01.mandant_id, v01.arthiertyp_id
FROM dbp_view.v_wg_hierarchie_zu_per_1 v01
INNER JOIN dbp_view.v_wg_hierarchie_spr_zu_1 v02
    ON v02.mandant_id = v01.mandant_id
    AND v02.wg_hierarchie_ebene_id = v01.wg_hierarchie_ebene_id
    AND v02.wg_hierarchie_id = v01.wg_hierarchie_id
    AND v02.arthiertyp_id = v01.arthiertyp_id
WHERE v01.arthiertyp_id = 10
    AND v01.wg_hierarchie_ebene_id = 1
    AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis
GROUP BY
    v01.wg_hierarchie_id
    ,v01.mandant_id
    ,v01.arthiertyp_id;