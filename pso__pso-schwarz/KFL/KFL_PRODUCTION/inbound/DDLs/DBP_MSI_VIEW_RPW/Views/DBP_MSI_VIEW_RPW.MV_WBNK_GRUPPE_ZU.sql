CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WBNK_GRUPPE_ZU
 (
 system_id
 ,mandant_id
 ,wbnkart_id
 ,row_grund_id
 ,konditionsart_id
 ,wbnk_gruppe_id
 ,wbnk_gruppe_bez
 ,wbnk_bez
 )
 AS
    SELECT
    7,
    v01.mandant_id,
    v01.wbnk_id AS wbnkart_id,
    CASE WHEN SUBSTR( v01.wbnk_id, 1, 2) <> 'YN' THEN v01.wbnk_id ELSE '0'
    END as konditionsart_id,
    CASE WHEN SUBSTR( v01.wbnk_id, 1, 2) = 'YN' THEN v01.wbnk_id ELSE '0'
    END as row_grund_id,
    v01.wbnk_gruppe_id,
    v02.wbnk_gruppe_bez,
    v03.wbnk_bez
    FROM dbp_view.v_wbnk_gruppe_zu v01
    INNER JOIN dbp_view.v_wbnk_gruppe_spr_zu v02
    ON v01.mandant_id = v02.mandant_id AND
    v01.wbnk_gruppe_id = v02.wbnk_gruppe_id AND
    v02.spr_id = 22
    INNER JOIN dbp_view.v_wbnk_spr_zu v03
    ON v01.mandant_id = v03.mandant_id AND
    v01.wbnk_id = v03.wbnk_id AND
    v03.spr_id = 22

    WHERE v01.mandant_id =1;